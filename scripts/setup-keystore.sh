#!/bin/bash
# Script pour générer et configurer le keystore Android pour Glou
# Usage: ./setup-keystore.sh

set -e

KEYSTORE_NAME="${1:-glou-android-release.keystore}"
KEY_ALIAS="${2:-glou-android}"

echo "🔐 Configuration du Keystore Android pour Glou"
echo "============================================================"

# Vérifier que keytool est disponible
if ! command -v keytool &> /dev/null; then
    echo "❌ Erreur: keytool n'est pas installé ou pas dans le PATH"
    echo "   Installez Java JDK et ajoutez-le au PATH"
    exit 1
fi

echo ""
echo "📝 Informations du keystore:"
echo "   Nom du fichier: $KEYSTORE_NAME"
echo "   Alias de la clé: $KEY_ALIAS"
echo ""

# Vérifier si le keystore existe déjà
if [ -f "$KEYSTORE_NAME" ]; then
    echo "⚠️  Un keystore existe déjà: $KEYSTORE_NAME"
    read -p "Voulez-vous le remplacer? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Opération annulée"
        exit 0
    fi
    rm "$KEYSTORE_NAME"
fi

# Générer le keystore
echo ""
echo "🔨 Génération du keystore..."
echo "   (Vous allez devoir entrer des mots de passe et des informations)"
echo ""

keytool -genkey -v -keystore "$KEYSTORE_NAME" \
    -keyalg RSA -keysize 2048 -validity 10000 -alias "$KEY_ALIAS"

if [ $? -ne 0 ]; then
    echo "❌ Erreur lors de la génération du keystore"
    exit 1
fi

echo ""
echo "✅ Keystore créé avec succès!"

# Convertir en Base64
echo ""
echo "🔄 Conversion en Base64..."

base64 -i "$KEYSTORE_NAME" -o keystore-base64.txt

if [ $? -ne 0 ]; then
    echo "❌ Erreur lors de la conversion Base64"
    exit 1
fi

echo "✅ Fichier Base64 créé: keystore-base64.txt"

# Afficher le résumé
echo ""
echo "============================================================"
echo "🎉 Configuration terminée!"
echo "============================================================"
echo ""
echo "📋 Prochaines étapes:"
echo ""
echo "1. 🔐 Sauvegardez le keystore en lieu sûr (HORS du repository Git):"
echo "   - $KEYSTORE_NAME"
echo "   - Notez les mots de passe utilisés"
echo ""
echo "2. 🌐 Configurez les secrets GitHub (Settings → Secrets → Actions):"
echo "   - ANDROID_KEYSTORE_BASE64    : Contenu de keystore-base64.txt"
echo "   - ANDROID_KEYSTORE_PASSWORD  : Mot de passe du keystore"
echo "   - ANDROID_KEY_PASSWORD       : Mot de passe de la clé"
echo "   - ANDROID_KEY_ALIAS          : $KEY_ALIAS"
echo ""
echo "3. 📄 Pour le build local, créez android/key.properties:"
echo "   storePassword=VOTRE_MOT_DE_PASSE_STORE"
echo "   keyPassword=VOTRE_MOT_DE_PASSE_KEY"
echo "   keyAlias=$KEY_ALIAS"
echo "   storeFile=$KEYSTORE_NAME"
echo ""
echo "4. 🧹 Nettoyez les fichiers temporaires:"
echo "   rm keystore-base64.txt  # Après avoir copié dans GitHub"
echo ""
echo "5. ✅ Vérifiez la checklist complète:"
echo "   docs/FR/SETUP_CHECKLIST.md"
echo ""
echo "⚠️  IMPORTANT: Ne commitez JAMAIS le keystore ou les mots de passe!"
echo ""

# Afficher les informations du keystore
echo "📊 Informations du keystore:"
keytool -list -v -keystore "$KEYSTORE_NAME" -alias "$KEY_ALIAS"

echo ""
echo "✨ Terminé!"
