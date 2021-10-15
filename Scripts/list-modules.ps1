<#
.SYNOPSIS
	Lists all PowerShell modules
.DESCRIPTION
	This script lists all installed PowerShell modules.
.EXAMPLE
	PS> ./list-modules

	ModuleType Version    Name                                ExportedCommands
	---------- -------    ----                                ----------------
	Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer...}
	Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable...}
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-module | format-table
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
