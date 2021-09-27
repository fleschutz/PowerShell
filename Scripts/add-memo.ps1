<#
.SYNOPSIS
	add-memo.ps1 [<text>]
.DESCRIPTION
	Adds the given memo text to $HOME/Memos.csv
.EXAMPLE
	PS> ./add-memo "Buy apples"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "" ) { $text = read-host "Enter the memo text to add" }

	$Path = "$HOME/Memos.csv"
	$Time = get-date -format "yyyy-MM-ddTHH:mm:ssZ" -asUTC
	$User = $(whoami)
	$Line = "$Time,$User,$text"

	if (-not(test-path "$Path" -pathType leaf)) {
		write-output "Time,User,text" > "$Path"
	}
	write-output $Line >> "$Path"

	"✔️ added to 📄$Path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
