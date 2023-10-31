<#
.SYNOPSIS
	Speaks a checklist by text-to-speech
.DESCRIPTION
	This PowerShell script speaks the given checklist by text-to-speech (TTS).
.PARAMETER Name
	Specifies the name of the checklist
.EXAMPLE
	PS> ./speak-checklist.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Name = "")

try {
	if ($Name -eq "") { $Name = Read-Host "Enter the name of the checklist" }

	$Lines = Get-Content -path "$PSScriptRoot/../data/checklists/$Name.txt"
	clear-host
	$Step = 1
	foreach($Line in $Lines) {
		if ($Line -like "HEAD*") { & "$PSScriptRoot/write-big.ps1" "$($Line.substring(5))"; continue }

		""			
		& "$PSScriptRoot/speak-english.ps1" "$($Step). $Line"
		$Dummy = Read-Host "    Say <Check> or press <Return> to continue"
		$Step++
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
