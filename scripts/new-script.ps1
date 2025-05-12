<#
.SYNOPSIS
	Creates a new PowerShell script
.DESCRIPTION
	This PowerShell script creates a new PowerShell script file by using the template file at: ../data/templates/PowerShell.ps1.
.PARAMETER path
	Specifies the path and new filename
.EXAMPLE
	PS> ./new-script.ps1 bot.ps1
	✅ New PowerShell script 'bot.ps1' created from template 'PowerShell.ps1'.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the new filename" }

	$pathToTemplate = Resolve-Path "$PSScriptRoot/../data/templates/PowerShell.ps1" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy to: $path" }

	"✅ New PowerShell script '$path' created from template 'PowerShell.ps1'."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
