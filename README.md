# 📱 Glou Android

[![Platform](https://img.shields.io/badge/Platform-Android-brightgreen.svg)](https://developer.android.com)
[![Flutter](https://img.shields.io/badge/Framework-Flutter-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Language-Dart-blue.svg)](https://dart.dev)
[![Backend](https://img.shields.io/badge/Backend-glou--server-orange.svg)](https://github.com/jackthomasanderson/glou-server)
[![Build Status](https://github.com/jackthomasanderson/glou-android/actions/workflows/build_apk.yml/badge.svg?branch=main)](https://github.com/jackthomasanderson/glou-android/actions/workflows/build_apk.yml)
[![Status](https://img.shields.io/badge/status-alpha-yellow)](https://github.com/jackthomasanderson/glou-android/releases)

**Repositories:** [Backend (Go)](https://github.com/jackthomasanderson/glou-server) · [Mobile (Android)](https://github.com/jackthomasanderson/glou-android)

Glou: Your personal cellar.

⚠️ **Project status: Alpha** — Features are evolving and breaking changes may occur between pre-release builds.

**🚀 [English Documentation](docs/EN/README.md)** | **🇫🇷 [Documentation Française](docs/FR/README.md)**

---

## ✨ Why the Mobile App?

The Glou Android app is the perfect companion to your [Glou Server](https://github.com/jackthomasanderson/glou-server). It brings your cellar to your fingertips with a native, high-performance experience.

- 🚀 **Native Performance** - Built with Flutter for a smooth, responsive UI.
- 📵 **Offline First** - Browse your collection even when you're in a deep cellar with no signal.
- 🔄 **Seamless Sync** - Automatically stays in sync with your self-hosted server.
- 🌙 **Modern UI** - Beautiful design with adaptive navigation and full dark mode support.
- 🌍 **Bilingual** - Full support for English and French.
- 🔋 **Lightweight** - Optimized for minimal battery and data consumption.

---

## 🛠️ Key Features

| Feature | Description |
| :--- | :--- |
| 🔍 **Smart Search** | Find any bottle instantly by name, region, vintage, or type. |
| 📍 **Cellar Tracking** | Know exactly where each bottle is stored (cellar, bin, shelf). |
| 📅 **Apogee Alerts** | Visual indicators for wines that are ready to drink now. |
| ⭐ **Ratings & Notes** | Add tasting notes and personal ratings on the fly. |
| 📊 **Stats Dashboard** | A quick overview of your collection's health and variety. |
| 📸 **Barcode Support** | (Coming Soon) Scan bottles to quickly add them to your inventory. |
| 🛡️ **Secure Connection** | Connects securely to your private Glou instance. |

---

## 🚀 Getting Started

### Prerequisites
- Android device (Android 10.0+) or emulator
- Running instance of [glou-server](https://github.com/jackthomasanderson/glou-server)

### Installation

1. **Download the APK** from [Releases](https://github.com/jackthomasanderson/glou-android/releases)
2. **Configure Server** - Enter your server URL (e.g., `http://192.168.1.50:8080`)
3. **Login** - Use your credentials and sync

### For Developers

```bash
git clone https://github.com/jackthomasanderson/glou-android.git
cd glou-android
flutter pub get
flutter run
```

📚 **[Complete Setup Guide](docs/EN/SETUP_CHECKLIST.md)** | **[Build Guide](docs/EN/BUILD_CHEATSHEET.md)**

---

## 💻 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **HTTP Client**: [Dio](https://pub.dev/packages/dio)
- **Local Storage**: [sqflite](https://pub.dev/packages/sqflite)

---

## 📖 Documentation

### 🇬🇧 English
- [Setup Checklist](docs/EN/SETUP_CHECKLIST.md)
- [Build Guide](docs/EN/BUILD_CHEATSHEET.md)
- [GitHub Actions](docs/EN/GITHUB_ACTIONS.md)

### 🇫🇷 Français
- [Liste de Vérification](docs/FR/SETUP_CHECKLIST.md)
- [Guide de Build](docs/FR/BUILD_CHEATSHEET.md)
- [GitHub Actions](docs/FR/GITHUB_ACTIONS.md)

---

## 🤝 Contributing

Contributions are welcome! See [glou-server](https://github.com/jackthomasanderson/glou-server) for contribution guidelines.

## 📄 License

MIT License - see [LICENSE](LICENSE) file.

---

*Glou is built with ❤️ for wine enthusiasts who value their privacy.*
