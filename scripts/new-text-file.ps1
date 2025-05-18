<#
.SYNOPSIS
	Creates a new text file 
.DESCRIPTION
	This PowerShell script creates a new .txt file from template file at: ../data/templates/Text.txt.
.PARAMETER path
	Specifies the path and new filename (README.txt by default)
.EXAMPLE
	PS> ./new-text-file.ps1 
	✅ New file 'README.txt' created from template 'Text.txt'.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "README.txt")

try {
	$pathToTemplate = Resolve-Path "$PSScriptRoot/../data/templates/Text.txt" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy template to: $path" }

	"✅ New file '$path' created from template 'Text.txt'."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
