Write-Host "Deploying BookMyCar application to existing Tomcat..." -ForegroundColor Green

# Ask user for Tomcat installation path
Write-Host "Please enter the path to your Tomcat installation (e.g., C:\Program Files\Apache Software Foundation\Tomcat 9.0):" -ForegroundColor Yellow
$tomcatPath = Read-Host

if (!(Test-Path $tomcatPath)) {
    Write-Host "Error: Tomcat path not found!" -ForegroundColor Red
    exit 1
}

# Verify it's a Tomcat installation
if (!(Test-Path "$tomcatPath\webapps")) {
    Write-Host "Error: Invalid Tomcat installation. 'webapps' directory not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Tomcat installation found at: $tomcatPath" -ForegroundColor Green

# Create webapp directory for BookMyCar
$webappDir = "$tomcatPath\webapps\BookMyCar"
if (Test-Path $webappDir) {
    Write-Host "Removing existing BookMyCar deployment..." -ForegroundColor Yellow
    Remove-Item $webappDir -Recurse -Force
}

Write-Host "Creating web application directory..." -ForegroundColor Yellow

# Create webapp directory structure
New-Item -ItemType Directory -Path $webappDir -Force
New-Item -ItemType Directory -Path "$webappDir\WEB-INF" -Force
New-Item -ItemType Directory -Path "$webappDir\WEB-INF\classes" -Force
New-Item -ItemType Directory -Path "$webappDir\WEB-INF\lib" -Force

# Copy compiled classes
Write-Host "Copying compiled classes..." -ForegroundColor Yellow
Copy-Item -Path "build\classes\*" -Destination "$webappDir\WEB-INF\classes" -Recurse -Force

# Copy JSP files and other web resources
Write-Host "Copying web resources..." -ForegroundColor Yellow
Copy-Item -Path "src\main\webapp\*.jsp" -Destination $webappDir -Force
Copy-Item -Path "src\main\webapp\*.png" -Destination $webappDir -Force
Copy-Item -Path "src\main\webapp\*.avif" -Destination $webappDir -Force
Copy-Item -Path "src\main\webapp\*.svg" -Destination $webappDir -Force
Copy-Item -Path "src\main\webapp\css" -Destination $webappDir -Recurse -Force

# Copy JAR files
Write-Host "Copying JAR dependencies..." -ForegroundColor Yellow
Copy-Item -Path "src\main\webapp\WEB-INF\lib\*" -Destination "$webappDir\WEB-INF\lib" -Force

# Copy web.xml
Copy-Item -Path "src\main\webapp\WEB-INF\web.xml" -Destination "$webappDir\WEB-INF\web.xml" -Force

Write-Host "Deployment completed successfully!" -ForegroundColor Green
Write-Host "Application deployed to: $webappDir" -ForegroundColor Green
Write-Host "You can now access the application at: http://localhost:8080/BookMyCar" -ForegroundColor Green

# Check if Tomcat is running
Write-Host "Checking if Tomcat is running..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080" -TimeoutSec 5 -ErrorAction Stop
    Write-Host "Tomcat is running!" -ForegroundColor Green
} catch {
    Write-Host "Tomcat is not running. Please start Tomcat first." -ForegroundColor Yellow
    Write-Host "You can start Tomcat by running: $tomcatPath\bin\startup.bat" -ForegroundColor Cyan
}

Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
