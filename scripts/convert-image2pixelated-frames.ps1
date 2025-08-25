<#
.SYNOPSIS
	Converts an image into pixelated frames
.DESCRIPTION
	This PowerShell script converts a single image file into a series of pixelated frames in a target dir.
	Requires ImageMagick 6.
.PARAMETER SourceFile
	Specifies the path to the image source file
.PARAMTER TargetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./convert-image2pixelated-frames C:\my_photo.jpg C:\Temp
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$SourceFile = "", [string]$TargetDir = "", [int]$Frames = 700)

try {
	if ($SourceFile -eq "") { $SourceFile = Read-Host "Enter file path to source image file" }
	if ($TargetDir -eq "") { $TargetDir = Read-Host "Enter file path to target directory" }
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/$Frames) Checking source image file..."
	if (!(Test-Path "$SourceFile" -pathType leaf)) { throw "Can't access source image file: $SourceFile" }
	$Basename = (Get-Item "$SourceFile").Basename

	"⏳ (2/$Frames) Searching for ImageMagick 6 executable..."
	& convert-im6 --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'convert-im6' - make sure ImageMagick 6 is installed and available" }

	$Factor = 0.001
	for ($i = 0; $i -lt $Frames; $i++) {
		$FrameNo = '{0:d4}' -f $i
		$TargetFile = "$TargetDir/frame_$($FrameNo).jpg"
		"⏳ ($($i + 3)/$Frames) Converting with pixelation factor $Factor to $TargetFile..."
		$Coeff1 = 100.0 * $Factor
		$Coeff2 = 100.0 / $Factor
		& convert-im6 -scale $Coeff1% -scale $Coeff2% "$SourceFile" "$TargetFile"
		$Factor += 0.0005
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ converted image $SourceFile to $Frames pixelated frames in 📂$TargetDir in $Elapsed sec."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
