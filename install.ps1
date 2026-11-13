[CmdletBinding()]
param()

$repoUrl = "https://raw.githubusercontent.com/Cod3rQwerty/GetFileTree/main/main.ps1"
$profileDir = Split-Path -Path $PROFILE -Parent
$destPath = Join-Path $profileDir "FileTree.ps1"
$sourceLine = ". `"$destPath`""

Write-Host "Downloading FileTree from GitHub..." -ForegroundColor Cyan

try {
    # Download the main script content securely
    $scriptContent = Invoke-RestMethod -Uri $repoUrl -UseBasicParsing
}
catch {
    Write-Error "Failed to download FileTree from $repoUrl. Error: $_"
    exit 1
}

# Ensure the PowerShell profile directory exists
if (-not (Test-Path -Path $profileDir)) {
    New-Item -Path $profileDir -ItemType Directory -Force | Out-Null
}

# Ensure the PROFILE file itself exists
if (-not (Test-Path -Path $PROFILE)) {
    New-Item -Path $PROFILE -ItemType File -Force | Out-Null
}

# Save the downloaded script locally
Set-Content -Path $destPath -Value $scriptContent -Encoding utf8

# Add dot-source loader to profile if not already present
$profileContent = Get-Content -Path $PROFILE -Raw -ErrorAction SilentlyContinue
if ($profileContent -notmatch [regex]::Escape($sourceLine)) {
    Add-Content -Path $PROFILE -Value "`r`n$sourceLine" -Encoding utf8
    Write-Host "Added FileTree loader to $PROFILE." -ForegroundColor Cyan
}

Write-Host "FileTree successfully installed at $destPath." -ForegroundColor Green
Write-Host "Restart your terminal or run '. `$PROFILE' to start using it." -ForegroundColor Yellow