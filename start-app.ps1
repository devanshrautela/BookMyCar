Write-Host "Starting BookMyCar Application..." -ForegroundColor Green

# Check if Tomcat is already running
Write-Host "Checking if Tomcat is running..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080" -TimeoutSec 5 -ErrorAction Stop
    Write-Host "Tomcat is already running!" -ForegroundColor Green
} catch {
    Write-Host "Tomcat is not running. Please start Tomcat first." -ForegroundColor Yellow
    Write-Host "You can start Tomcat by:" -ForegroundColor Cyan
    Write-Host "1. Running the startup.bat file from your Tomcat bin directory" -ForegroundColor Cyan
    Write-Host "2. Or using Windows Services if Tomcat is installed as a service" -ForegroundColor Cyan
    Write-Host ""
}

Write-Host "Application Information:" -ForegroundColor Green
Write-Host "=======================" -ForegroundColor Green
Write-Host "Application Name: BookMyCar" -ForegroundColor White
Write-Host "Access URL: http://localhost:8080/BookMyCar" -ForegroundColor White
Write-Host "Home Page: http://localhost:8080/BookMyCar/index.jsp" -ForegroundColor White
Write-Host ""

Write-Host "Available Pages:" -ForegroundColor Green
Write-Host "================" -ForegroundColor Green
Write-Host "• Home: /index.jsp" -ForegroundColor White
Write-Host "• Login: /login.jsp" -ForegroundColor White
Write-Host "• Register: /register.jsp" -ForegroundColor White
Write-Host "• Browse Cars: /browseCars.jsp" -ForegroundColor White
Write-Host "• Admin Dashboard: /adminDashboard.jsp" -ForegroundColor White
Write-Host ""

Write-Host "To stop Tomcat, run the shutdown.bat file from your Tomcat bin directory" -ForegroundColor Cyan
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
