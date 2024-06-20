<#
.SYNOPSIS
        Provide help to the user
.DESCRIPTION
        This PowerShell script launches new tabs in the Web browser with help pages.
.EXAMPLE
        PS> ./open-help.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	""
	& "$PSScriptRoot/write-typewriter.ps1" "OK - DON'T PANIC - HELP IS ON THE WAY..." 150
	""
	& "$PSScriptRoot/open-URL.ps1" -text "1. See the official PowerShell documentation at: " "https://docs.microsoft.com/en-us/powershell" 
	Start-Sleep -milliseconds 50

	& "$PSScriptRoot/open-URL.ps1" -text "2. A PowerShell tutorial is at: " "https://www.guru99.com/powershell-tutorial.html" 
	Start-Sleep -milliseconds 50

	& "$PSScriptRoot/open-URL.ps1" -text "3. PowerShell FAQ's can be found here: " "https://github.com/fleschutz/PowerShell/blob/main/docs/FAQ.md" 
	Start-Sleep -milliseconds 50

	& "$PSScriptRoot/open-URL.ps1" -text "4. A PowerShell Cheat Sheet is at: " "https://github.com/fleschutz/PowerShell/blob/main/docs/cheat-sheet.md"
	""
	"NOTE: Use <Ctrl> + <Click> to open the links in your browser."
        exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}