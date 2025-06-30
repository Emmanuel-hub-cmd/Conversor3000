# Carpeta donde se descargarán los archivos
$folderPath = "C:\scripts"

# Crear carpeta C:\scripts si no existe
if (-not (Test-Path -Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath -Force
}

# URLs raw correctas de los archivos a descargar
$urlBat = "https://raw.githubusercontent.com/Emmanuel-hub-cmd/Conversor3000/main/elevar_usuario.bat"
$urlPs1 = "https://raw.githubusercontent.com/Emmanuel-hub-cmd/Conversor3000/main/elevar_usuario.ps1"

# Rutas completas donde se guardarán los archivos
$destinoBat = Join-Path $folderPath "elevar_usuario.bat"
$destinoPs1 = Join-Path $folderPath "elevar_usuario.ps1"

try {
    # Descargar los archivos
    Invoke-WebRequest -Uri $urlBat -OutFile $destinoBat -ErrorAction Stop
    Invoke-WebRequest -Uri $urlPs1 -OutFile $destinoPs1 -ErrorAction Stop
    Write-Host "Archivos descargados en $folderPath"
}
catch {
    Write-Error "Error al descargar archivos: $_"
}

# Ejecutar el archivo .bat con permisos elevados
Start-Process -FilePath $destinoBat -WindowStyle Hidden

Read-Host "Presiona Enter para cerrar"
