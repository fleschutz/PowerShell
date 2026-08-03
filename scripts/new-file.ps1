<#
.SYNOPSIS
	Creates a new file 
.DESCRIPTION
	This PowerShell script creates a new file from a template.
.PARAMETER path
	Specifies the path and new filename ('NEW.txt' by default)
.EXAMPLE
	PS> ./new-file.ps1 
	✅ Created a new file 'NEW.txt' based on '.txt' template.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "NEW.txt", [string]$suffix = ".txt")

try {
	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$pathToTemplate = "$PSScriptRoot/data/templates/new.$($suffix)" 
	if (-not(Test-Path "$pathToTemplate" -pathType leaf)) { throw "No template file 'new.$($suffix)' yet - Please add one" }

	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy template file to: $path" }

	"✅ Created a new file '$path' based on '$suffix' template."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
