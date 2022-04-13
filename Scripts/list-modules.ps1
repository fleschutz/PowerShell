<#
.SYNOPSIS
	Lists all PowerShell modules
.DESCRIPTION
	This PowerShell script lists all installed PowerShell modules.
.EXAMPLE
	PS> ./list-modules

	ModuleType Version    Name                                ExportedCommands
	---------- -------    ----                                ----------------
	Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer...}
	Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable...}
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	get-module | format-table
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
