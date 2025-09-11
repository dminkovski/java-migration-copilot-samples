#!/bin/bash

# Post-create script for Java Spring Boot DevContainer
echo "Setting up Java development environment..."

# Install SDKMAN if not already installed
if [ ! -d "/usr/local/sdkman" ]; then
    echo "Installing SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
    source "/usr/local/sdkman/bin/sdkman-init.sh"
fi

# Source SDKMAN
source "/usr/local/sdkman/bin/sdkman-init.sh"

# Install multiple Java versions for app modernization scenarios
echo "Installing Java version..."
# sdk install java 8.0.422-amzn || true
# sdk install java 11.0.24-amzn || true
# sdk install java 17.0.12-amzn || true
sdk install java 21.0.4-amzn || true

# Set Java 21 as default (can be changed based on project needs)
sdk default java 21.0.4-amzn

# Install Maven (latest version)
echo "Installing Maven..."
sdk install maven || true

# Install Gradle
# echo "Installing Gradle..."
# sdk install gradle || true

# Update package list and install additional tools
echo "Installing additional development tools..."
sudo apt-get update
sudo apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    jq \
    tree \
    htop

# Make Maven wrapper executable
if [ -f "./mvnw" ]; then
    chmod +x ./mvnw
    echo "Maven wrapper made executable"
fi

# Install AppCAT CLI for application assessment (useful for modernization)
echo "Installing AppCAT CLI for application assessment..."
# Prefer a local packaged folder if present, otherwise download and extract the release
if ls azure-migrate-appcat-for-java-cli-linux-amd64-* 1> /dev/null 2>&1; then
    APP_DIR=$(ls -d azure-migrate-appcat-for-java-cli-linux-amd64-* 2>/dev/null | head -n1)
else
    # Download and extract the release
    curl -L https://aka.ms/appcat/azure-migrate-appcat-for-java-cli-linux-amd64.tar.gz | tar -xz
    APP_DIR=$(ls -d azure-migrate-appcat-for-java-cli-linux-amd64-* 2>/dev/null | head -n1)
fi

# Move the entire package directory into /usr/local/bin so its subfiles remain available to the tool,
# then create a symlink named 'appcat' in /usr/local/bin pointing to the packaged executable.
if [ -n "$APP_DIR" ] && [ -d "$APP_DIR" ]; then
    sudo mv "$APP_DIR" /usr/local/bin/
    sudo chmod -R a+rX "/usr/local/bin/$APP_DIR"
    if [ -f "/usr/local/bin/$APP_DIR/appcat" ]; then
        sudo ln -sf "/usr/local/bin/$APP_DIR/appcat" /usr/local/bin/appcat
        sudo chmod +x "/usr/local/bin/$APP_DIR/appcat"
    fi
elif [ -f "./appcat" ]; then
    sudo mv ./appcat /usr/local/bin/
    sudo chmod +x /usr/local/bin/appcat
else
    echo "Warning: appcat binary or package not found. You may need to install it manually."
fi

# Ensure /usr/local/bin is added to user's PATH for interactive shells
if ! grep -q '/usr/local/bin' ~/.bashrc; then
    echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
fi

# Add a system-wide profile script so non-interactive/other users also see appcat in PATH
sudo bash -c 'cat > /etc/profile.d/appcat.sh <<"EOF"
# Add appcat to PATH
export PATH="/usr/local/bin:\$PATH"
EOF'
sudo chmod +x /etc/profile.d/appcat.sh

# Create development directories
mkdir -p ~/workspace/tools
mkdir -p ~/workspace/scripts

echo "✅ DevContainer setup completed successfully!"
echo ""
echo "Available Java versions:"
sdk list java | grep installed || echo "Run 'sdk list java' to see available versions"
echo ""
echo "Useful commands:"
echo "  - sdk use java <version>   : Switch Java version"
echo "  - mvn spring-boot:run     : Run Spring Boot application"
echo "  - mvn clean package       : Build the application"
echo "  - appcat assess           : Assess application for modernization"
echo ""
echo "The development environment is ready for GitHub Copilot App Modernization!"
