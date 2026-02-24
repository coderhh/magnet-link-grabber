# PowerShell script to prepare extension for Chrome Web Store submission
# Run this script from the extension directory

Write-Host "Preparing extension for Chrome Web Store submission..." -ForegroundColor Green

# Get current version from manifest.json
$manifestPath = "manifest.json"
if (Test-Path $manifestPath) {
    $manifest = Get-Content $manifestPath | ConvertFrom-Json
    $version = $manifest.version
    Write-Host "Current version: $version" -ForegroundColor Cyan
} else {
    Write-Host "Error: manifest.json not found!" -ForegroundColor Red
    exit 1
}

# Create zip filename with version
$zipFileName = "magnet-link-grabber-v$version.zip"

# Remove old zip if exists
if (Test-Path $zipFileName) {
    Write-Host "Removing old zip file: $zipFileName" -ForegroundColor Yellow
    Remove-Item $zipFileName -Force
}

# Files and folders to include in the zip
$filesToInclude = @(
    "manifest.json",
    "popup.html",
    "popup.js",
    "popup.css",
    "content.js",
    "icons"
)

# Check if all required files exist
Write-Host "`nChecking required files..." -ForegroundColor Cyan
$allFilesExist = $true
foreach ($file in $filesToInclude) {
    if (Test-Path $file) {
        Write-Host "  ✓ $file" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $file (MISSING!)" -ForegroundColor Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    Write-Host "`nError: Some required files are missing!" -ForegroundColor Red
    exit 1
}

# Create the zip file
Write-Host "`nCreating zip file: $zipFileName" -ForegroundColor Cyan
try {
    Compress-Archive -Path $filesToInclude -DestinationPath $zipFileName -Force
    Write-Host "✓ Zip file created successfully!" -ForegroundColor Green
    
    # Get file size
    $zipSize = (Get-Item $zipFileName).Length / 1MB
    Write-Host "  File size: $([math]::Round($zipSize, 2)) MB" -ForegroundColor Cyan
    
    Write-Host "`n✓ Extension is ready for Chrome Web Store submission!" -ForegroundColor Green
    Write-Host "  Zip file: $zipFileName" -ForegroundColor Cyan
    Write-Host "`nNext steps:" -ForegroundColor Yellow
    Write-Host "  1. Go to https://chrome.google.com/webstore/devconsole" -ForegroundColor White
    Write-Host "  2. Click 'New Item' and upload: $zipFileName" -ForegroundColor White
    Write-Host "  3. Fill out the store listing information" -ForegroundColor White
    Write-Host "  4. Upload screenshots from store_assets/ folder" -ForegroundColor White
    Write-Host "  5. Submit for review" -ForegroundColor White
    
} catch {
    Write-Host "Error creating zip file: $_" -ForegroundColor Red
    exit 1
}
