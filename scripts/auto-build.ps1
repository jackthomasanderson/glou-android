param(
    [string]$Branch = "main",
    [ValidateSet("debug","release")][string]$Mode = "release"
)
$ErrorActionPreference = "Stop"

function Require-Exe {
    param([string]$Name)
    try { & $Name --version | Out-Null } catch { Write-Host "✗ $Name introuvable" -ForegroundColor Red; exit 1 }
}
Require-Exe "gh"

Write-Host "[auto] Vérification du dernier build GitHub sur '$Branch'..." -ForegroundColor Yellow
$runJson = gh run list --branch $Branch --limit 1 --json databaseId,status,conclusion,html_url 2>$null
if (-not $runJson -or $runJson -eq "[]") { Write-Host "✗ Aucun workflow trouvé" -ForegroundColor Red; exit 1 }
$run = $runJson | ConvertFrom-Json
$runId = $run[0].databaseId
$status = $run[0].status
$conclusion = $run[0].conclusion
$url = $run[0].html_url

if ($status -ne "completed") {
  Write-Host "→ Build en cours ($status). Attente (watch)..." -ForegroundColor Cyan
  gh run watch $runId --exit-status
  if ($LASTEXITCODE -ne 0) { Write-Host "✗ Build échoué — $url" -ForegroundColor Red; exit 1 }
} else {
  if ($conclusion -ne "success") { Write-Host "✗ Dernier build non vert ($conclusion) — $url" -ForegroundColor Red; exit 1 }
}

Write-Host "✓ Build vert. Lancement build Android ($Mode)..." -ForegroundColor Green
& (Join-Path $PSScriptRoot "build-android.ps1") -Mode $Mode
exit $LASTEXITCODE
