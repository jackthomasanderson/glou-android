# 🎯 GitHub Actions Setup Checklist

Use this checklist to ensure everything is properly configured for automatic builds of Glou Android.

## ✅ Local Prerequisites

- [ ] Flutter SDK installed (stable version)
- [ ] Android SDK installed
- [ ] Java JDK 17+ installed
- [ ] Project cloned locally
- [ ] Dependencies installed (`flutter pub get`)

## 🔑 Keystore Creation

- [ ] Keystore created with `keytool`
- [ ] Information saved securely:
  - [ ] Store password
  - [ ] Key password  
  - [ ] Key alias
- [ ] Keystore backed up in a secure location (OUTSIDE Git repo)
- [ ] Keystore converted to Base64

## 🔐 GitHub Secrets Configuration

Go to: **Settings** → **Secrets and variables** → **Actions**

- [ ] `ANDROID_KEYSTORE_BASE64` configured
- [ ] `ANDROID_KEYSTORE_PASSWORD` configured
- [ ] `ANDROID_KEY_PASSWORD` configured
- [ ] `ANDROID_KEY_ALIAS` configured
- [ ] (Optional) `CODECOV_TOKEN` configured

**Verification command:**
```bash
gh secret list
```

## 📁 Project Files

- [ ] [`.github/workflows/build_apk.yml`](../.github/workflows/build_apk.yml) present
- [ ] [`android/app/build.gradle`](../../android/app/build.gradle) configured for signing
- [ ] [`android/app/proguard-rules.pro`](../../android/app/proguard-rules.pro) created
- [ ] [`.gitignore`](../../.gitignore) updated (ignores keystore and key.properties)

## 🧪 Local Tests

Before pushing, test locally:

```bash
# Unit tests
flutter test

# Code analysis
flutter analyze

# Local build (requires key.properties)
flutter build apk --release
```

- [ ] Tests pass
- [ ] No analysis errors
- [ ] Local build successful

## 🚀 First GitHub Build

### 1. Push to develop/main
```bash
git add .
git commit -m "ci: configure GitHub Actions for Android"
git push origin main
```

- [ ] Workflow triggers automatically
- [ ] Tests pass
- [ ] APK is generated
- [ ] Artifact is uploaded

**Check:** https://github.com/[OWNER]/glou-android/actions

### 2. Create first release

```bash
git tag v1.0.0
git push origin v1.0.0
```

- [ ] Release workflow triggers
- [ ] Signed APK generated
- [ ] Signed AAB generated
- [ ] GitHub release created with files

**Check:** https://github.com/[OWNER]/glou-android/releases

## 📊 Status Badge

Add the build badge to your README:

```markdown
[![Build Status](https://github.com/[OWNER]/glou-android/workflows/Build%20Glou%20Android%20App/badge.svg)](https://github.com/[OWNER]/glou-android/actions)
```

- [ ] Badge added to README
- [ ] Badge displays correct status

## 📝 Documentation

- [ ] [`docs/EN/GITHUB_ACTIONS.md`](GITHUB_ACTIONS.md) - Complete guide
- [ ] [`docs/EN/BUILD_CHEATSHEET.md`](BUILD_CHEATSHEET.md) - Quick commands
- [ ] [`docs/FR/GITHUB_ACTIONS.md`](../FR/GITHUB_ACTIONS.md) - Guide français
- [ ] [`docs/FR/BUILD_CHEATSHEET.md`](../FR/BUILD_CHEATSHEET.md) - Commandes rapides
- [ ] Issue templates created

## 🎉 Final Validation

- [ ] At least one successful build on GitHub Actions
- [ ] APK downloaded and installable on device
- [ ] APK is properly signed
- [ ] GitHub Actions notifications received
- [ ] Team informed of new procedure

## 🔄 Daily Workflow

Once configured, the daily workflow becomes:

1. **Development**: Code and test locally
2. **Push**: `git push origin develop` → Automatic build
3. **Release**: `git tag vX.Y.Z && git push --tags` → Automatic release

---

## 📞 Need Help?

- 📖 [Complete documentation](GITHUB_ACTIONS.md)
- 🐛 [Report an issue](https://github.com/jackthomasanderson/glou-android/issues/new/choose)
- 💬 [Discussions](https://github.com/jackthomasanderson/glou-android/discussions)

## 🔗 Quick Links

- [Actions](https://github.com/jackthomasanderson/glou-android/actions)
- [Releases](https://github.com/jackthomasanderson/glou-android/releases)
- [Secrets](https://github.com/jackthomasanderson/glou-android/settings/secrets/actions)
- [Workflow File](../.github/workflows/build_apk.yml)
