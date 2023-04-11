<#
.SYNOPSIS
	Check the PowerShell status
.DESCRIPTION
	This PowerShell script queries the PowerShell status and prints it.
.EXAMPLE
	PS> ./check-powershell
	✅ PowerShell 5.1.19041.2673 Desktop edition (10 modules, 1458 cmdlets, 172 aliases)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Version = $PSVersionTable.PSVersion
	$Edition = $PSVersionTable.PSEdition
	$NumModules = (Get-Module).Count
	$NumAliases = (Get-Alias).Count
	if ($IsLinux) {
		$Reply = "✅ PowerShell $Version $Edition edition ($NumModules modules, $NumAliases aliases)"
	} else {
		$NumCmdlets = (Get-Command -Command-Type cmdlet).Count
		$Reply = "✅ PowerShell $Version $Edition edition ($NumModules modules, $NumCmdlets cmdlets, $NumAliases aliases)"
	}
	Write-Host $Reply
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}