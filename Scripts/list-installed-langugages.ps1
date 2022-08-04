<#
.SYNOPSIS
	Lists the installed languages
.DESCRIPTION
	This PowerShell script lists the installed languages.
.EXAMPLE
	PS> ./list-installed-languages
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
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
