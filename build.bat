@echo off
echo Building BookMyCar project...

REM Create build directory if it doesn't exist
if not exist "build\classes" mkdir "build\classes"

REM Set classpath with all required JAR files
set CLASSPATH=src\main\webapp\WEB-INF\lib\derby.jar;src\main\webapp\WEB-INF\lib\gson-2.10.1-javadoc.jar;src\main\webapp\WEB-INF\lib\json-20140107.jar

REM Compile all Java files
echo Compiling Java source files...
javac -cp "%CLASSPATH%" -d build\classes ^
  src\main\java\in\sp\backend\*.java ^
  src\main\java\in\sp\backend\bean\*.java ^
  src\main\java\in\sp\backend\dao\*.java

if %ERRORLEVEL% EQU 0 (
    echo Build successful!
    echo Compiled classes are in build\classes directory
) else (
    echo Build failed with error code %ERRORLEVEL%
)

pause
