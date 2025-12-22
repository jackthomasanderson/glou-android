# Script pour générer et configurer le keystore Android pour Glou
# Usage: .\setup-keystore.ps1

param(
    [string]$KeystoreName = "glou-android-release.keystore",
    [string]$KeyAlias = "glou-android"
)

Write-Host "🔐 Configuration du Keystore Android pour Glou" -ForegroundColor Cyan
Write-Host "=" * 60

# Vérifier que keytool est disponible
try {
    $null = keytool -help 2>&1
} catch {
    Write-Host "❌ Erreur: keytool n'est pas installé ou pas dans le PATH" -ForegroundColor Red
    Write-Host "   Installez Java JDK et ajoutez-le au PATH" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "📝 Informations du keystore:" -ForegroundColor Green
Write-Host "   Nom du fichier: $KeystoreName"
Write-Host "   Alias de la clé: $KeyAlias"
Write-Host ""

# Vérifier si le keystore existe déjà
if (Test-Path $KeystoreName) {
    Write-Host "⚠️  Un keystore existe déjà: $KeystoreName" -ForegroundColor Yellow
    $response = Read-Host "Voulez-vous le remplacer? (y/N)"
    if ($response -ne "y") {
        Write-Host "❌ Opération annulée" -ForegroundColor Red
        exit 0
    }
    Remove-Item $KeystoreName
}

# Générer le keystore
Write-Host ""
Write-Host "🔨 Génération du keystore..." -ForegroundColor Cyan
Write-Host "   (Vous allez devoir entrer des mots de passe et des informations)" -ForegroundColor Yellow
Write-Host ""

keytool -genkey -v -keystore $KeystoreName `
    -keyalg RSA -keysize 2048 -validity 10000 -alias $KeyAlias

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur lors de la génération du keystore" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✅ Keystore créé avec succès!" -ForegroundColor Green

# Convertir en Base64
Write-Host ""
Write-Host "🔄 Conversion en Base64..." -ForegroundColor Cyan

try {
    $keystoreBytes = [IO.File]::ReadAllBytes($KeystoreName)
    $base64 = [Convert]::ToBase64String($keystoreBytes)
    $base64 | Out-File "keystore-base64.txt" -Encoding ASCII
    Write-Host "✅ Fichier Base64 créé: keystore-base64.txt" -ForegroundColor Green
} catch {
    Write-Host "❌ Erreur lors de la conversion Base64: $_" -ForegroundColor Red
    exit 1
}

# Afficher le résumé
Write-Host ""
Write-Host "=" * 60
Write-Host "🎉 Configuration terminée!" -ForegroundColor Green
Write-Host "=" * 60
Write-Host ""
Write-Host "📋 Prochaines étapes:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. 🔐 Sauvegardez le keystore en lieu sûr (HORS du repository Git):" -ForegroundColor White
Write-Host "   - $KeystoreName"
Write-Host "   - Notez les mots de passe utilisés"
Write-Host ""
Write-Host "2. 🌐 Configurez les secrets GitHub (Settings → Secrets → Actions):" -ForegroundColor White
Write-Host "   - ANDROID_KEYSTORE_BASE64    : Contenu de keystore-base64.txt"
Write-Host "   - ANDROID_KEYSTORE_PASSWORD  : Mot de passe du keystore"
Write-Host "   - ANDROID_KEY_PASSWORD       : Mot de passe de la clé"
Write-Host "   - ANDROID_KEY_ALIAS          : $KeyAlias"
Write-Host ""
Write-Host "3. 📄 Pour le build local, créez android/key.properties:" -ForegroundColor White
Write-Host "   storePassword=VOTRE_MOT_DE_PASSE_STORE"
Write-Host "   keyPassword=VOTRE_MOT_DE_PASSE_KEY"
Write-Host "   keyAlias=$KeyAlias"
Write-Host "   storeFile=$KeystoreName"
Write-Host ""
Write-Host "4. 🧹 Nettoyez les fichiers temporaires:" -ForegroundColor White
Write-Host "   Remove-Item keystore-base64.txt  # Après avoir copié dans GitHub"
Write-Host ""
Write-Host "5. ✅ Vérifiez la checklist complète:" -ForegroundColor White
Write-Host "   docs/FR/SETUP_CHECKLIST.md"
Write-Host ""
Write-Host "⚠️  IMPORTANT: Ne commitez JAMAIS le keystore ou les mots de passe!" -ForegroundColor Yellow
Write-Host ""

# Afficher les informations du keystore
Write-Host "📊 Informations du keystore:" -ForegroundColor Cyan
keytool -list -v -keystore $KeystoreName -alias $KeyAlias

Write-Host ""
Write-Host "✨ Terminé!" -ForegroundColor Green
