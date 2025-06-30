@echo off
:: === 1. DETECTAR USUARIO ESTÁNDAR ===
for /f "tokens=2 delims=\" %%A in ('whoami') do set "USUARIO=%%A"
echo Usuario estándar detectado: %USUARIO%

:: === 2. LLAMAR AL SCRIPT ELEVADO PASÁNDOLE EL USUARIO COMO ARGUMENTO ===
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0elevar_usuario.ps1\" -usuario \"%USUARIO%\"' -Verb RunAs"

pause
exit /b
