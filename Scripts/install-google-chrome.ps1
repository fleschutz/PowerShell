<#
.SYNOPSIS
	install-google-chrome.ps1
.DESCRIPTION
	Installs the latest Google Chrome browser.
.EXAMPLE
	PS> .\install-google-chrome.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Path = $env:TEMP;
	$Installer = "chrome_installer.exe"
	Invoke-WebRequest "http://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path\$Installer
	Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
	Remove-Item $Path\$Installer

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Google Chrome in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
