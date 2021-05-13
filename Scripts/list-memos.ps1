<#
.SYNTAX       list-memos.ps1 
.DESCRIPTION  lists the memos at $HOME/Memos.csv
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>


try {
	$Path = "$HOME/Memos.csv"
	if (test-path "$Path") {
		write-progress "Reading $Path ..."
		$Table = import-csv "$Path"
		write-progress -completed "Reading $Path"

		""
		"Time                 User  Text"
		"----                 ----  ----"
		foreach($Row in $Table) {
			$Time = $Row.Time
			$User = $Row.User
			$Text = $Row.Text
			"$Time $User    $Text"
		}
	} else {
		"Sorry, no memos saved yet"
		exit 1
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
