#Requires -Version 7.0

<#
.SYNOPSIS
Converts images in a directory or a single image file to WebP format in parallel.

.DESCRIPTION
This script takes an input directory containing images (jpg, jpeg, png, gif, bmp, tiff) or a single image file,
and converts them to the WebP format using ImageMagick's 'magick' command.
The conversion process runs in parallel to speed up processing large numbers of files.
The level of parallelism can be controlled.

.PARAMETER InputPath
The path to the input directory containing images or a single image file.

.PARAMETER OutputDir
The path to the directory where the converted WebP files will be saved. It will be created if it doesn't exist.

.PARAMETER Quality
The quality setting for the WebP conversion (0-100). Lower values mean smaller files but potentially lower quality. Defaults to 50.

.PARAMETER Lossless
Specifies whether to use lossless WebP compression ($true) or lossy compression ($false). Defaults to $true.

.PARAMETER MaxParallel
The maximum number of image conversions to run concurrently. Defaults to 10.

.EXAMPLE
.\convert_parallel.ps1 -InputPath .\covers -OutputDir .\covers-webp -Quality 50 -Lossless $true -MaxParallel 10
Converts all supported images in the '.\covers' directory to WebP in '.\covers-webp' using quality 50, lossless compression, running up to 10 conversions simultaneously.

.EXAMPLE
.\convert_parallel.ps1 -InputPath .\my_image.png -OutputDir .\output -Quality 80 -Lossless $false
Converts the single file '.\my_image.png' to WebP in '.\output' using quality 80 and lossy compression. Parallelism doesn't apply to single files.

.NOTES
Requires PowerShell 7.0 or higher for ForEach-Object -Parallel.
Requires ImageMagick to be installed and accessible via the 'magick' command in your PATH.
Progress reporting for parallel operations is limited; output messages might appear interleaved.
#>
param (
    [Parameter(Mandatory=$true)]
    [string]$InputPath,

    [Parameter(Mandatory=$true)]
    [string]$OutputDir,

    [ValidateRange(0,100)]
    [int]$Quality = 50,

    [bool]$Lossless = $true,

    [ValidateRange(1, [int]::MaxValue)] # Ensure at least 1 parallel task
    [int]$MaxParallel = 10
)

# --- Input Validation and Setup ---

# Check if input exists
if (-not (Test-Path $InputPath)) {
    Write-Error "Input path does not exist: $InputPath"
    exit 1
}

# Create output directory if it doesn't exist
if (-not (Test-Path $OutputDir -PathType Container)) {
    Write-Host "Creating output directory: $OutputDir"
    try {
        New-Item -ItemType Directory -Path $OutputDir -ErrorAction Stop | Out-Null
    } catch {
        Write-Error "Failed to create output directory '$OutputDir': $_"
        exit 1
    }
}

# Check if ImageMagick is installed and accessible
if (-not (Get-Command magick -ErrorAction SilentlyContinue)) {
    Write-Error "ImageMagick is not installed or not in your PATH. Please install it from https://imagemagick.org/."
    exit 1
}

# Check if input is a file or directory
$InputItem = Get-Item $InputPath
$isFileInput = $InputItem -is [System.IO.FileInfo]

# Convert lossless parameter to string for command
$losslessValue = $Lossless.ToString().ToLower()

Write-Host "Starting conversion..."
Write-Host "Input: $InputPath"
Write-Host "Output: $OutputDir"
Write-Host "Quality: $Quality"
Write-Host "Lossless: $Lossless"
if (!$isFileInput) {
    Write-Host "Max Parallelism: $MaxParallel"
}
Write-Host "-------------------------------------"

# --- Conversion Functions ---

# Function to convert a single file (used for non-parallel case)
function Convert-SingleFile {
    param (
        [string]$FilePath,
        [string]$OutDir,
        [int]$ConvQuality,
        [string]$ConvLosslessValue
    )

    $fileName = [System.IO.Path]::GetFileName($FilePath)
    $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
    $outputFilePath = Join-Path $OutDir "$fileNameWithoutExt.webp"

    Write-Host "Converting '$fileName' to WebP..."
    try {
        # Use Start-Process to capture stderr better if needed, or stick with '&' for simplicity
        & magick $FilePath -quality $ConvQuality -define webp:lossless=$ConvLosslessValue $outputFilePath
        Write-Host "Successfully converted '$fileName' to '$outputFilePath'" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to convert '$fileName': $_"
        # Consider adding specific error details from stderr if using Start-Process
    }
}

# --- Main Conversion Logic ---

$startTime = Get-Date

if ($isFileInput) {
    # Process single file directly
    Convert-SingleFile -FilePath $InputPath -OutDir $OutputDir -ConvQuality $Quality -ConvLosslessValue $losslessValue
    $totalFiles = 1
}
else {
    # Process all image files in directory using parallel processing
    Write-Host "Gathering image files from '$InputPath'..."
    $imageFiles = Get-ChildItem -Path $InputPath -File | Where-Object {
        $_.Extension -match '\.(jpg|jpeg|png|gif|bmp|tiff)$'
    }

    $totalFiles = $imageFiles.Count
    $processedCount = 0 # Simple counter, not perfectly synced for progress bar

    if ($totalFiles -eq 0) {
        Write-Warning "No supported image files found in '$InputPath'."
        exit 0
    }

    Write-Host "Found $totalFiles image files. Starting parallel conversion (MaxParallel = $MaxParallel)..."

    $imageFiles | ForEach-Object -Parallel {
        # Variables from the outer scope need $using:
        $currentFile = $_
        $fName = $currentFile.Name
        $fNameWithoutExt = $currentFile.BaseName
        $outputFPath = Join-Path $using:OutputDir "$fNameWithoutExt.webp"

        Write-Host "($PID) Starting conversion: $fName" # ($PID) shows the process ID handling this item

        try {
            # Execute ImageMagick command
            & magick $currentFile.FullName -quality $using:Quality -define webp:lossless=$using:losslessValue $outputFPath

            # Basic success message (output might be interleaved)
            Write-Host "($PID) Finished conversion: $fName -> $outputFPath" -ForegroundColor Cyan
        }
        catch {
            # Basic error message (output might be interleaved)
            Write-Error "($PID) Failed to convert '$fName': $_"
        }

        # Incrementing a counter for precise progress in parallel is complex.
        # This provides a basic idea but isn't a reliable progress bar.
        # [System.Threading.Interlocked]::Increment([ref]$using:processedCount) | Out-Null
        # $prog = [math]::Round(($using:processedCount / $using:totalFiles) * 100)
        # Write-Progress -Activity "Converting images to WebP (Parallel)" -Status "Processed approx. $using:processedCount of $using:totalFiles" -PercentComplete $prog -Id 1

    } -ThrottleLimit $MaxParallel # Control the number of parallel runs

    # Write-Progress -Activity "Converting images to WebP (Parallel)" -Completed -Id 1
    Write-Host "-------------------------------------"
    Write-Host "Parallel conversion process finished."
}

$endTime = Get-Date
$duration = $endTime - $startTime

Write-Host "====================================="
Write-Host "Conversion Summary"
Write-Host "Total files processed: $totalFiles"
Write-Host "Duration: $($duration.ToString())"
Write-Host "Output directory: $OutputDir"
Write-Host "=====================================" -ForegroundColor Green