<#
.SYNTAX       add-memo.ps1 [<text>]
.DESCRIPTION  adds the given memo text to $HOME/Memos.csv
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "")
if ($Text -eq "" ) { $Text = read-host "Enter the memo text to add" }

try {
	$Path = "$HOME/Memos.csv"
	$Time = get-date -format "yyyy-MM-ddTHH:mm:ssZ" -asUTC
	$User = $(whoami)
	$Line = "$Time,$User,$Text"

	if (-not(test-path "$Path")) {
		write-output "Time,User,Text" > "$Path"
	}
	write-output $Line >> "$Path"

	"✔️ added to 📄$Path"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
