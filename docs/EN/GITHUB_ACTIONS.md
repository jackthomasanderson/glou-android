# GitHub Actions Configuration for Glou Android

## Overview

This document describes how to configure GitHub Actions for automatic building of the Glou Android application.

## Main Workflow

The [`build_apk.yml`](../.github/workflows/build_apk.yml) workflow automatically handles:
- ✅ Unit tests
- ✅ Signed APK builds for releases
- ✅ App Bundle (AAB) builds for Google Play Store
- ✅ Automatic creation of GitHub releases with artifacts
- ✅ Flutter dependency caching to speed up builds

## Workflow Triggers

The workflow automatically triggers on:
- **Push to `main` or `develop`**: Build and tests
- **Pull Request to `main`**: Tests only
- **Tag `v*`**: Complete build + GitHub release creation
- **Manual trigger**: Option to choose build type (APK, AAB, or both)

## Required Configuration

### 1. Create an Android Keystore

If you don't have a keystore yet, create one:

```bash
keytool -genkey -v -keystore glou-android-release.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias glou-android
```

Answer the questions and **carefully note**:
- The keystore password (storePassword)
- The key password (keyPassword)
- The key alias (keyAlias) - typically `glou-android`

### 2. Convert Keystore to Base64

```bash
# Linux/Mac
base64 -i glou-android-release.keystore -o keystore.txt

# Windows PowerShell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("glou-android-release.keystore")) | Out-File keystore.txt
```

### 3. Configure GitHub Secrets

Go to your GitHub repository settings: **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

Add the following secrets:

| Secret | Description | Example |
|--------|-------------|---------|
| `ANDROID_KEYSTORE_BASE64` | Content of `keystore.txt` file (base64-encoded keystore) | `MIIJhQIBAzCCCU8GCSqGSIb3DQEHAaCCCUA...` |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore password | `myStorePassword123` |
| `ANDROID_KEY_PASSWORD` | Key password | `myKeyPassword456` |
| `ANDROID_KEY_ALIAS` | Key alias | `glou-android` |

### 4. (Optional) Configure Codecov

For code coverage reports:

1. Create an account on [codecov.io](https://codecov.io)
2. Add your repository
3. Get the Codecov token
4. Add it as a secret: `CODECOV_TOKEN`

## Usage

### Automatic Build on Push

Each push to `main` or `develop` automatically triggers:
1. Test execution
2. Signed APK build
3. APK upload as artifact (retained for 30 days)

### Create a Release

To create a new release with both APK and AAB:

```bash
# Tag a version
git tag v1.0.0
git push origin v1.0.0
```

The workflow will automatically create:
- ✅ A signed APK
- ✅ A signed App Bundle (AAB)
- ✅ A GitHub release with both files attached

### Manual Build

1. Go to the **Actions** tab of the repository
2. Select the **Build Glou Android App** workflow
3. Click **Run workflow**
4. Choose the build type:
   - `apk`: APK only
   - `appbundle`: AAB only
   - `both`: Both

## Retrieving Artifacts

### From GitHub Actions

1. Go to the **Actions** tab
2. Click on the executed workflow
3. Scroll down to the **Artifacts** section
4. Download `glou-android-apk-*` or `glou-android-aab-*`

### From Releases

For tagged builds, files are directly available in GitHub **Releases**.

## Modified File Structure

```
glou-android/
├── .github/
│   └── workflows/
│       └── build_apk.yml          # Main workflow
├── android/
│   ├── app/
│   │   ├── build.gradle           # Signing configuration
│   │   └── proguard-rules.pro     # Obfuscation rules
│   └── key.properties             # Automatically created by workflow
└── .gitignore                     # Ignores keystore and secrets
```

## Security

⚠️ **Important**:
- NEVER commit the keystore or signing configuration files
- GitHub secrets are encrypted and secure
- The keystore is only present temporarily during CI build
- Back up your keystore in a safe place (not on GitHub!)

## Troubleshooting

### Build fails with "keystore not found"

Check that all secrets are properly configured in GitHub.

### APK cannot be installed

The APK must be signed with the same keystore for updates. Make sure to always use the same keystore.

### Error "Invalid keystore format"

The Base64 encoding of the keystore might be incorrect. Retry the conversion and copy the entire content of the `keystore.txt` file.

## References

- [Flutter - Build and release an Android app](https://docs.flutter.dev/deployment/android)
- [GitHub Actions - Flutter action](https://github.com/marketplace/actions/flutter-action)
- [Android - Sign your app](https://developer.android.com/studio/publish/app-signing)
