# Guide Rapide - Build Android Glou

## 📦 Génération du Keystore

### Créer un nouveau keystore
```bash
keytool -genkey -v -keystore glou-android-release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 -alias glou-android
```

### Convertir en Base64
```bash
# Linux/Mac
base64 -i glou-android-release.keystore -o keystore.txt

# Windows PowerShell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("glou-android-release.keystore")) | Out-File keystore.txt
```

### Vérifier le keystore
```bash
keytool -list -v -keystore glou-android-release.keystore -alias glou-android
```

## 🔐 Secrets GitHub Requis

| Nom du Secret | Valeur |
|---------------|--------|
| `ANDROID_KEYSTORE_BASE64` | Contenu de `keystore.txt` |
| `ANDROID_KEYSTORE_PASSWORD` | Mot de passe du keystore |
| `ANDROID_KEY_PASSWORD` | Mot de passe de la clé |
| `ANDROID_KEY_ALIAS` | Alias de la clé (ex: `glou-android`) |
| `CODECOV_TOKEN` | (Optionnel) Token Codecov |

## 🚀 Déclencher un Build

### Build automatique sur branche
```bash
git add .
git commit -m "feat: nouvelle fonctionnalité"
git push origin main
# → Déclenche automatiquement le build + tests
```

### Créer une release
```bash
git tag v1.0.0
git push origin v1.0.0
# → Crée une release GitHub avec APK + AAB
```

### Build manuel via GitHub
1. Aller dans **Actions** → **Build Glou Android App**
2. Cliquer sur **Run workflow**
3. Choisir le type : `apk`, `appbundle`, ou `both`

## 🔧 Build Local (Développement)

### Build APK debug
```bash
flutter build apk --debug
```

### Build APK release (nécessite key.properties)
```bash
flutter build apk --release
```

### Build App Bundle
```bash
flutter build appbundle --release
```

### Installer l'APK sur un appareil
```bash
flutter install
# ou
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

## 📋 Tests

### Lancer les tests
```bash
flutter test
```

### Tests avec couverture
```bash
flutter test --coverage
```

### Tests d'intégration
```bash
flutter drive --target=test_driver/app.dart
```

## 🔍 Vérifications

### Vérifier la version Flutter
```bash
flutter --version
```

### Analyser le code
```bash
flutter analyze
```

### Formater le code
```bash
flutter format lib/
```

### Vérifier les dépendances
```bash
flutter pub outdated
```

## 📱 Informations APK/AAB

### Taille de l'APK
```bash
ls -lh build/app/outputs/flutter-apk/app-release.apk
```

### Informations de signature
```bash
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk
```

### Analyser l'APK
```bash
# Nécessite Android Studio
./gradlew :app:analyzeReleaseBundle
```

## 🌐 Liens Utiles

- Workflow: [`.github/workflows/build_apk.yml`](../.github/workflows/build_apk.yml)
- Documentation complète: [`GITHUB_ACTIONS.md`](GITHUB_ACTIONS.md)
- Configuration Gradle: [`android/app/build.gradle`](../../android/app/build.gradle)

## ⚡ Résolution Rapide

### Build GitHub échoue
```bash
# Vérifier les secrets
gh secret list

# Ajouter un secret manquant
gh secret set ANDROID_KEYSTORE_BASE64 < keystore.txt
```

### Nettoyage complet
```bash
flutter clean
flutter pub get
cd android && ./gradlew clean && cd ..
```

### Problème de cache
```bash
flutter pub cache repair
```

### APK non installable
```bash
# Vérifier la signature
keytool -printcert -jarfile build/app/outputs/flutter-apk/app-release.apk
```
