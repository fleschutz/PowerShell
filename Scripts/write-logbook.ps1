#!/bin/powershell
<#
.SYNTAX         ./write-logbook.ps1 [<text>]
.DESCRIPTION	writes the given text to the logbook (in ../Data/logbook.csv)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Text = "")

if ($Text -eq "" ) {
	$Text = read-host "Enter the text to write"
}

try {
	$Time = get-date -format "yyyy-MM-ddTHH:mm:ssZ" -asUTC
	$User = $(whoami)
	$Line = "$Time,$User,$Text"

	$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent
	write-output $Line >> "$PathToRepo/Data/logbook.csv"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
