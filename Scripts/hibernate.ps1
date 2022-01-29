<#
.SYNOPSIS
	Enables hibernate mode for the local computer (needs admin rights)
.DESCRIPTION
	This PowerShell script enables hibernate mode for the local computer. It needs admin rights.
.EXAMPLE
	PS> ./hibernate
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	[Void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
	[System.Windows.Forms.Application]::SetSuspendState("Hibernate", $false, $false);

	"✔️  Done."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
