<#
.SYNOPSIS
	new-script.ps1 [<filename>] 
.DESCRIPTION
	Creates a new PowerShell script.
.EXAMPLE
	PS> .\new-script.ps1 myscript.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$filename = "")

try {
	if ($filename -eq "" ) { $shortcut = read-host "Enter the new filename" }

	copy-item "$PSScriptRoot/../data/template.ps1" "$filename"

	"✔️ created new PowerShell script $filename"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
