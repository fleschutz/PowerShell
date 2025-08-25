<#
.SYNOPSIS
	Creates a text file 
.DESCRIPTION
	This PowerShell script creates a new .txt file from: ../data/templates/New.txt.
.PARAMETER path
	Specifies the path and new filename (README.txt by default)
.EXAMPLE
	PS> ./new-text-file.ps1 
	✅ New 'README.txt' created (from data/templates/New.txt).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "README.txt")

try {
	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$pathToTemplate = Resolve-Path "$PSScriptRoot/../data/templates/New.txt" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy template to: $path" }

	"✅ New '$path' created (from data/templates/New.txt)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
