#!/snap/bin/powershell
<#
.SYNTAX         ./list-scripts.ps1
.DESCRIPTION	lists the PowerShell scripts in this repository
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	write-progress "Reading Data/scripts.csv..."
	$PathToRepo = (get-item $MyInvocation.MyCommand.Path).directory.parent
	$Table = import-csv "$PathToRepo/Data/scripts.csv"

	write-output ""
	write-output "Collection of $($Table.Count) PowerShell Scripts"
	write-output "==================================="
	foreach($Row in $Table) {
		write-output "* $($Row.Filename) - $($Row.Description)"
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
