<#
.SYNOPSIS
	Uninstalls the Chrome browser
.DESCRIPTION
	This PowerShell script uninstalls the Google Chrome browser from the local computer.
.EXAMPLE
	PS> ./uninstall-chrome.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ Uninstalling Google Chrome..."

	& winget uninstall --id Google.Chrome
	if ($lastExitCode -ne "0") { throw "Can't uninstall Google Chrome, is it installed?" }

	"✔️ Google Chrome is uninstalled now."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}