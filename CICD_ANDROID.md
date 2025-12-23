# 🚀 CI/CD Android - Stratégie Hybride de Versioning

## 🎯 Approche Hybride : DateTime pour Nightly, Semver pour Releases

### Branches
- `develop` → Nightly builds (APK Debug) en artifacts avec **timestamp ISO**
- `main` → Releases stables via tags **semver** `v*.*.*`

### Tags & Releases

#### Nightly Builds (depuis `develop`)
Format : `glou-android-nightly-YYYYMMDD-HHMMSS-<commit>-<attempt>`

Exemple : `glou-android-nightly-20251223-143000-a1b2c3d-1`

**Avantages** :
- ✅ Tri chronologique automatique
- ✅ Identifie immédiatement la date/heure du build
- ✅ Impossible de confusion avec les releases stables

#### Release Stable
Format : `vX.Y.Z` (Semantic Versioning)

Exemple : `v1.2.0`
- GitHub Release marquée "Latest"
- Artifacts: APK Release + AAB
- Image Docker : `ghcr.io/project:v1.2.0` + `latest`

#### Pre-release / Beta
Format : `vX.Y.Z-beta.N` (Semantic Versioning)

Exemple : `v2.0.0-beta.1`
- GitHub Release marquée `prerelease: true`
- Artifacts: APK Release + AAB
- Image Docker : `ghcr.io/project:v2.0.0-beta.1`

## Workflows

### `.github/workflows/android-nightly.yml`
- **Déclenche** : Push `develop` (et planifié 02:00 UTC)
- **Actions** : Build tests + APK Debug
- **Artifact** : `glou-android-nightly-YYYYMMDD-HHMMSS-<commit>-<attempt>`
- **Rétention** : 7 jours

### `.github/workflows/android-release.yml`
- **Déclenche** : Push tags `v*.*.*`
- **Détecte automatiquement** :
  - Stable : `v1.2.3`
  - Beta : `v2.0.0-beta.1` ou `v2.0-beta`
- **Actions** : Build tests + APK Release + AAB
- **Release GitHub** : Type (stable/beta) détecté automatiquement
- **Rétention artifacts** : 180 jours

## Signing (secrets requis)
Configurer ces secrets dans GitHub → Settings → Secrets → Actions:
- `ANDROID_KEYSTORE_BASE64` (Base64 du fichier .jks)
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`
- `ANDROID_KEYSTORE_TYPE` (optionnel, défaut `pkcs12`)

Le workflow crée `android/app/keystore.jks` et `android/key.properties` automatiquement.

## Utilisation

### Nightly (develop)
```
git checkout develop
git commit -m "feat: ..."
git push origin develop
```
→ Artifact disponible dans "Actions" > run > Artifacts.

### Release stable
```
git checkout main
git merge develop
git tag v1.2.3
git push origin v1.2.3
```
→ GitHub Release + APK/AAB attachés.

### Release beta
```
git tag v2.0.0-beta.1
git push origin v2.0.0-beta.1
```
→ GitHub Release (pré-release) + APK/AAB.

## Notes
- Les Nightly ne créent pas de Release; elles restent des artifacts.
- Les Releases stables sont automatiquement marquées "Latest" par GitHub.
