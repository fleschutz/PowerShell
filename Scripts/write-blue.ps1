#!/snap/bin/powershell

# Syntax:       ./write-blue.ps1 [<text>]
# Description:	writes the given text in blue
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)
try {
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	write-host -foregroundcolor blue $Text
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
