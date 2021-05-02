<#
.SYNTAX       list-tasks.ps1 
.DESCRIPTION  lists all Windows scheduler tasks
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	get-scheduledTask
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
