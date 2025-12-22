param(
    [ValidateSet("debug","release")][string]$Mode = "release"
)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$androidDir = Join-Path $root "android"
if (-not (Test-Path (Join-Path $androidDir "gradlew.bat"))) {
    Write-Host "✗ gradlew.bat introuvable dans le dossier android" -ForegroundColor Red
    exit 1
}
Push-Location $androidDir
try {
    if ($Mode -eq "release") {
        .\gradlew.bat assembleRelease --no-daemon
    } else {
        .\gradlew.bat assembleDebug --no-daemon
    }
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
} finally {
    Pop-Location
}
