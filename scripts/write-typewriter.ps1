<#
.SYNOPSIS
	Writes text like a typewriter
.DESCRIPTION
	This PowerShell script writes the given text with the typewriter effect.
.PARAMETER text
	Specifies the text to write (sample text by default)
.PARAMETER speed
	Specifies the speed (200 ms by default)
.EXAMPLE
	PS> ./write-typewriter.ps1 "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "Hello World, this is the PowerShell typewriter.", [int]$speed = 200) # in milliseconds

try {
	$Random = New-Object System.Random
	$text -split '' | ForEach-Object {
		Write-Host $_ -noNewline
		Start-Sleep -milliseconds $Random.Next($speed)
	}
	Write-Host ""
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
