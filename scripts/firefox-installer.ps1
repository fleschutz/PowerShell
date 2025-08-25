<#
.SYNOPSIS
	firefox installer
.DESCRIPTION
	Download and install latest firefox 
.EXAMPLE
	PS> ./firefox-installer.ps1                            
.LINK
	https://github.com/pakoti/Awesome_Sysadmin
.NOTES
	Author: Dark Master | License: CC0-1,0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Path = $env:TEMP;
	$Installer = "chrome_installer.exe"
	Invoke-WebRequest "https://cdn.stubdownloader.services.mozilla.com/builds/firefox-stub/en-US/win/c0c2728dec93a47f981393e20cb0793bafd3a455e152118836bde89b2f02b614/Firefox%20Installer.exe" -OutFile $Path\$Installer
	Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
	Remove-Item $Path\$Installer

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"installed Firefox in $Elapsed sec"
	exit 0 # successfully installed firefox
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}


