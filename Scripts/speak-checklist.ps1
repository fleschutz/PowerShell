<#
.SYNTAX       speak-checklist.ps1 [<name>]
.DESCRIPTION  speaks the given checklist by text-to-speech (TTS)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Name = "")
if ($Name -eq "") { $Name = read-host "Enter the name of the checklist" }

try {
	$Lines = Get-Content -path "$PSScriptRoot/../Data/Checklists/$Name.txt"
	clear-host
	$Step = 1
	foreach($Line in $Lines) {
		if ($Line -like "HEAD*") { & "$PSScriptRoot/write-big.ps1" "$($Line.substring(5))"; continue }

		""			
		"($Step) $Line"
		& "$PSScriptRoot/speak-english.ps1" "$Line"
		$Dummy = read-host "    Say <Check> or press <Return> to continue"
		$Step++
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
