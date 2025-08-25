<#
.SYNOPSIS
	Writes text in vertical direction
.DESCRIPTION
	This PowerShell script writes text in vertical direction.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-vertical "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "" ) { $text = read-host "Enter the text to write" }

	[char[]]$TextArray = $text
	foreach($Char in $TextArray) {
		write-output $Char
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
