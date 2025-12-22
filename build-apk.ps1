# Installation automatique de Flutter et compilation de l'app Glou

Write-Host "Installation et compilation de Glou Android" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

Set-Location $PSScriptRoot

Write-Host "Etape 1/5: Verification de Flutter..." -ForegroundColor Yellow
$flutterExists = Get-Command flutter -ErrorAction SilentlyContinue

if ($flutterExists) {
    Write-Host "Flutter est deja installe!" -ForegroundColor Green
    flutter --version
} else {
    Write-Host "Flutter n'est pas installe." -ForegroundColor Red
    Write-Host ""
    Write-Host "Installation de Flutter via Chocolatey..." -ForegroundColor Yellow
    
    $chocoExists = Get-Command choco -ErrorAction SilentlyContinue
    
    if (-not $chocoExists) {
        Write-Host "Installation de Chocolatey..." -ForegroundColor Yellow
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }
    
    Write-Host "Installation de Flutter..." -ForegroundColor Yellow
    choco install flutter -y
    
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    Write-Host "Flutter installe!" -ForegroundColor Green
}

Write-Host ""
Write-Host "Etape 2/5: Verification de l'environnement..." -ForegroundColor Yellow
flutter doctor -v

Write-Host ""
Write-Host "Etape 3/5: Installation des dependances..." -ForegroundColor Yellow
flutter pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur lors de l'installation des dependances!" -ForegroundColor Red
    exit 1
}

Write-Host "Dependances installees!" -ForegroundColor Green

Write-Host ""
Write-Host "Etape 4/5: Nettoyage..." -ForegroundColor Yellow
flutter clean

Write-Host ""
Write-Host "Etape 5/5: Compilation de l'APK..." -ForegroundColor Yellow
flutter build apk --release

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "SUCCESS! L'application a ete compilee!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Fichier APK:" -ForegroundColor Cyan
    Write-Host "   build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor White
    
    $apkPath = "build\app\outputs\flutter-apk\app-release.apk"
    if (Test-Path $apkPath) {
        $apkSize = (Get-Item $apkPath).Length / 1MB
        Write-Host "   Taille: $([math]::Round($apkSize, 2)) MB" -ForegroundColor White
    }
} else {
    Write-Host ""
    Write-Host "Erreur lors de la compilation!" -ForegroundColor Red
    exit 1
}
