<#
.SYNOPSIS
	Creates a Markdown file 
.DESCRIPTION
	This PowerShell script creates a new Markdown file from template: data/templates/new.md.
.PARAMETER path
	Specifies the path and new filename (README.md by default)
.EXAMPLE
	PS> ./new-markdown-file.ps1 
	✅ New 'README.md' created (template is from data/templates/new.md).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "README.md")

try {
	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$pathToTemplate = Resolve-Path "$PSScriptRoot/data/templates/new.md" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy template to: $path" }

	"✅ New '$path' created (template is from data/templates/new.md)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
