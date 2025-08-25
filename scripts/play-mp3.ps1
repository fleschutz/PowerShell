<#
.SYNOPSIS
	Plays a .MP3 sound file 
.DESCRIPTION
	This PowerShell script plays the given sound file (MPEG-1 audio layer-3 file format).
.PARAMETER path
	Specifies the file path to the .MP3 file
.EXAMPLE
	PS> ./play-mp3.ps1 C:\thunder.mp3
	   ▶️ Playing 'thunder.mp3' (00:03) ...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the file path to the MP3 sound file" }

	if (-not(Test-Path "$path" -pathType leaf)) { throw "Can't access sound file: $path" }
	$fullPath = (Get-ChildItem $path).fullname
	$filename = (Get-Item "$fullPath").name

	Add-Type -assemblyName PresentationCore
	$mediaPlayer = New-Object System.Windows.Media.MediaPlayer

	do {
		$mediaPlayer.open($fullPath)
		$milliseconds = $mediaPlayer.NaturalDuration.TimeSpan.TotalMilliseconds
	} until ($milliseconds)

	[int]$minutes = $milliseconds / 60000
	[int]$seconds = ($milliseconds / 1000) % 60
	Write-Host "   ▶️" -noNewline -foregroundColor green
	Write-Host "Playing '$filename' ($($minutes.ToString('00')):$($seconds.ToString('00'))) ..."

	$previousTitle = $host.ui.RawUI.WindowTitle 
	$host.ui.RawUI.WindowTitle = "▶️ $filename"

	$mediaPlayer.Volume = 1
	$mediaPlayer.play()
	Start-Sleep -milliseconds $milliseconds
	$mediaPlayer.stop()
	$mediaPlayer.close()

	$host.ui.RawUI.WindowTitle = $previousTitle
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
