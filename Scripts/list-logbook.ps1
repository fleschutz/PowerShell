#!/snap/bin/powershell

# Syntax:       ./list-logbook.ps1 
# Description:	lists the content of the logbook (../Data/Logbook.csv)
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent

	$Table = import-csv "$PathToRepo/Data/Logbook.csv"

	write-output ""
	write-output "UTC                 User  Text"
	write-output "---------------------------------------------------------------"
	foreach($Row in $Table) {
		$Time = $Row.UTC
		$User = $Row.Username
		$Text = $Row.Text
		write-output "$Time ($User)  $Text"
	}
	write-output ""
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
