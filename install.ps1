# Dexicon CLI Installer for Windows
# Usage: irm https://raw.githubusercontent.com/Dexicon-AI/get-dexicon-cli/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

$repo = "Dexicon-AI/get-dexicon-cli"
$installDir = "$env:LOCALAPPDATA\dexicon-cli"

Write-Host ""
Write-Host "  Dexicon CLI Installer" -ForegroundColor Cyan
Write-Host "  =====================" -ForegroundColor Cyan
Write-Host ""

# Get latest release
Write-Host "Fetching latest release..." -ForegroundColor Gray
try {
    $release = Invoke-RestMethod "https://api.github.com/repos/$repo/releases/latest"
} catch {
    Write-Error "Failed to fetch release information: $_"
    exit 1
}

$version = $release.tag_name
$asset = $release.assets | Where-Object { $_.name -like "*windows-amd64.zip" }

if (-not $asset) {
    Write-Error "Windows binary not found in release $version. Please check https://github.com/$repo/releases"
    exit 1
}

Write-Host "Found version: $version" -ForegroundColor Green

# Download
$zipPath = "$env:TEMP\dexicon-cli.zip"
Write-Host "Downloading $($asset.name)..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath -UseBasicParsing
} catch {
    Write-Error "Failed to download: $_"
    exit 1
}

# Remove existing installation
if (Test-Path $installDir) {
    Write-Host "Removing existing installation..." -ForegroundColor Gray
    Remove-Item $installDir -Recurse -Force
}

# Extract
Write-Host "Extracting to $installDir..." -ForegroundColor Gray
try {
    Expand-Archive $zipPath -DestinationPath $env:LOCALAPPDATA -Force
    # The zip contains a dexicon-cli folder, so it extracts to the right place
} catch {
    Write-Error "Failed to extract: $_"
    exit 1
}

# Verify installation
if (-not (Test-Path "$installDir\dexicon.exe")) {
    Write-Error "Installation failed: dexicon.exe not found in $installDir"
    exit 1
}

# Add to PATH if not already present
$userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($userPath -notlike "*$installDir*") {
    Write-Host "Adding to PATH..." -ForegroundColor Gray
    [Environment]::SetEnvironmentVariable("PATH", "$userPath;$installDir", "User")
    $env:PATH = "$env:PATH;$installDir"
}

# Cleanup
Remove-Item $zipPath -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Installed to: $installDir" -ForegroundColor Gray
Write-Host "Version: $version" -ForegroundColor Gray
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Restart your terminal (required for PATH changes)"
Write-Host "  2. Run 'dexicon init' to configure"
Write-Host "  3. Run 'dexicon login' to authenticate"
Write-Host "  4. Run 'dexicon sync' to upload sessions"
Write-Host ""
