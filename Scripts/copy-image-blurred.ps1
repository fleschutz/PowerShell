<#
.SYNOPSIS
	Copy a single image into a series of blurred images
.DESCRIPTION
	This PowerShell script copies a single image file into a series of blurred images in a target dir.
	Requires ImageMagick 6.
.PARAMETER SourceFile
	Specifies the path to the image source file
.PARAMTER TargetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./copy-image-blurred C:\photo.jpg C:\Temp
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$SourceFile = "", [string]$TargetDir = "")

try {
	if ($SourceFile -eq "") { $SourceFile = Read-Host "Enter file path to source image file" }
	if ($TargetDir -eq "") { $TargetDir = Read-Host "Enter file path to target directory" }
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/300) Checking source image file..."
	if (!(Test-Path "$SourceFile" -pathType leaf)) { throw "Can't access source image file: $SourceFile" }
	$Basename = (Get-Item "$SourceFile").Basename

	"⏳ (2/300) Searching for ImageMagick 6 executable..."
	& convert-im6 --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'convert-im6' - make sure ImageMagick 6 is installed and available" }

	[int]$ImageWidth = 3509
	[int]$ImageHeight = 2481
	[int]$radius = 10
	[float]$heading = 0.0
	[float]$distance = 0.0
	for ($i = 297; $i -gt 0; $i--) {
		$TargetFile = "$TargetDir/$($Basename)_$($i).jpg"
		"⏳ ($(300 - $i)/300) Copying to $TargetFile..."
		[int]$x = $ImageWidth / 2  + [math]::cos($heading) * $distance
		[int]$y = $ImageHeight / 2 + [math]::sin($heading) * $distance
		& convert-im6 -fill black -draw "circle $x,$y $($x+$radius),$y" "$SourceFile" "$TargetFile"
		$distance += 5
		$heading += 0.3
		$radius += 2
		$SourceFile = $TargetFile
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ copied to a series of 300 blurred images in 📂$TargetDir in $Elapsed sec."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
