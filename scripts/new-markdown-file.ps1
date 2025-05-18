<#
.SYNOPSIS
	Creates a new Markdown file 
.DESCRIPTION
	This PowerShell script creates a new Markdown file from template file at: ../data/templates/Markdown.md.
.PARAMETER path
	Specifies the path and new filename (README.md by default)
.EXAMPLE
	PS> ./new-markdown-file.ps1 
	✅ New file 'README.md' created from template 'Markdown.md'.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "README.md")

try {
	$pathToTemplate = Resolve-Path "$PSScriptRoot/../data/templates/Markdown.md" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy template to: $path" }

	"✅ New file '$path' created from template 'Markdown.md'."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
