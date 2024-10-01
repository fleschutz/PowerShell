<#
.SYNOPSIS
	Writes text á la typewriter
.DESCRIPTION
	This PowerShell script writes the given text with the typewriter effect.
.PARAMETER text
	Specifies the text to write
.PARAMETER speed
	Specifies the speed (250 ms by default)
.EXAMPLE
	PS> ./write-typewriter "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "`nHello World`n-----------`n* PowerShell is powerful - fully control your computer`n* PowerShell is cross-platform - available for Linux, Mac OS and Windows`n* PowerShell is open-source and free`n* PowerShell is easy to learn`n* PowerShell is fully documented`n`nThanks for watching`nMarkus`n", [int]$speed = 200) # in milliseconds

try {
	$Random = New-Object System.Random
	$text -split '' | ForEach-Object {
		Write-Host -noNewline $_
		Start-Sleep -milliseconds $(1 + $Random.Next($speed))
	}
	Write-Host ""
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}