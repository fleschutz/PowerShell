<#
.SYNOPSIS
	Uninstalls 9 ZIP
.DESCRIPTION
	This PowerShell script uninstalls 9 ZIP from the local computer.
.EXAMPLE
	PS> ./uninstall-nine-zip
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/talk2windows
#>

try {
	& "$PSScriptRoot/_reply.ps1" "Uninstalling 9 ZIP, please wait..."

	& winget uninstall "9 ZIP - open rar, zip, 7zip, gzip"
	if ($lastExitCode -ne "0") { throw "Can't uninstall 9 ZIP, is it installed?" }

	& "$PSScriptRoot/_reply.ps1" "9 ZIP is uninstalled now."
	exit 0 # success
} catch {
	& "$PSScriptRoot/_reply.ps1" "Sorry: $($Error[0])"
	exit 1
}
