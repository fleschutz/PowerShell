<#
.SYNOPSIS
	Converts an image into blurred frames
.DESCRIPTION
	This PowerShell script converts a single image file into a series of blurred frames in a target dir.
	Requires ImageMagick 6.
.PARAMETER ImageFile
	Specifies the path to the image file
.PARAMTER TargetDir
	Specifies the path to the target folder
.EXAMPLE
	PS> ./convert-image2blurred-frames C:\photo.jpg C:\Temp
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ImageFile = "", [string]$TargetDir = "", [int]$ImageWidth = 1920, [int]$ImageHeight = 1393, [int]$Frames = 600)

try {
	if ($ImageFile -eq "") { $ImageFile = Read-Host "Enter file path to image file" }
	if ($TargetDir -eq "") { $TargetDir = Read-Host "Enter file path to target directory" }
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/$Frames) Checking image file..."
	if (!(Test-Path "$ImageFile" -pathType leaf)) { throw "Can't access image file: $ImageFile" }
	$Basename = (Get-Item "$ImageFile").Basename

	"⏳ (2/$Frames) Searching for ImageMagick 6..."
	& convert-im6 --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'convert-im6' - make sure ImageMagick 6 is installed and available" }

	[int]$centerX = $ImageWidth / 2 
	[int]$centerY = $ImageHeight / 2
	[int]$x = 0
	[float]$increment = $centerX / $Frames
	for ($i = 0; $i -lt $Frames; $i++) {
		$FrameNo = '{0:d4}' -f $i
		$TargetFile = "$TargetDir/frame_$($FrameNo).jpg"
		"⏳ ($i/$Frames) Converting with r=$($centerX - $x) to $TargetFile..."
		& convert-im6 -stroke black -strokewidth 9 -fill white -draw "circle $centerX,$centerY $x,$centerY" "$ImageFile" "$TargetFile"
		$x += $increment
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ converted image $ImageFile to $Frames blurred frames in 📂$TargetDir in $Elapsed sec."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
