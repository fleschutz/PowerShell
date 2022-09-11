<#
.SYNOPSIS
	Uninstalls 9 ZIP
.DESCRIPTION
	This PowerShell script uninstalls 9 ZIP from the local computer.
.EXAMPLE
	PS> ./uninstall-nine-zip
.LINK
	https://github.com/fleschutz/talk2windows
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling 9 ZIP, please wait..."

	& winget uninstall "9 ZIP - open rar, zip, 7zip, gzip"
	if ($lastExitCode -ne "0") { throw "Can't uninstall 9 ZIP, is it installed?" }

	"9 ZIP is uninstalled now."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}