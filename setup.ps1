$profileDir = Split-Path -Path $PROFILE -Parent
$destPath = Join-Path -Path $profileDir -ChildPath "FileTree.ps1"
$sourceLine = '. (Join-Path -Path $PSScriptRoot -ChildPath "FileTree.ps1")'

#Ensure the $PROFILE file and its directory exist
if (-not (Test-Path -Path $PROFILE)) {
    New-Item -Path $PROFILE -ItemType File -Force | Out-Null
}

Copy-Item -Path ".\main.ps1" -Destination $destPath -Force

$profileContent = Get-Content -Path $PROFILE -Raw
if ($profileContent -notmatch [regex]::Escape($sourceLine)) {
    Add-Content -Path $PROFILE -Value "`r`n$sourceLine" -Encoding utf8
    Write-Host "Added FileTree loader to $PROFILE." -ForegroundColor Cyan
}

Write-Host "FileTree successfully installed at $destPath." -ForegroundColor Green
