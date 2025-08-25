<#
.SYNOPSIS
	Lists verbs in PowerShell
.DESCRIPTION
	This PowerShell script lists all allowed/recommended verbs in PowerShell.
.EXAMPLE
	PS> ./list-powershell-verbs.ps1

	Verb        Group
	----        -----
	Add         Common            
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-Verb | Sort-Object -Property Verb
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
