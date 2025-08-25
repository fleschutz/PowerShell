<#
.SYNOPSIS
	Lists the installed languages
.DESCRIPTION
	This PowerShell script lists the installed languages.
.EXAMPLE
	PS> ./list-installed-languages.ps1

	Tag   Autonym               English Spellchecking Handwriting
	---   -------               ------- ------------- -----------
	de-DE Deutsch (Deutschland) German  True          False
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function ListInstalledLanguages { 
	$List = Get-WinUserLanguageList
	foreach ($Item in $List) {
		New-Object PSObject -property @{ 'Tag' = "$($Item.LanguageTag)"; 'Autonym' = "$($Item.Autonym)"; 'English' = "$($Item.EnglishName)"; 'Spellchecking' = "$($Item.Spellchecking)"; 'Handwriting' = "$($Item.Handwriting)" }
	}
}

try {
	ListInstalledLanguages | Format-Table -property Tag,Autonym,English,Spellchecking,Handwriting
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
