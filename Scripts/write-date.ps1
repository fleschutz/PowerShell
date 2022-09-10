<#
.SYNOPSIS
	Writes the current date 
.DESCRIPTION
	This PowerShell script determines and writes the current date.
.EXAMPLE
	PS> ./write-date
	Sunday, October 17, 2021
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentthread.currentculture = [system.globalization.cultureinfo]"en-US"
	$CurrentDate = (Get-Date).ToShortDateString()
	"📅$CurrentDate"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}