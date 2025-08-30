Write-Host "Downloading required dependencies for BookMyCar project..." -ForegroundColor Green

# Create lib directory if it doesn't exist
$libDir = "src\main\webapp\WEB-INF\lib"
if (!(Test-Path $libDir)) {
    New-Item -ItemType Directory -Path $libDir -Force
}

# Download Servlet API 4.0.1 (compatible with Java 17)
$servletApiUrl = "https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar"
$servletApiPath = "$libDir\javax.servlet-api-4.0.1.jar"

Write-Host "Downloading Servlet API..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $servletApiUrl -OutFile $servletApiPath
    Write-Host "Servlet API downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to download Servlet API: $_" -ForegroundColor Red
}

# Download JSTL API
$jstlApiUrl = "https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar"
$jstlApiPath = "$libDir\jstl-1.2.jar"

Write-Host "Downloading JSTL API..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $jstlApiUrl -OutFile $jstlApiPath
    Write-Host "JSTL API downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to download JSTL API: $_" -ForegroundColor Red
}

# Download Apache Commons FileUpload (for file handling)
$fileUploadUrl = "https://repo1.maven.org/maven2/commons-fileupload/commons-fileupload/1.4/commons-fileupload-1.4.jar"
$fileUploadPath = "$libDir\commons-fileupload-1.4.jar"

Write-Host "Downloading Commons FileUpload..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $fileUploadUrl -OutFile $fileUploadPath
    Write-Host "Commons FileUpload downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to download Commons FileUpload: $_" -ForegroundColor Red
}

# Download Apache Commons IO (dependency for FileUpload)
$commonsIoUrl = "https://repo1.maven.org/maven2/commons-io/commons-io/2.11.0/commons-io-2.11.0.jar"
$commonsIoPath = "$libDir\commons-io-2.11.0.jar"

Write-Host "Downloading Commons IO..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $commonsIoUrl -OutFile $commonsIoPath
    Write-Host "Commons IO downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to download Commons IO: $_" -ForegroundColor Red
}

Write-Host "Dependency download completed!" -ForegroundColor Green
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
