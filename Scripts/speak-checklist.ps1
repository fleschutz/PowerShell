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
	foreach($Line in $Lines) {
		"> $Line"
		& "$PSScriptRoot/speak-english.ps1" "$Line"
		$Dummy = read-host "Press <Return> to continue ..."
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
