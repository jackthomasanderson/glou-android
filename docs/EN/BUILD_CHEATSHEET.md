# Quick Guide - Glou Android Build

## 📦 Keystore Generation

### Create a new keystore
```bash
keytool -genkey -v -keystore glou-android-release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 -alias glou-android
```

### Convert to Base64
```bash
# Linux/Mac
base64 -i glou-android-release.keystore -o keystore.txt

# Windows PowerShell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("glou-android-release.keystore")) | Out-File keystore.txt
```

### Verify keystore
```bash
keytool -list -v -keystore glou-android-release.keystore -alias glou-android
```

## 🔐 Required GitHub Secrets

| Secret Name | Value |
|-------------|-------|
| `ANDROID_KEYSTORE_BASE64` | Content of `keystore.txt` |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore password |
| `ANDROID_KEY_PASSWORD` | Key password |
| `ANDROID_KEY_ALIAS` | Key alias (e.g., `glou-android`) |
| `CODECOV_TOKEN` | (Optional) Codecov token |

## 🚀 Trigger a Build

### Automatic build on branch
```bash
git add .
git commit -m "feat: new feature"
git push origin main
# → Automatically triggers build + tests
```

### Create a release
```bash
git tag v1.0.0
git push origin v1.0.0
# → Creates a GitHub release with APK + AAB
```

### Manual build via GitHub
1. Go to **Actions** → **Build Glou Android App**
2. Click **Run workflow**
3. Choose type: `apk`, `appbundle`, or `both`

## 🔧 Local Build (Development)

### Build debug APK
```bash
flutter build apk --debug
```

### Build release APK (requires key.properties)
```bash
flutter build apk --release
```

### Build App Bundle
```bash
flutter build appbundle --release
```

### Install APK on device
```bash
flutter install
# or
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

## 📋 Tests

### Run tests
```bash
flutter test
```

### Tests with coverage
```bash
flutter test --coverage
```

### Integration tests
```bash
flutter drive --target=test_driver/app.dart
```

## 🔍 Checks

### Check Flutter version
```bash
flutter --version
```

### Analyze code
```bash
flutter analyze
```

### Format code
```bash
flutter format lib/
```

### Check dependencies
```bash
flutter pub outdated
```

## 📱 APK/AAB Information

### APK size
```bash
ls -lh build/app/outputs/flutter-apk/app-release.apk
```

### Signing information
```bash
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk
```

### Analyze APK
```bash
# Requires Android Studio
./gradlew :app:analyzeReleaseBundle
```

## 🌐 Useful Links

- Workflow: [`.github/workflows/build_apk.yml`](../.github/workflows/build_apk.yml)
- Full documentation: [`GITHUB_ACTIONS.md`](GITHUB_ACTIONS.md)
- Gradle configuration: [`android/app/build.gradle`](../../android/app/build.gradle)

## ⚡ Quick Troubleshooting

### GitHub build fails
```bash
# Check secrets
gh secret list

# Add missing secret
gh secret set ANDROID_KEYSTORE_BASE64 < keystore.txt
```

### Complete cleanup
```bash
flutter clean
flutter pub get
cd android && ./gradlew clean && cd ..
```

### Cache issues
```bash
flutter pub cache repair
```

### APK not installable
```bash
# Check signature
keytool -printcert -jarfile build/app/outputs/flutter-apk/app-release.apk
```
