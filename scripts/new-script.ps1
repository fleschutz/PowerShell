<#
.SYNOPSIS
	Creates a new PowerShell script
.DESCRIPTION
	This PowerShell script creates a new PowerShell script file by using the template file ../data/template.ps1.
.PARAMETER filename
	Specifies the path and filename to the new script
.EXAMPLE
	PS> ./new-script myscript.ps1
	✅ New PowerShell script 'myscript.ps1' created from: C:\PowerShell\data\template.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filename = "")

try {
	if ($filename -eq "" ) { $filename = Read-Host "Enter the new filename" }

	$pathToTemplate = Resolve-Path "$PSScriptRoot/../data/template.ps1" 
	Copy-Item $pathToTemplate "$filename"

	"✅ New PowerShell script '$filename' created from: $pathToTemplate"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
