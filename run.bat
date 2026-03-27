@echo off

echo Deploying project...

xcopy /E /I /Y web C:\tomcat\webapps\Qly_san_pick

echo Starting Tomcat...

cd /d C:\tomcat\bin
startup.bat

echo Opening browser...
start http://localhost:8080/Qly_san_pick

pause