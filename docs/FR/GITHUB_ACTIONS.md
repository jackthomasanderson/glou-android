# Configuration GitHub Actions pour Glou Android

## Présentation

Ce document décrit comment configurer GitHub Actions pour le build automatique de l'application Android Glou.

## Workflow principal

Le workflow [`build_apk.yml`](../.github/workflows/build_apk.yml) gère automatiquement :
- ✅ Les tests unitaires
- ✅ Le build d'APK signé pour les releases
- ✅ Le build d'App Bundle (AAB) pour le Google Play Store
- ✅ La création automatique de releases GitHub avec les artefacts
- ✅ Le cache des dépendances Flutter pour accélérer les builds

## Triggers du workflow

Le workflow se déclenche automatiquement lors de :
- **Push sur `main` ou `develop`** : Build et tests
- **Pull Request vers `main`** : Tests uniquement
- **Tag `v*`** : Build complet + création de release GitHub
- **Déclenchement manuel** : Possibilité de choisir le type de build (APK, AAB, ou les deux)

## Configuration requise

### 1. Créer un keystore Android

Si vous n'avez pas encore de keystore, créez-en un :

```bash
keytool -genkey -v -keystore glou-android-release.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias glou-android
```

Répondez aux questions et **notez précieusement** :
- Le mot de passe du keystore (storePassword)
- Le mot de passe de la clé (keyPassword) 
- L'alias de la clé (keyAlias) - normalement `glou-android`

### 2. Convertir le keystore en Base64

```bash
# Linux/Mac
base64 -i glou-android-release.keystore -o keystore.txt

# Windows PowerShell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("glou-android-release.keystore")) | Out-File keystore.txt
```

### 3. Configurer les secrets GitHub

Allez dans les paramètres du repository GitHub : **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

Ajoutez les secrets suivants :

| Secret | Description | Exemple |
|--------|-------------|---------|
| `ANDROID_KEYSTORE_BASE64` | Contenu du fichier `keystore.txt` (le keystore encodé en base64) | `MIIJhQIBAzCCCU8GCSqGSIb3DQEHAaCCCUA...` |
| `ANDROID_KEYSTORE_PASSWORD` | Mot de passe du keystore | `monMotDePasseStore123` |
| `ANDROID_KEY_PASSWORD` | Mot de passe de la clé | `monMotDePasseKey456` |
| `ANDROID_KEY_ALIAS` | Alias de la clé | `glou-android` |

### 4. (Optionnel) Configurer Codecov

Pour les rapports de couverture de code :

1. Créez un compte sur [codecov.io](https://codecov.io)
2. Ajoutez votre repository
3. Récupérez le token Codecov
4. Ajoutez-le comme secret : `CODECOV_TOKEN`

## Utilisation

### Build automatique sur push

Chaque push sur `main` ou `develop` déclenche automatiquement :
1. L'exécution des tests
2. Le build d'un APK signé
3. L'upload de l'APK comme artifact (conservé 30 jours)

### Créer une release

Pour créer une nouvelle release avec APK et AAB :

```bash
# Tagger une version
git tag v1.0.0
git push origin v1.0.0
```

Le workflow créera automatiquement :
- ✅ Un APK signé
- ✅ Un App Bundle (AAB) signé
- ✅ Une release GitHub avec les deux fichiers attachés

### Build manuel

1. Allez dans l'onglet **Actions** du repository
2. Sélectionnez le workflow **Build Glou Android App**
3. Cliquez sur **Run workflow**
4. Choisissez le type de build :
   - `apk` : Seulement l'APK
   - `appbundle` : Seulement l'AAB
   - `both` : Les deux

## Récupérer les artefacts

### Depuis GitHub Actions

1. Allez dans l'onglet **Actions**
2. Cliquez sur le workflow exécuté
3. Descendez jusqu'à la section **Artifacts**
4. Téléchargez `glou-android-apk-*` ou `glou-android-aab-*`

### Depuis les Releases

Pour les builds taggés, les fichiers sont disponibles directement dans les **Releases** GitHub.

## Structure des fichiers modifiés

```
glou-android/
├── .github/
│   └── workflows/
│       └── build_apk.yml          # Workflow principal
├── android/
│   ├── app/
│   │   ├── build.gradle           # Configuration de signature
│   │   └── proguard-rules.pro     # Règles d'obfuscation
│   └── key.properties             # Créé automatiquement par le workflow
└── .gitignore                     # Ignore keystore et secrets
```

## Sécurité

⚠️ **Important** :
- Ne commitez JAMAIS le keystore ou les fichiers de configuration de signature
- Les secrets GitHub sont chiffrés et sécurisés
- Le keystore n'est présent que temporairement pendant le build CI
- Sauvegardez votre keystore dans un endroit sûr (pas sur GitHub !)

## Dépannage

### Le build échoue avec "keystore not found"

Vérifiez que tous les secrets sont correctement configurés dans GitHub.

### L'APK ne peut pas être installé

L'APK doit être signé avec le même keystore pour les mises à jour. Assurez-vous d'utiliser toujours le même keystore.

### Erreur "Invalid keystore format"

Le Base64 du keystore est peut-être mal encodé. Réessayez la conversion et copiez tout le contenu du fichier `keystore.txt`.

## Références

- [Flutter - Build and release an Android app](https://docs.flutter.dev/deployment/android)
- [GitHub Actions - Flutter action](https://github.com/marketplace/actions/flutter-action)
- [Android - Sign your app](https://developer.android.com/studio/publish/app-signing)
