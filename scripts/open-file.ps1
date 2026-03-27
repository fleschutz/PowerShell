<#
.SYNOPSIS
	Opens a file
.DESCRIPTION
	This PowerShell scripts opens the given file with the default application.
.PARAMETER path
	Specified the file path
.EXAMPLE
	PS> ./open-file.ps1 my.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$path = "")

try {
	if (!(Test-Path "$path" -pathType leaf)) { throw "Can't access file: $path" }

	Invoke-Item $path

	Write-Host "⏳ Opening '$path' with the default application..."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
