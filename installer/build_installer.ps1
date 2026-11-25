#!/usr/bin/env pwsh
<#
.SYNOPSIS
Builds the Shelf Windows installer using Inno Setup.

.DESCRIPTION
This script reads the version from pubspec.yaml, builds the Flutter Windows release,
copies the VC++ runtime DLLs for app-local deployment, and invokes Inno Setup's ISCC.exe
to create a per-user installer (no admin prompt required).

.REQUIREMENTS
- Visual Studio 2022+ with C++ workload (for VC++ runtime DLLs)
- Inno Setup 6 (ISCC.exe must be in PATH or specify -ISCCPath)
- Flutter SDK in PATH
- .env file present with publishable keys only

.PARAMETER ISCCPath
Path to ISCC.exe if not in PATH.

.PARAMETER VCRedistPath
Path to the VC++ Redist x64 folder containing msvcp140.dll, vcruntime140.dll, vcruntime140_1.dll.
If not specified, attempts to auto-detect from Visual Studio 2022/2026 installation.

.EXAMPLE
.\build_installer.ps1

.EXAMPLE
.\build_installer.ps1 -ISCCPath "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" -VCRedistPath "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Redist\MSVC\14.52.37025\x64\Microsoft.VC145.CRT"
#>

param(
    [string]$ISCCPath = "ISCC.exe",
    [string]$VCRedistPath = ""
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$projectRoot = Split-Path -Parent $scriptDir

Write-Host "=== Shelf Windows Installer Build ===" -ForegroundColor Cyan
Write-Host "Project root: $projectRoot"

# 1. Read version from pubspec.yaml
$pubspecPath = Join-Path $projectRoot "pubspec.yaml"
if (-not (Test-Path $pubspecPath)) {
    Write-Error "pubspec.yaml not found at $pubspecPath"
    exit 1
}

$pubspecContent = Get-Content $pubspecPath -Raw
$versionMatch = [regex]::Match($pubspecContent, 'version:\s*(\S+)')
if (-not $versionMatch.Success) {
    Write-Error "Could not parse version from pubspec.yaml"
    exit 1
}

$version = $versionMatch.Groups[1].Value.Trim()
Write-Host "App version: $version" -ForegroundColor Green

# 2. Run flutter build windows --release
Write-Host "`n=== Building Flutter Windows Release ===" -ForegroundColor Cyan
Push-Location $projectRoot
try {
    flutter build windows --release
} finally {
    Pop-Location
}

$releaseDir = Join-Path $projectRoot "build\windows\x64\runner\Release"
if (-not (Test-Path $releaseDir)) {
    Write-Error "Release directory not found: $releaseDir"
    exit 1
}
Write-Host "Release build output: $releaseDir" -ForegroundColor Green

# 3. Locate VC++ runtime DLLs
if (-not $VCRedistPath) {
    # Auto-detect: try common VS 2022/2026 paths
    $vsPaths = @(
        "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Redist\MSVC\*\x64\Microsoft.VC145.CRT",
        "C:\Program Files\Microsoft Visual Studio\18\Professional\VC\Redist\MSVC\*\x64\Microsoft.VC145.CRT",
        "C:\Program Files\Microsoft Visual Studio\18\Enterprise\VC\Redist\MSVC\*\x64\Microsoft.VC145.CRT",
        "C:\Program Files\Microsoft Visual Studio\17\Community\VC\Redist\MSVC\*\x64\Microsoft.VC143.CRT",
        "C:\Program Files\Microsoft Visual Studio\17\Professional\VC\Redist\MSVC\*\x64\Microsoft.VC143.CRT",
        "C:\Program Files\Microsoft Visual Studio\17\Enterprise\VC\Redist\MSVC\*\x64\Microsoft.VC143.CRT"
    )

    foreach ($pattern in $vsPaths) {
        $matches = Get-ChildItem $pattern -ErrorAction SilentlyContinue | Sort-Object Name -Descending
        if ($matches.Count -gt 0) {
            $VCRedistPath = $matches[0].FullName
            Write-Host "Auto-detected VC++ Redist: $VCRedistPath" -ForegroundColor Green
            break
        }
    }
}

if (-not $VCRedistPath -or -not (Test-Path $VCRedistPath)) {
    Write-Error "VC++ Redist path not found. Specify with -VCRedistPath parameter."
    exit 1
}

$requiredDlls = @("msvcp140.dll", "vcruntime140.dll", "vcruntime140_1.dll")
foreach ($dll in $requiredDlls) {
    $dllPath = Join-Path $VCRedistPath $dll
    if (-not (Test-Path $dllPath)) {
        Write-Error "Required DLL not found: $dllPath"
        exit 1
    }
}

# 4. Create staging folder and copy release + VC++ DLLs
$stagingDir = Join-Path $projectRoot "build\staging"
if (Test-Path $stagingDir) {
    Remove-Item $stagingDir -Recurse -Force
}
New-Item -ItemType Directory -Path $stagingDir | Out-Null

Write-Host "`n=== Copying release files to staging ===" -ForegroundColor Cyan
Copy-Item -Path (Join-Path $releaseDir "*") -Destination $stagingDir -Recurse -Force

Write-Host "=== Copying VC++ runtime DLLs ===" -ForegroundColor Cyan
foreach ($dll in $requiredDlls) {
    $src = Join-Path $VCRedistPath $dll
    $dst = Join-Path $stagingDir $dll
    Copy-Item $src $dst -Force
    Write-Host "  Copied $dll"
}

# 5. Run Inno Setup
$issPath = Join-Path $scriptDir "Shelf.iss"
if (-not (Test-Path $issPath)) {
    Write-Error "Shelf.iss not found at $issPath"
    exit 1
}

$outputDir = Join-Path $projectRoot "build\installer"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

$outputBaseName = "Shelf-Setup-$version"
$outputExe = "$outputBaseName.exe"
Write-Host "`n=== Running Inno Setup ===" -ForegroundColor Cyan
Write-Host "ISCC: $ISCCPath"
Write-Host "Script: $issPath"
Write-Host "Output: $outputDir\$outputExe"

$isccArgs = @(
    "/DAppVersion=$version",
    "/O$outputDir",
    "/F$outputBaseName",
    $issPath
)

Write-Host "Command: $ISCCPath $($isccArgs -join ' ')"

$exitCode = & $ISCCPath @isccArgs
if ($LASTEXITCODE -ne 0) {
    Write-Error "Inno Setup failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "`n=== Installer created successfully ===" -ForegroundColor Green
Write-Host "Output: $outputDir\$outputExe"
$finalSize = (Get-Item "$outputDir\$outputExe").Length
Write-Host "Size: $([math]::Round($finalSize / 1MB, 2)) MB"