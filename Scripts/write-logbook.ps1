#!/snap/bin/powershell

# Syntax:       ./write-logbook.ps1 [<text>]
# Description:	writes the given text to Data/Logbook.csv
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)
try {
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}

	$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent

	$Timestamp = Get-Date -format "yyyy-MM-dd HH:mm:ss" -AsUTC
	$UserName = $(whoami)
	$Line = "$Timestamp,$UserName,$Text"

	write-output $Line >> "$PathToRepo/Data/Logbook.csv"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
