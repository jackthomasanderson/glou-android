# 🎯 Checklist de Configuration GitHub Actions

Utilisez cette checklist pour vous assurer que tout est correctement configuré pour le build automatique de Glou Android.

## ✅ Prérequis Locaux

- [ ] Flutter SDK installé (version stable)
- [ ] Android SDK installé
- [ ] Java JDK 17+ installé
- [ ] Projet cloné localement
- [ ] Dépendances installées (`flutter pub get`)

## 🔑 Création du Keystore

- [ ] Keystore créé avec `keytool`
- [ ] Informations notées en lieu sûr :
  - [ ] Store password
  - [ ] Key password  
  - [ ] Key alias
- [ ] Keystore sauvegardé dans un endroit sécurisé (HORS du repo Git)
- [ ] Keystore converti en Base64

## 🔐 Configuration GitHub Secrets

Rendez-vous dans : **Settings** → **Secrets and variables** → **Actions**

- [ ] `ANDROID_KEYSTORE_BASE64` configuré
- [ ] `ANDROID_KEYSTORE_PASSWORD` configuré
- [ ] `ANDROID_KEY_PASSWORD` configuré
- [ ] `ANDROID_KEY_ALIAS` configuré
- [ ] (Optionnel) `CODECOV_TOKEN` configuré

**Commande pour vérifier :**
```bash
gh secret list
```

## 📁 Fichiers du Projet

- [ ] [`.github/workflows/build_apk.yml`](../.github/workflows/build_apk.yml) présent
- [ ] [`android/app/build.gradle`](../../android/app/build.gradle) configuré pour la signature
- [ ] [`android/app/proguard-rules.pro`](../../android/app/proguard-rules.pro) créé
- [ ] [`.gitignore`](../../.gitignore) mis à jour (ignore keystore et key.properties)

## 🧪 Tests Locaux

Avant de pousser, testez localement :

```bash
# Tests unitaires
flutter test

# Vérification du code
flutter analyze

# Build local (nécessite key.properties)
flutter build apk --release
```

- [ ] Tests passent
- [ ] Aucune erreur d'analyse
- [ ] Build local réussi

## 🚀 Premier Build GitHub

### 1. Push sur develop/main
```bash
git add .
git commit -m "ci: configuration GitHub Actions pour Android"
git push origin main
```

- [ ] Le workflow se déclenche automatiquement
- [ ] Les tests passent
- [ ] L'APK est généré
- [ ] L'artifact est uploadé

**Vérifier :** https://github.com/[OWNER]/glou-android/actions

### 2. Créer une première release

```bash
git tag v1.0.0
git push origin v1.0.0
```

- [ ] Le workflow de release se déclenche
- [ ] APK généré et signé
- [ ] AAB généré et signé
- [ ] Release GitHub créée avec les fichiers

**Vérifier :** https://github.com/[OWNER]/glou-android/releases

## 📊 Badge de Statut

Ajoutez le badge de build dans votre README :

```markdown
[![Build Status](https://github.com/[OWNER]/glou-android/workflows/Build%20Glou%20Android%20App/badge.svg)](https://github.com/[OWNER]/glou-android/actions)
```

- [ ] Badge ajouté au README
- [ ] Badge affiche le statut correct

## 📝 Documentation

- [ ] [`docs/FR/GITHUB_ACTIONS.md`](GITHUB_ACTIONS.md) - Guide complet
- [ ] [`docs/FR/BUILD_CHEATSHEET.md`](BUILD_CHEATSHEET.md) - Commandes rapides
- [ ] [`docs/EN/GITHUB_ACTIONS.md`](../EN/GITHUB_ACTIONS.md) - English guide
- [ ] [`docs/EN/BUILD_CHEATSHEET.md`](../EN/BUILD_CHEATSHEET.md) - Quick commands
- [ ] Issue templates créés

## 🎉 Validation Finale

- [ ] Au moins un build réussi sur GitHub Actions
- [ ] APK téléchargé et installable sur un appareil
- [ ] L'APK est correctement signé
- [ ] Les notifications GitHub Actions reçues
- [ ] L'équipe informée de la nouvelle procédure

## 🔄 Workflow Quotidien

Une fois configuré, le workflow quotidien devient :

1. **Développement** : Coder et tester localement
2. **Push** : `git push origin develop` → Build automatique
3. **Release** : `git tag vX.Y.Z && git push --tags` → Release automatique

---

## 📞 Besoin d'Aide ?

- 📖 [Documentation complète](GITHUB_ACTIONS.md)
- 🐛 [Signaler un problème](https://github.com/romain/glou-android/issues/new/choose)
- 💬 [Discussions](https://github.com/romain/glou-android/discussions)

## 🔗 Liens Rapides

- [Actions](https://github.com/romain/glou-android/actions)
- [Releases](https://github.com/romain/glou-android/releases)
- [Secrets](https://github.com/romain/glou-android/settings/secrets/actions)
- [Workflow File](../.github/workflows/build_apk.yml)
