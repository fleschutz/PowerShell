<#
.SYNOPSIS
	Lists the user groups on the local computer
.DESCRIPTION
	This script lists the user groups on the local computer.
.EXAMPLE
	PS> ./list-user-groups

	Name            Description
	----            -----------
	HomeUsers       HomeUsers Security Group
	Ssh Users       Members of this group can remotely access this computer over SSH protocol.
	...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-LocalGroup
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
