Write-Host "Setting up Apache Tomcat for BookMyCar project..." -ForegroundColor Green

# Create tomcat directory if it doesn't exist
$tomcatDir = "tomcat"
if (!(Test-Path $tomcatDir)) {
    New-Item -ItemType Directory -Path $tomcatDir -Force
}

# Download Apache Tomcat 9.0.85 (compatible with Java 17)
$tomcatUrl = "https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.zip"
$tomcatZip = "$tomcatDir\tomcat.zip"

Write-Host "Downloading Apache Tomcat 9.0.85..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $tomcatUrl -OutFile $tomcatZip
    Write-Host "Tomcat downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to download Tomcat: $_" -ForegroundColor Red
    exit 1
}

# Extract Tomcat
Write-Host "Extracting Tomcat..." -ForegroundColor Yellow
try {
    Expand-Archive -Path $tomcatZip -DestinationPath $tomcatDir -Force
    Write-Host "Tomcat extracted successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to extract Tomcat: $_" -ForegroundColor Red
    exit 1
}

# Clean up zip file
Remove-Item $tomcatZip

# Copy the web application to Tomcat webapps directory
$webappDir = "$tomcatDir\apache-tomcat-9.0.85\webapps\BookMyCar"
if (Test-Path $webappDir) {
    Remove-Item $webappDir -Recurse -Force
}

Write-Host "Setting up web application..." -ForegroundColor Yellow

# Create webapp directory structure
New-Item -ItemType Directory -Path $webappDir -Force
New-Item -ItemType Directory -Path "$webappDir\WEB-INF" -Force
New-Item -ItemType Directory -Path "$webappDir\WEB-INF\classes" -Force
New-Item -ItemType Directory -Path "$webappDir\WEB-INF\lib" -Force

# Copy compiled classes
Copy-Item -Path "build\classes\*" -Destination "$webappDir\WEB-INF\classes" -Recurse -Force

# Copy JSP files and other web resources
Copy-Item -Path "src\main\webapp\*.jsp" -Destination $webappDir -Force
Copy-Item -Path "src\main\webapp\*.png" -Destination $webappDir -Force
Copy-Item -Path "src\main\webapp\*.avif" -Destination $webappDir -Force
Copy-Item -Path "src\main\webapp\*.svg" -Destination $webappDir -Force
Copy-Item -Path "src\main\webapp\css" -Destination $webappDir -Recurse -Force

# Copy JAR files
Copy-Item -Path "src\main\webapp\WEB-INF\lib\*" -Destination "$webappDir\WEB-INF\lib" -Force

# Copy web.xml
Copy-Item -Path "src\main\webapp\WEB-INF\web.xml" -Destination "$webappDir\WEB-INF\web.xml" -Force

Write-Host "Web application setup completed!" -ForegroundColor Green
Write-Host "Tomcat is ready to run at: $tomcatDir\apache-tomcat-9.0.85" -ForegroundColor Green
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
