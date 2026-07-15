<#
.SYNOPSIS
	Creates a Jenkinsfile
.DESCRIPTION
	This PowerShell script creates a new Jenkinsfile from data/templates/.
.PARAMETER path
	Specifies the path and new filename ('Jenkinsfile' by default)
.EXAMPLE
	PS> ./new-jenkinsfile.ps1 
	✅ New 'Jenkinsfile' created (from data/templates/New.jenkinsfile).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "Jenkinsfile")

try {
	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$pathToTemplate = Resolve-Path "$PSScriptRoot/data/templates/New.jenkinsfile" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy template to: $path" }

	"✅ New '$path' created (from data/templates/)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
