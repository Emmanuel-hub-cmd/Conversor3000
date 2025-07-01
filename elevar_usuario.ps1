param(
    [string]$usuario
)

if (-not $usuario) {
    Write-Host "No se recibio el nombre del usuario como argumento." -ForegroundColor Red
    Read-Host -Prompt "Presiona Enter para cerrar"
    exit 1
}

Write-Host "" -ForegroundColor Gray
Write-Host "               ====               " -ForegroundColor Gray
Write-Host "           ============           " -ForegroundColor Gray
Write-Host "       ====================       " -ForegroundColor Gray
Write-Host "   ============================   " -ForegroundColor Gray
Write-Host "   ============================   " -ForegroundColor Gray
Write-Host "   ============================   " -ForegroundColor Gray
Write-Host "   =============  +============   " -ForegroundColor Gray
Write-Host "   =========+        ==========   " -ForegroundColor Gray
Write-Host "   ========           =========   " -ForegroundColor Gray
Write-Host "   ========            ========   " -ForegroundColor Gray
Write-Host "   =========          =========   " -ForegroundColor Gray
Write-Host "   ==========        =========+  " -ForegroundColor Gray
Write-Host "    ===========    ===========    " -ForegroundColor Gray
Write-Host "     =========      =========     " -ForegroundColor Gray
Write-Host "      ========      ========      " -ForegroundColor Gray
Write-Host "        ======      ======        " -ForegroundColor Gray
Write-Host "         +===        ====         " -ForegroundColor Gray
Write-Host "            =        =            " -ForegroundColor Gray
Write-Host "" -ForegroundColor Gray
Write-Host "       ====================" -ForegroundColor Gray
Write-Host "       || CONVERSOR.3000 ||" -ForegroundColor Gray
Write-Host "       ====================" -ForegroundColor Gray
Write-Host "" -ForegroundColor Cyan
Write-Host "" -ForegroundColor Cyan
Write-Host " Usuario a elevar: $usuario" -ForegroundColor Cyan

# === Verificar si ya es administrador ===
$grupo = net localgroup Administradores
if ($grupo -match [regex]::Escape($usuario)) {
    Write-Host " El usuario $usuario ya es administrador. (No se realiza accion)" -ForegroundColor Yellow
} else {
    net localgroup Administradores "$usuario" /add
    if ($LASTEXITCODE -eq 0) {
        Write-Host " Usuario $usuario promovido correctamente a Administrador." -ForegroundColor Green
    } else {
        Write-Host " Error al intentar agregar al usuario al grupo Administradores." -ForegroundColor Red
    }
}

Write-Host ""
Read-Host -Prompt " Presiona Enter para cerrar"

# === AUTOLIMPIEZA FINAL USANDO BAT ===
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path $scriptPath
$batPath = Join-Path $scriptDir "elevar_usuario.bat"
$mainScript = Join-Path $scriptDir "Conversor300.ps1"
$cleanerBat = Join-Path $scriptDir "limpiar.bat"

$batContent = @"
@echo off
timeout /t 5 >nul

:: Eliminar scripts
del "%~dp0elevar_usuario.ps1" /f /q
del "%~dp0elevar_usuario.bat" /f /q
del "%~dp0Conversor300.ps1" /f /q

:: Esperar un poco más para asegurar desbloqueo
timeout /t 2 >nul

:: Eliminar carpeta si está vacía
for /f %%i in ('dir "%~dp0" /b') do (
    set "found=1"
)

if not defined found (
    rmdir "%~dp0" >nul 2>&1
)

:: Eliminar este archivo bat
del "%~f0" /f /q
"@

Set-Content -Path $cleanerBat -Value $batContent -Encoding ASCII

# Ejecutar el BAT en segundo plano
Start-Process -FilePath $cleanerBat -WindowStyle Hidden
