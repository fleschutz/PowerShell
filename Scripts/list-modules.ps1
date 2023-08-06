<#
.SYNOPSIS
	Lists PowerShell modules
.DESCRIPTION
	This PowerShell script lists the installed PowerShell modules.
.EXAMPLE
	PS> ./list-modules.ps1

	Name                             Version  ModuleType  ExportedCommands
	----                             -------  ----------  ----------------
	Microsoft.PowerShell.Management  3.1.0.0  Manifest    {Add-Computer, Add-Content, Checkpoint-Computer...}
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-Module | Format-Table -property Name,Version,ModuleType,ExportedCommands
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
