#!/snap/bin/powershell

# Syntax:       ./write-uppercase.ps1 [<text>]
# Description:	writes the given text in uppercase letters
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)
try {
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	write-output $Text.ToUpper()
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
