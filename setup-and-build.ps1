# Script d'installation automatique de Flutter et compilation de l'app Glou
# Execute avec: powershell -ExecutionPolicy Bypass -File setup-and-build.ps1

Write-Host "🚀 Installation et compilation de Glou Android" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier si on est dans le bon dossier
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# 1. Vérifier si Flutter est déjà installé
Write-Host "📋 Étape 1/5: Vérification de Flutter..." -ForegroundColor Yellow
$flutterExists = Get-Command flutter -ErrorAction SilentlyContinue

if ($flutterExists) {
    Write-Host "✅ Flutter est déjà installé!" -ForegroundColor Green
    flutter --version
} else {
    Write-Host "⚠️  Flutter n'est pas installé." -ForegroundColor Red
    Write-Host ""
    Write-Host "📥 Installation de Flutter via Chocolatey..." -ForegroundColor Yellow
    
    # Vérifier si Chocolatey est installé
    $chocoExists = Get-Command choco -ErrorAction SilentlyContinue
    
    if (-not $chocoExists) {
        Write-Host "📦 Installation de Chocolatey d'abord..." -ForegroundColor Yellow
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Recharger le PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }
    
    Write-Host "Installation de Flutter..." -ForegroundColor Yellow
    choco install flutter -y
    
    # Recharger le PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    Write-Host "✅ Flutter installé!" -ForegroundColor Green
}

Write-Host ""
Write-Host "📋 Étape 2/5: Vérification de l'environnement Flutter..." -ForegroundColor Yellow
flutter doctor -v

Write-Host ""
Write-Host "📋 Étape 3/5: Installation des dépendances..." -ForegroundColor Yellow
flutter pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur lors de l'installation des dépendances!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Dépendances installées!" -ForegroundColor Green

Write-Host ""
Write-Host "📋 Étape 4/5: Nettoyage du projet..." -ForegroundColor Yellow
flutter clean

Write-Host ""
Write-Host "📋 Étape 5/5: Compilation de l'APK..." -ForegroundColor Yellow
flutter build apk --release

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ 🎉 L'application a été compilée avec succès!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📦 Fichier APK créé:" -ForegroundColor Cyan
    Write-Host "   build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor White
    Write-Host ""
    Write-Host "📱 Vous pouvez maintenant installer l'APK sur votre appareil Android!" -ForegroundColor Cyan
    
    # Afficher la taille du fichier
    $apkPath = "build\app\outputs\flutter-apk\app-release.apk"
    if (Test-Path $apkPath) {
        $apkSize = (Get-Item $apkPath).Length / 1MB
        Write-Host "   Taille: $([math]::Round($apkSize, 2)) MB" -ForegroundColor White
    }
} else {
    Write-Host ""
    Write-Host "❌ Erreur lors de la compilation!" -ForegroundColor Red
    Write-Host "   Consultez les logs ci-dessus pour plus de détails." -ForegroundColor Yellow
    exit 1
}
