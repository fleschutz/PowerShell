#!/snap/bin/powershell
<#
.SYNTAX         ./write-logbook.ps1 [<text>]
.DESCRIPTION	writes the given text to the logbook (in ../Data/logbook.csv)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Text = "")

try {
	$Time = get-date -format "yyyy-MM-ddTHH:mm:ssZ" -asUTC
	$User = $(whoami)
	if ($Text -eq "" ) {
		[string]$Text = read-host "Enter text to write"
	}
	$Line = "$Time,$User,$Text"

	$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent
	write-output $Line >> "$PathToRepo/Data/logbook.csv"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
