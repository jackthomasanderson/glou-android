# Installe Android cmdline-tools et accepte licences
# Exécuter avec: powershell -ExecutionPolicy Bypass -File android-sdk-setup.ps1

$ErrorActionPreference = "Stop"

Write-Host "Configuration Android SDK (cmdline-tools + licences)" -ForegroundColor Cyan

# Déduire le chemin SDK depuis flutter doctor
$sdkRoot = "C:\Users\Romain\AppData\Local\Android\sdk"
if (-not (Test-Path $sdkRoot)) {
  $sdkRoot = "C:\Users\Romain\AppData\Local\Android\Sdk"
}
if (-not (Test-Path $sdkRoot)) {
  throw "Android SDK introuvable. Installez Android Studio ou créez $sdkRoot."
}

Write-Host "SDK root: $sdkRoot" -ForegroundColor Yellow

# Préparer cmdline-tools
$cmdLatest = Join-Path $sdkRoot "cmdline-tools\latest"
$cmdBin = Join-Path $cmdLatest "bin"

if (-not (Test-Path $cmdBin)) {
  Write-Host "Téléchargement des cmdline-tools..." -ForegroundColor Yellow
  $zipUrl = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
  $tmpZip = Join-Path $env:TEMP "cmdline-tools.zip"
  Invoke-WebRequest -Uri $zipUrl -OutFile $tmpZip

  Write-Host "Extraction..." -ForegroundColor Yellow
  $tmpExtract = Join-Path $env:TEMP "cmdline-tools-extracted"
  if (Test-Path $tmpExtract) { Remove-Item $tmpExtract -Recurse -Force }
  Expand-Archive -Path $tmpZip -DestinationPath $tmpExtract -Force

  # La racine du zip est 'cmdline-tools' -> déplacer son contenu vers latest
  New-Item -ItemType Directory -Path $cmdLatest -Force | Out-Null
  Copy-Item -Path (Join-Path $tmpExtract "cmdline-tools\*") -Destination $cmdLatest -Recurse -Force
  Remove-Item $tmpZip -Force
  Remove-Item $tmpExtract -Recurse -Force
}

# Mettre cmdline-tools et platform-tools dans PATH pour cette session
$env:PATH = "$cmdBin;" + (Join-Path $sdkRoot "platform-tools") + ";" + $env:PATH

# Vérifier sdkmanager
$sdkManager = Join-Path $cmdBin "sdkmanager.bat"
if (-not (Test-Path $sdkManager)) {
  throw "sdkmanager introuvable à $sdkManager"
}

Write-Host "Installation des composants SDK nécessaires..." -ForegroundColor Yellow
& $sdkManager --install "platform-tools" "platforms;android-34" "build-tools;34.0.0" | Write-Host

Write-Host "Acceptation des licences..." -ForegroundColor Yellow
& $sdkManager --licenses | Write-Host

Write-Host "Vérification Flutter doctor..." -ForegroundColor Yellow
C:\src\flutter\bin\flutter.bat doctor -v | Write-Host

Write-Host "Configuration Android SDK terminée." -ForegroundColor Green
