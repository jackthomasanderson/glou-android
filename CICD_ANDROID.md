# 🚀 CI/CD Android

## Branches
- `develop` → Nightly builds (APK Debug) en artifacts
- `main` → Releases stables via tags `v*.*.*`

## Tags & Releases
- `vX.Y.Z` → Release stable
  - GitHub Release (Latest)
  - Artifacts: APK Release + AAB
- `vX.Y.Z-beta.N` → Pré-release / Beta
  - GitHub Release marqué `prerelease: true`
  - Artifacts: APK Release + AAB

## Workflows

`.github/workflows/android-nightly.yml`
- Push `develop` (et planifié 02:00 UTC)
- Build tests + APK Debug
- Upload artifact: `glou-android-nightly-<run_id>`

`.github/workflows/android-release.yml`
- Push tags `v*.*.*` (stable ou beta)
- Build tests + APK Release + AAB
- Upload artifacts
- Crée GitHub Release (pré-release si beta)

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
