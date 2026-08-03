<#
.SYNOPSIS
	Creates a PowerShell script
.DESCRIPTION
	This PowerShell script creates a new PowerShell script file by using the template data/templates/new.ps1.
.PARAMETER path
	Specifies the path and new filename ("bot.ps1" by default)
.EXAMPLE
	PS> ./new-powershell-script.ps1 
	✅ New 'bot.ps1' created (template is from data/templates/new.ps1).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "bot.ps1")

try {
	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$pathToTemplate = Resolve-Path "$PSScriptRoot/data/templates/new.ps1" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy to: $path" }

	"✅ New '$path' created (template is from data/templates/new.ps1)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
