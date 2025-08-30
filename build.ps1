Write-Host "Building BookMyCar project..." -ForegroundColor Green

# Create build directory if it doesn't exist
if (!(Test-Path "build\classes")) {
    New-Item -ItemType Directory -Path "build\classes" -Force
}

# Set classpath with all required JAR files and source directory
$classpath = @(
    "src\main\java",
    "src\main\webapp\WEB-INF\lib\javax.servlet-api-4.0.1.jar",
    "src\main\webapp\WEB-INF\lib\jstl-1.2.jar",
    "src\main\webapp\WEB-INF\lib\commons-fileupload-1.4.jar",
    "src\main\webapp\WEB-INF\lib\commons-io-2.11.0.jar",
    "src\main\webapp\WEB-INF\lib\derby.jar",
    "src\main\webapp\WEB-INF\lib\gson-2.10.1-javadoc.jar",
    "src\main\webapp\WEB-INF\lib\json-20140107.jar"
) -join ";"

# Get all Java source files
$javaFiles = @()
$javaFiles += Get-ChildItem -Path "src\main\java\in\sp\backend" -Filter "*.java" | ForEach-Object { $_.FullName }
$javaFiles += Get-ChildItem -Path "src\main\java\in\sp\bean" -Filter "*.java" | ForEach-Object { $_.FullName }
$javaFiles += Get-ChildItem -Path "src\main\java\in\sp\dao" -Filter "*.java" | ForEach-Object { $_.FullName }

Write-Host "Found $($javaFiles.Count) Java source files" -ForegroundColor Yellow

# Compile all Java files
Write-Host "Compiling Java source files..." -ForegroundColor Yellow
$javaFilesString = $javaFiles -join " "
$compileCmd = "javac -cp `"$classpath`" -d build\classes $javaFilesString"

Write-Host "Running: $compileCmd" -ForegroundColor Cyan
Invoke-Expression $compileCmd

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful!" -ForegroundColor Green
    Write-Host "Compiled classes are in build\classes directory" -ForegroundColor Green
} else {
    Write-Host "Build failed with error code $LASTEXITCODE" -ForegroundColor Red
}

Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
