<#
.SYNOPSIS
	Launches the Firefox browser
.DESCRIPTION
	This PowerShell script launches the Mozilla Firefox Web browser.
.EXAMPLE
	PS> ./open-firefox
.PARAMETER URL
	Specifies an URL
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$URL = "http://www.fleschutz.de")

try {
	$App = Get-AppxPackage -Name Mozilla.FireFox
	if ($App.Status -eq "Ok") {
		# starting Firefox UWP app:
		explorer.exe shell:appsFolder\$($App.PackageFamilyName)!FIREFOX
	} else {
		# starting Firefox program:
		start-process firefox.exe "$URL"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
