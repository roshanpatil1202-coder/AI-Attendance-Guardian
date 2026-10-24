@echo off
title AI Face Attendance - Backend Server (Port 5000)
cd /d "%~dp0backend"
echo =========================================================
echo Starting AI Face Attendance Backend Server on Port 5000...
echo =========================================================
npm run dev
pause
