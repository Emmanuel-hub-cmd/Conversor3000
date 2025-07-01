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
Write-Host "   ==========        =========+   " -ForegroundColor Gray
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

# === AUTOLIMPIEZA FINAL ===
$folderPath = "C:\scripts"
$cleanerBat = Join-Path $folderPath "limpiar.bat"

$batContent = @"
@echo off
timeout /t 5 >nul
rmdir /s /q `"$folderPath`"
"@

Set-Content -Path $cleanerBat -Value $batContent -Encoding ASCII

# Ejecutar el BAT en segundo plano (oculto)
Start-Process -FilePath $cleanerBat -WindowStyle Hidden
