# 📱 Glou Android

[![Platform](https://img.shields.io/badge/Platform-Android-brightgreen.svg)](https://developer.android.com)
[![Dart](https://img.shields.io/badge/Language-Dart-blue.svg)](https://dart.dev)
[![Backend](https://img.shields.io/badge/Backend-glou--server-orange.svg)](https://github.com/jackthomasanderson/glou-server)

**Repositories:** [Backend (Go)](https://github.com/jackthomasanderson/glou-server) · [Mobile (Android/Dart)](https://github.com/jackthomasanderson/glou-android)

Your beverage collection in your pocket. Track, manage, and explore your wines, spirits, and beers anywhere with the native Android app for Glou.

**English** | [Français](#français)

**Status:** ✅ Production Ready | Tests: ✅ Passing | Sync: ✅ Verified

---

## Why the Mobile App?

- 📱 **Always with you** - Check your collection anytime, anywhere
- ⚡ **Fast & responsive** - Native Android with Flutter, optimized performance
- 🔗 **Stays in sync** - Connects to your self-hosted Glou server
- 📵 **Works offline** - Browse cached data when no signal
- 🌍 **Bilingual** - English and French support
- 🎨 **Beautiful UI** - Modern, intuitive design with Adaptive Navigation
- 🌙 **Dark mode** - Easy on the eyes
- 🚀 **Lightweight** - Minimal battery & data usage

---

## What You Can Do

```
1. Browse your collection      → Search & filter wines by any criteria
2. View wine details           → Full info: apogee, location, notes
3. Check apogee status         → "À Boire Maintenant" alerts
4. Record tastings             → Quick notes & ratings on the go
5. Get alerts                  → Push notifications when wines peak
6. See statistics              → Overview of your collection health
```

---

## Getting Started

### Prerequisites
- Android 10.0+ device or emulator
- Running [glou-server](https://github.com/jackthomasanderson/glou-server) instance
- Wi-Fi or mobile connection
- Dart SDK (for development)

### Installation

1. **Clone & Open**
```bash
git clone https://github.com/jackthomasanderson/glou-android.git
cd glou-android
```

2. **Open in Android Studio** (recommended) or run:
```bash
flutter pub get
flutter run
```

3. **Configure Server URL**
   - Open the app settings
   - Enter your glou-server address: `http://your-ip:8080`
   - Test connection

4. **Start Using**
   - App syncs automatically
   - Browse your collection
   - Manage on the go

---

## Key Features

| Feature | What You Get |
|---------|-------------|
| 🔍 **Search & Filter** | Find wines instantly by name, region, vintage |
| 📍 **Location Tracking** | Know exactly where each bottle is stored |
| 📅 **Apogee Alerts** | Get notified when to drink each wine |
| ⭐ **Ratings & Notes** | Add tasting notes and personal ratings |
| 📊 **Stats Dashboard** | See collection overview at a glance |
| 🔄 **Auto-sync** | Updates when you go back online |
| 🌙 **Dark Mode** | Comfortable viewing in any light |
| 🇬🇧🇫🇷 **Bilingual** | Switch languages instantly |
| 📱 **Responsive UI** | Adaptive design for phones & tablets |
| 💾 **Offline Support** | Access cached data without connection |

---

## How It Connects to Glou Server

The app talks to your Glou server via REST API:
- Fetches your wine data
- Uploads tasting notes
- Receives alerts
- Syncs changes offline/online

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
- [FAQ & Guides](https://github.com/jackthomasanderson/glou-server/tree/main/.docs)
- [Report Issues](https://github.com/jackthomasanderson/glou-android/issues)

---

## License

MIT

---

# 📱 Glou Android

**Français** (version française du README ci-dessus)

Votre collection de boissons dans votre poche. Suivez, gérez et explorez vos vins, spiritueux et bières n'importe où avec l'app Android native de Glou.

**English** (au-dessus) | **Français**

**Status:** ✅ Prêt Production | Tests: ✅ Validés | Sync: ✅ Vérifiée

---

### Pourquoi l'App Mobile?

- 📱 **Toujours avec vous** - Consultez votre collection n'importe quand, n'importe où
- ⚡ **Rapide & réactive** - Application native Android avec Flutter, performance optimisée
- 🔗 **Reste synchronisée** - Se connecte à votre serveur Glou auto-hébergé
- 📵 **Fonctionne hors ligne** - Parcourez les données en cache sans signal
- 🌍 **Bilingue** - Support anglais et français
- 🎨 **Belle interface** - Design moderne et intuitif avec Navigation Adaptive
- 🌙 **Mode sombre** - Confortable pour les yeux
- 🚀 **Légère** - Consommation minimale de batterie et données

---

### Ce Que Vous Pouvez Faire

```
1. Parcourez votre collection    → Recherchez et filtrez par critères
2. Consultez détails du vin      → Infos complètes: apogée, lieu, notes
3. Vérifiez l'apogée             → Alertes "À Boire Maintenant"
4. Enregistrez dégustations      → Notes rapides et notations
5. Recevez alertes               → Notifications quand le vin est prêt
6. Voyez les stats               → Vue d'ensemble de votre collection
```

---

### Démarrage Rapide

#### Prérequis
- Téléphone/émulateur Android 10.0+
- Instance [glou-server](https://github.com/jackthomasanderson/glou-server) en marche
- Connexion Wi-Fi ou mobile
- SDK Dart (pour le développement)

#### Installation

1. **Clonez & Ouvrez**
```bash
git clone https://github.com/jackthomasanderson/glou-android.git
cd glou-android
```

2. **Ouvrez dans Android Studio** (recommandé) ou lancez:
```bash
flutter pub get
flutter run
```

3. **Configurez l'Adresse du Serveur**
   - Allez aux paramètres de l'app
   - Entrez votre adresse glou-server: `http://votre-ip:8080`
   - Testez la connexion

4. **Commencez à Utiliser**
   - L'app synchronise automatiquement
   - Parcourez votre collection
   - Gérez en déplacement

---

### Fonctionnalités Principales

| Fonctionnalité | Ce que vous obtenez |
|---|---|
| 🔍 **Recherche & Filtres** | Trouvez les vins instantanément par nom, région, millésime |
| 📍 **Suivi de Localisation** | Savez exactement où chaque bouteille est stockée |
| 📅 **Alertes Apogée** | Soyez notifié quand le vin est à boire |
| ⭐ **Notes & Notations** | Ajoutez facilement des notes de dégustation |
| 📊 **Dashboard Stats** | Voyez l'aperçu de votre collection d'un coup d'œil |
| 🔄 **Sync Auto** | Mises à jour quand vous êtes reconnecté |
| 🌙 **Mode Sombre** | Visualisation confortable dans toute lumière |
| 🇬🇧🇫🇷 **Bilingue** | Basculez les langues instantanément |
| 📱 **Interface Responsive** | Design adaptatif pour téléphones et tablettes |
| 💾 **Support Hors Ligne** | Accédez aux données en cache sans connexion |

---

### Comment Elle Se Connecte au Serveur

L'app communique avec votre serveur Glou via API REST:
- Récupère vos données de vins
- Envoie les notes de dégustation
- Reçoit les alertes
- Synchronise les changements offline/online

Pensez-y comme: **Interface Web (navigateur) + App Mobile = Accès complet à votre collection**

---

### Configuration Première Utilisation

1. Assurez-vous que `glou-server` fonctionne
2. Notez l'IP de votre serveur (ex: `192.168.1.100`)
3. Installez & ouvrez l'app
4. Allez à Paramètres → Configuration du Serveur
5. Entrez: `http://192.168.1.100:8080`
6. Appuyez sur "Tester la Connexion"
7. Parcourez vos vins!

---

### Astuces & Conseils

- **Parcours hors ligne** - Les vins déjà consultés restent en cache
- **Notifications push** - Activez aux paramètres pour les alertes apogée
- **Mode sombre** - Bascule auto selon les paramètres du téléphone
- **Ajout rapide** - Utilisez le bouton flottant pour enregistrer une dégustation rapidement
- **Recherche & filtres** - Recherche instantanée par nom, région ou millésime

---

### FAQ

**Q: Fonctionne-t-elle sans serveur?**  
R: Limité—vous pouvez parcourir les données en cache, mais pas de sync temps réel.

**Q: Puis-je l'utiliser avec un serveur cloud?**  
R: Oui, si votre serveur a HTTPS public avec sécurité appropriée.

**Q: Mes données sont-elles privées?**  
R: Oui—se connecte uniquement à VOTRE serveur, nulle part ailleurs.

**Q: Qu'en est-il d'iOS?**  
R: Prévue pour l'avenir. Actuellement Android uniquement.

**Q: Comment je signale les bugs?**  
R: Créez un issue sur [GitHub](https://github.com/jackthomasanderson/glou-android/issues).

---

### Support

- [Docs Glou Server](https://github.com/jackthomasanderson/glou-server)
- [FAQ & Guides](https://github.com/jackthomasanderson/glou-server/tree/main/.docs)
- [Signalez Problèmes](https://github.com/jackthomasanderson/glou-android/issues)

---

### Licence

MIT

---

## 🛠 For Developers / Pour Développeurs

### Tech Stack

- **Language:** Dart
- **Framework:** Flutter
- **State Management:** Provider / Riverpod
- **Networking:** http package + JSON serialization
- **Local Storage:** Hive or Shared Preferences
- **UI:** Material Design 3
- **Backend:** [glou-server](https://github.com/jackthomasanderson/glou-server) REST API

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
See [glou-server API Reference](.docs/API_REFERENCE_COMPLETE.md) on the main repository.

### Contributing

See the main [glou-server](https://github.com/jackthomasanderson/glou-server) repository for contribution guidelines.
