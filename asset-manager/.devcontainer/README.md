# DevContainer for Java Spring Boot with GitHub Copilot App Modernization

This DevContainer configuration provides a complete development environment for Java Spring Boot applications with support for GitHub Copilot App Modernization for Java.

## Features

### 🐳 Container Base
- **Base Image**: `mcr.microsoft.com/devcontainers/java:1-21-bullseye`
- **Docker-in-Docker**: Enabled for containerization workflows
- **Azure CLI**: Pre-installed for Azure deployment scenarios
- **GitHub CLI**: For GitHub integration and automation

### ☕ Java Development
- **Multiple Java Versions**: Java 8, 11, 17, and 21 via SDKMAN
- **Build Tools**: Maven and Gradle
- **Spring Boot Support**: Complete Spring Boot development stack

### 🚀 GitHub Copilot Extensions
- **GitHub Copilot**: AI-powered code completion
- **GitHub Copilot Chat**: Interactive AI assistance
- **GitHub Copilot App Modernization for Java**: Specialized tools for Java application modernization

### 🛠️ Development Tools
- **Java Extension Pack**: Complete Java development experience
- **Spring Boot Extensions**: Spring Boot dashboard and tools
- **Testing Framework**: JUnit and testing extensions
- **Docker Support**: Docker extension for container management
- **Azure Tools**: Azure development extensions

## Getting Started

### Prerequisites
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### Usage

1. **Open in DevContainer**:
   - Open the project in VS Code
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Select "Dev Containers: Reopen in Container"
   - Wait for the container to build and configure

2. **Verify Setup**:
   ```bash
   # Check Java version
   java -version
   
   # Check Maven
   mvn -version
   
   # List available Java versions
   sdk list java
   ```

3. **Run the Application**:
   ```bash
   # Using Maven wrapper
   ./mvnw spring-boot:run
   
   # Or using Maven directly
   mvn spring-boot:run
   ```

## Available Ports

- **8080**: Spring Boot Application (auto-forwarded)
- **3000**: Additional web services
- **5005**: Java Debug Port (for remote debugging)

## Java Version Management

Switch between Java versions using SDKMAN:

```bash
# List installed versions
sdk list java

# Use a specific version for current session
sdk use java 17.0.12-amzn

# Set default version
sdk default java 11.0.24-amzn
```

## Application Modernization Features

This DevContainer is specifically configured for GitHub Copilot App Modernization for Java:

### Assessment Tools
- **AppCAT CLI**: Pre-installed for application assessment
- **Migration Analysis**: Built-in tools for analyzing modernization opportunities

### Modernization Workflows
1. **Assessment**: Use AppCAT to assess the current application
2. **Planning**: Leverage Copilot to plan modernization steps
3. **Implementation**: Use AI-assisted code generation for updates
4. **Testing**: Comprehensive testing with multiple Java versions

### Example Commands
```bash
# Assess application for cloud readiness
appcat assess --source . --target azure

# Run tests with different Java versions
sdk use java 8.0.422-amzn && mvn test
sdk use java 11.0.24-amzn && mvn test
sdk use java 17.0.12-amzn && mvn test
```

## Development Workflow

### Building the Project
```bash
# Clean and compile
mvn clean compile

# Run tests
mvn test

# Package application
mvn clean package

# Run with specific profile
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

### Docker Integration
```bash
# Build Docker image
docker build -t bus-reservation .

# Run with Docker Compose
docker-compose up -d
```

## Troubleshooting

### Java Version Issues
If you encounter Java version conflicts:
1. Check current version: `java -version`
2. Switch to correct version: `sdk use java <version>`
3. Reload VS Code window if needed

### Extension Issues
If extensions don't load properly:
1. Reload the window: `Ctrl+Shift+P` → "Developer: Reload Window"
2. Rebuild container: `Ctrl+Shift+P` → "Dev Containers: Rebuild Container"

### Port Conflicts
If ports are already in use:
1. Check running processes: `netstat -tulpn | grep :8080`
2. Update port in `application.properties` or use environment variables

## Customization

### Adding Extensions
Edit `.devcontainer/devcontainer.json` and add extensions to the `extensions` array:

```json
"extensions": [
  "your.extension.id"
]
```

### Environment Variables
Add environment variables in the `containerEnv` section:

```json
"containerEnv": {
  "CUSTOM_VAR": "value"
}
```

### Additional Tools
Modify `.devcontainer/post-create.sh` to install additional tools.

## Support

For issues related to:
- **DevContainer**: Check VS Code Dev Containers documentation
- **Java Development**: Refer to Java Extension Pack documentation
- **GitHub Copilot**: Visit GitHub Copilot documentation
- **App Modernization**: Check GitHub Copilot App Modernization for Java documentation
