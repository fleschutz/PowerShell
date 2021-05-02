<#
.SYNTAX       hibernate.ps1
.DESCRIPTION  enables hibernate mode for the local computer (needs admin rights)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	[Void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
	[System.Windows.Forms.Application]::SetSuspendState("Hibernate", $false, $false);
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
