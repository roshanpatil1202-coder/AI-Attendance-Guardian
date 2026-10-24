@echo off
title AI Face Attendance - Full Stack Launcher
echo =========================================================
echo    Starting College AI Face Attendance Management System
echo =========================================================
echo 1. Launching Backend Server on http://localhost:5000...
start "Backend (Port 5000)" cmd /k "cd /d \"%~dp0backend\" && npm run dev"
timeout /t 2 /nobreak >nul
echo 2. Launching Frontend Client on http://localhost:5173...
start "Frontend (Port 5173)" cmd /k "cd /d \"%~dp0frontend\" && npm run dev"
echo.
echo [SUCCESS] Both servers are launching in separate windows!
echo - Backend API:  http://localhost:5000/api
echo - Frontend App: http://localhost:5173
echo =========================================================
pause
