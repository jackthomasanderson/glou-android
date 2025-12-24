# 📱 Glou Android

[![Platform](https://img.shields.io/badge/Platform-Android-brightgreen.svg)](https://developer.android.com)
[![Flutter](https://img.shields.io/badge/Framework-Flutter-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Language-Dart-blue.svg)](https://dart.dev)
[![Backend](https://img.shields.io/badge/Backend-glou--server-orange.svg)](https://github.com/jackthomasanderson/glou-server)
[![Build Status](https://github.com/jackthomasanderson/glou-android/actions/workflows/build_apk.yml/badge.svg?branch=main)](https://github.com/jackthomasanderson/glou-android/actions/workflows/build_apk.yml)
![Status](https://img.shields.io/badge/status-alpha-yellow)

**Repositories:** [Backend (Go)](https://github.com/jackthomasanderson/glou-server) · [Mobile (Android/Dart)](https://github.com/jackthomasanderson/glou-android)

Glou: Your personal cellar.

⚠️ Project status: Alpha. Features are evolving and breaking changes may occur between pre-release builds.

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
- An Android device (Android 10.0+) or emulator.
- A running instance of [glou-server](https://github.com/jackthomasanderson/glou-server).

### Installation

1. **Download the APK**
   Grab the latest release from the [Releases](https://github.com/romain/glou-android/releases) page.

2. **Configure Server**
   - Open the app and go to **Settings**.
   - Enter your Glou Server URL (e.g., `http://192.168.1.50:8080`).
   - Log in with your credentials.

3. **Sync & Enjoy**
   The app will automatically fetch your collection.

### For Developers

```bash
# Clone the repo
git clone https://github.com/jackthomasanderson/glou-android.git
cd glou-android

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 💻 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **API Client**: [Dio](https://pub.dev/packages/dio) / [http](https://pub.dev/packages/http)
- **Local Storage**: [sqflite](https://pub.dev/packages/sqflite) for caching.

---

## 🤝 Contributing

We welcome contributions! If you find a bug or have a feature request, please open an issue. Pull requests are also highly appreciated.

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

*Glou is built with ❤️ for wine enthusiasts who value their privacy.*

Think of it as: **Web Interface (browser) + Mobile App = Complete access to your collection**

---

## First Time Setup

1. Make sure `glou-server` is running
2. Note your server IP (e.g., `192.168.1.100`)
3. Install & open the app
4. Go to Settings → Server Configuration
5. Enter: `http://192.168.1.100:8080`
6. Tap "Test Connection"
7. Browse your wines!

---

## Tips & Tricks

- **Offline browsing** - Already viewed wines stay cached
- **Push notifications** - Enable in settings for apogee alerts
- **Dark mode** - Auto-switches based on phone settings
- **Quick add** - Use the floating button to quickly log tastings
- **Search & filters** - Instant search by name, region, or vintage

---

## FAQ

**Q: Does it work without server?**
A: Limited—you can browse cached data, but no real-time sync.

**Q: Can I use it with cloud hosting?**
A: Yes, if your server has public HTTPS with proper security.

**Q: Is my data private?**
A: Yes—it only connects to YOUR server, nowhere else.

**Q: What about iOS?**
A: Planned for future. Currently Android only.

**Q: How do I report bugs?**
A: Create an issue on [GitHub](https://github.com/jackthomasanderson/glou-android/issues).

---

## Support

- [Glou Server Docs](https://github.com/jackthomasanderson/glou-server)
- [FAQ & Guides](https://github.com/jackthomasanderson/glou-server/tree/main/docs)
- [Report Issues](https://github.com/jackthomasanderson/glou-android/issues)

---

## License

MIT

---

## 🛠 For Developers

### Tech Stack

- **Language:** Dart
- **Framework:** Flutter
- **State Management:** Provider / Riverpod
- **Networking:** http package + JSON serialization
- **Local Storage:** Hive or Shared Preferences
- **UI:** Material Design 3
- **Backend:** [glou-server](https://github.com/romain/glou-server) REST API

### Project Structure

```
glou-android/lib/
├── providers/         # State management & data fetching
├── screens/           # Main app screens
├── services/          # API client & local storage
├── theme/             # Material Design theme
├── widgets/           # Reusable UI components
└── models/            # Data models & serialization
```

### Building

```bash
# Get dependencies
flutter pub get

# Debug build
flutter run

# Release build
flutter build apk

# Tests
flutter test
```

### API Integration

Uses 30+ REST endpoints from glou-server.
See [glou-server docs (EN)](https://github.com/jackthomasanderson/glou-server/tree/main/docs/EN) on the main repository.

### Contributing

See the main [glou-server](https://github.com/jackthomasanderson/glou-server) repository for contribution guidelines.
