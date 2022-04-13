<#
.SYNOPSIS
	Lists the user groups on the local computer
.DESCRIPTION
	This PowerShell script lists the user groups on the local computer.
.EXAMPLE
	PS> ./list-user-groups

	Name            Description
	----            -----------
	HomeUsers       HomeUsers Security Group
	Ssh Users       Members of this group can remotely access this computer over SSH protocol.
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-LocalGroup
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
