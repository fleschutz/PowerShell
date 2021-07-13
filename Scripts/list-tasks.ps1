<#
.SYNOPSIS
	list-tasks.ps1 
.DESCRIPTION
	Lists all Windows scheduler tasks
.EXAMPLE
	PS> .\list-tasks.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	get-scheduledTask
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
