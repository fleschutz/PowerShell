#!/snap/bin/powershell

# Syntax:       ./write-vertical.ps1 [<text>]
# Description:	writes the given text in vertical direction
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)
try {
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	[char[]]$TextArray = $Text
	foreach($Char in $TextArray) {
		write-output $Char
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
