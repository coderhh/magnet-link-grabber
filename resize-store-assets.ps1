# Resize store assets to Chrome Web Store required dimensions
# Uses fit + padding to preserve all content (no cropping)

Add-Type -AssemblyName System.Drawing

$assetsDir = Join-Path $PSScriptRoot "store_assets"
$screenshot = Join-Path $assetsDir "screenshot.png"
$promo = Join-Path $assetsDir "promo_small.png"
# Output files (overwrites if not locked)
$screenshotOut = Join-Path $assetsDir "screenshot_1280x800.png"
$promoOut = Join-Path $assetsDir "promo_small_440x280.png"

function Resize-ImageFit {
    param(
        [string]$InputPath,
        [string]$OutputPath,
        [int]$TargetWidth,
        [int]$TargetHeight,
        [string]$BackgroundColor = "Black"
    )
    $img = [System.Drawing.Image]::FromFile($InputPath)
    try {
        $ratio = [Math]::Min($TargetWidth / $img.Width, $TargetHeight / $img.Height)
        $newW = [int]($img.Width * $ratio)
        $newH = [int]($img.Height * $ratio)
        $offsetX = [int](($TargetWidth - $newW) / 2)
        $offsetY = [int](($TargetHeight - $newH) / 2)

        $bmp = New-Object System.Drawing.Bitmap($TargetWidth, $TargetHeight)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

        $bgColor = [System.Drawing.Color]::FromName($BackgroundColor)
        if ($bgColor.A -eq 0) { $bgColor = [System.Drawing.Color]::Black }
        $g.Clear($bgColor)
        $g.DrawImage($img, $offsetX, $offsetY, $newW, $newH)

        $g.Dispose()
        $tempPath = [System.IO.Path]::GetTempFileName() + ".png"
        $bmp.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $bmp.Dispose()
        if (Test-Path $OutputPath) { Remove-Item $OutputPath -Force }
        Move-Item -Path $tempPath -Destination $OutputPath -Force

        Write-Host "Resized: $InputPath -> $TargetWidth x $TargetHeight (output: $OutputPath)"
    }
    finally {
        $img.Dispose()
    }
}

if (-not (Test-Path $screenshot)) {
    Write-Error "screenshot.png not found at $screenshot"
    exit 1
}
if (-not (Test-Path $promo)) {
    Write-Error "promo_small.png not found at $promo"
    exit 1
}

Resize-ImageFit -InputPath $screenshot -OutputPath $screenshotOut -TargetWidth 1280 -TargetHeight 800
Resize-ImageFit -InputPath $promo -OutputPath $promoOut -TargetWidth 440 -TargetHeight 280

# Replace originals with resized (close files in IDE first if this fails)
try {
    Copy-Item $screenshotOut $screenshot -Force
    Copy-Item $promoOut $promo -Force
    Write-Host "Replaced screenshot.png and promo_small.png with resized versions."
} catch {
    Write-Host "Could not replace originals (close in IDE). Use screenshot_1280x800.png for Chrome Store."
}

Write-Host "Done. Store assets resized to Chrome Web Store requirements."
