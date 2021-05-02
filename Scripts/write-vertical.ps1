<#
.SYNTAX       write-vertical.ps1 [<text>]
.DESCRIPTION  writes the given text in vertical direction
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "")
if ($Text -eq "" ) { $Text = read-host "Enter the text to write" }

try {
	[char[]]$TextArray = $Text
	foreach($Char in $TextArray) {
		write-output $Char
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
