<#
.SYNOPSIS
	Creates a RDP file 
.DESCRIPTION
	This PowerShell script creates a new .rdp file from: data/templates/New.rdp
.PARAMETER path
	Specifies the path and new filename (SERVER.rdp by default)
.EXAMPLE
	PS> ./new-rdp.ps1 
	✅ New 'SERVER.rdp' created (from data/templates/New.rdp).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "SERVER.rdp")

try {
	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$pathToTemplate = Resolve-Path "$PSScriptRoot/data/templates/New.rdp" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy template to: $path" }

	"✅ New '$path' created (from data/templates/New.rdp)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
