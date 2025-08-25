<#
.SYNOPSIS
	Converts a directory into a compressed .ZIP file
.DESCRIPTION
	This PowerShell script creates a new compressed .ZIP file from a directory (including subfolders).
.PARAMETER dirPath
	Specifies the path to the directory
.PARAMETER zipPath
	Specifies the path to the target .ZIP file (default is dirPath.zip)
.EXAMPLE
	PS> ./convert-dir2zip.ps1 C:\Windows Win.zip
	✅ Converted into compressed Win.zip in 291s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$dirPath = "", [string]$zipPath = "")

try {
	if ($dirPath -eq "" ) { $dirPath = Read-Host "Enter the path to the folder" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$dirPath = Resolve-Path $dirPath
	if ($zipPath -eq "" ) { $zipPath = "$dirPath.zip" }

	Compress-Archive -path $dirPath -destinationPath $zipPath

	[int]$elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ Converted into compressed $zipPath in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
