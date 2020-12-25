#!/snap/bin/powershell

# Syntax:       ./write-logbook.ps1 [<text>]
# Description:	writes the given text to the logbook (../Data/Logbook.csv)
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)
try {
	$Time = Get-Date -format "yyyy-MM-ddTHH:mm:ssZ" -AsUTC
	$User = $(whoami)
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	$Line = "$Time,$User,$Text"

	$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent
	write-output $Line >> "$PathToRepo/Data/Logbook.csv"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
