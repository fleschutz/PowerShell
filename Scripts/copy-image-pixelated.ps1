<#
.SYNOPSIS
	Copy a single image into a series of pixelated images
.DESCRIPTION
	This PowerShell script copies a single image file into a series of pixelated images in a target dir.
	Requires ImageMagick 6.
.PARAMETER SourceFile
	Specifies the path to the image source file
.PARAMTER TargetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./copy-image-pixelated C:\my_photo.jpg C:\Temp
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

	$Factor = 0.001
	for ($i = 0; $i -lt 297; $i++) {
		$FrameNo = '{0:d4}' -f $i
		$TargetFile = "$TargetDir/frame_$($FrameNo).jpg"
		"⏳ ($($i + 3)/300) Copying to $TargetFile with pixelation factor $Factor..."
		$Coeff1 = 100.0 * $Factor
		$Coeff2 = 100.0 / $Factor
		& convert-im6 -scale $Coeff1% -scale $Coeff2% "$SourceFile" "$TargetFile"
		$Factor += 0.0005
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ copied image $SourceFile to 300 pixelated frames in 📂$TargetDir in $Elapsed sec."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
