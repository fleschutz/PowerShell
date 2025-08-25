<#
.SYNOPSIS
	Converts frames to a .MP4 video
.DESCRIPTION
	This PowerShell script converts multiple image frames into a video in MP4 format. It requires ffmpeg.
.PARAMETER SourcePattern
	Specifies the file pattern of the image frames
.PARAMTER TargetFile
	Specifies the path to the new video file.
.EXAMPLE
	PS> ./convert-frames2mp4 C:\Frames\*.jpg C:\video.mp4
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$SourcePattern = "", [string]$TargetFile = "")

try {
	if ($SourcePattern -eq "") { $SourcePattern = Read-Host "Enter file pattern of the image frames" }
	if ($TargetFile -eq "") { $TargetFile = Read-Host "Enter file path to the new video file" }
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/3) Searching for ffmpeg..."
	& ffmpeg -L
	if ($lastExitCode -ne 0) { throw "Can't execute 'ffmpeg' - make sure ffmpeg is installed and available" }

	"⏳ (2/3) Checking file pattern of the image frames..."
	$Files = (Get-ChildItem -path "$SourcePattern" -attributes !Directory)

	"⏳ (2/3) Converting source image file..."
	& ffmpeg -framerate 24 -pattern_type glob -i "$SourcePattern" -c:v libx264 -pix_fmt yuv420p "$TargetFile"

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ converted $($Files.Count) image frames to video $TargetFile in $Elapsed sec."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
