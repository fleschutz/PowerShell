<#
.SYNOPSIS
	Converts a directory into a .7z file
.DESCRIPTION
	This PowerShell script compresses the given directory (including subfolders) into a compressed .7z file.
	It also preserves symbolic links and requires that 7-zip is installed.
.PARAMETER dirPath
	Specifies the path to the directory (to be entered by default)
.PARAMETER targetFile
	Specifies the path to the target file (<dirPath>.7z by default)
.EXAMPLE
	PS> ./convert-dir27z.ps1 C:\Windows Win.7z
	✅ Converted 📂C:\Windows into Win.7z in 291s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$dirPath = "", [string]$targetFile = "")

try {
	if (-not(Test-Path "C:\Program Files\7-Zip\7z.exe" -pathType leaf)) { throw "Please install 7-Zip" }
	if ($dirPath -eq "" ) { $dirPath = Read-Host "Enter the path to the folder" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$dirPath = Resolve-Path $dirPath
	if ($targetFile -eq "" ) { $targetFile = "$dirPath.7z" }

	& "C:\Program Files\7-Zip\7z.exe" a -y -snl -t7z $targetFile $dirPath

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Converted 📂$dirPath into $targetFile in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
