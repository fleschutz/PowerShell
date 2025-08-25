<#
.SYNOPSIS
	Counts the number of characters
.DESCRIPTION
	This PowerShell script counts the number of characters in the given string.
.PARAMETER GivenString
	Specifies the given string.
.EXAMPLE
	PS> ./count-characters.ps1 "Hello World"
	✅ 11 characters counted in 'Hello World'.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$givenString = "")

try {
	if ($givenString -eq "" ) { $givenString = Read-Host "Enter the string" }

	[int64]$numChars = $givenString.Length
	"✅ $numChars characters counted in '$givenString'." 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
