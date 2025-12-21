# 📱 Glou Android

[![Platform](https://img.shields.io/badge/Platform-Android-brightgreen.svg)](https://developer.android.com)
[![Kotlin](https://img.shields.io/badge/Language-Kotlin-blue.svg)](https://kotlinlang.org)
[![Backend](https://img.shields.io/badge/Backend-glou--server-orange.svg)](https://github.com/jackthomasanderson/glou-server)

**glou-android** est l'application mobile native de l'écosystème **Glou**. Elle permet d'interagir avec les services et les données gérés par le [glou-server](https://github.com/jackthomasanderson/glou-server).

---

## ✨ Fonctionnalités
* **Interface Fluide** : Interface utilisateur moderne conçue pour Android.
* **Consommation d'API** : Intégration complète avec les endpoints de `glou-server`.
* **Performance** : Développé nativement pour une réactivité maximale.
* **Authentification** : Gestion sécurisée des sessions utilisateurs.

## 🛠 Stack Technique
* **Langage** : Kotlin
* **Architecture** : MVVM (Model-View-ViewModel)
* **Réseau** : [Retrofit](https://square.github.io/retrofit/) & [OkHttp](https://square.github.io/okhttp/)
* **UI** : Jetpack Compose (recommandé)
* **Asynchronisme** : Coroutines & Flow

---

## ⚙️ Installation et Configuration

### 1. Prérequis
* Android Studio (dernière version stable)
* Un terminal configuré avec `git`
* Une instance de [glou-server](https://github.com/jackthomasanderson/glou-server) en cours d'exécution.

### 2. Clonage et Setup
```bash
git clone [https://github.com/jackthomasanderson/glou-android.git](https://github.com/jackthomasanderson/glou-android.git)
cd glou-android