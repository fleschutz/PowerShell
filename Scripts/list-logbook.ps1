#!/snap/bin/powershell
<#
.SYNTAX         ./list-logbook.ps1 
.DESCRIPTION	lists the content of the logbook (in ../Data/logbook.csv)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	write-progress "Reading Data/logbook.csv..."
	$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent
	$Table = import-csv "$PathToRepo/Data/logbook.csv"

	write-output ""
	write-output "Time                 User  Text"
	write-output "---------------------------------------------------------------"
	foreach($Row in $Table) {
		$Time = $Row.Time
		$User = $Row.User
		$Text = $Row.Text
		write-output "$Time ($User)  $Text"
	}
	write-output ""
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
