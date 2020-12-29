#!/snap/bin/powershell
<#
.SYNTAX         ./write-red.ps1 [<text>]
.DESCRIPTION	writes the given text in a red foreground color
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Text = "")

try {
	if ($Text -eq "" ) {
		[string]$Text = read-host "Enter text to write"
	}
	write-host -foregroundcolor red $Text
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
