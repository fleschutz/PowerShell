#Requires -RunAsAdministrator
<#
.SYNOPSIS
	hibernate.ps1
.DESCRIPTION
	Enables hibernate mode for the local computer (needs admin rights).
.EXAMPLE
	PS> .\hibernate.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	[Void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
	[System.Windows.Forms.Application]::SetSuspendState("Hibernate", $false, $false);

	"✔️  Done."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
