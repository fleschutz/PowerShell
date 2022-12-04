<#
.SYNOPSIS
	Query PowerShell details
.DESCRIPTION
	This PowerShell script queries and lists details of PowerShell.
.EXAMPLE
	PS> ./check-powershell
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
		"✅ PowerShell $Version ($Edition edition) with $NumModules modules and $NumAliases aliases"
	} else {
		$NumCmdlets = (Get-Command -Command-Type cmdlet).Count
		"✅ PowerShell $Version ($Edition edition) with $NumModules modules, $NumCmdlets cmdlets and $NumAliases aliases"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
