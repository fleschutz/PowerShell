<#
.SYNOPSIS
	Creates a new PowerShell script file
.DESCRIPTION
	Creates a new PowerShell script file (by using template file ../Data/template.ps1).
.PARAMETER filename
	Specifies the path to the resulting file
.EXAMPLE
	PS> ./new-script myscript.ps1
	✔️ created new PowerShell script: myscript.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$filename = "")

try {
	if ($filename -eq "" ) { $shortcut = read-host "Enter the new filename" }

	copy-item "$PSScriptRoot/../Data/template.ps1" "$filename"

	"✔️ created new PowerShell script: $filename"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
