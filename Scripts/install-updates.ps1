<#
.SYNOPSIS
	Installs updates for the local machine (needs admin rights)
.DESCRIPTION
	This script installs updates for the local machine (needs admin rights).
.EXAMPLE
	PS> ./install-updates
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		"⏳ Fetching update infos for installed Debian packages [step 1/4]..."
		& sudo apt update

		"⏳ Upgrading installed Debian packages [step 2/4]..."
		& sudo apt upgrade --yes

		"⏳ Removing obsolete Debian packages [step 3/4]..."
		& sudo apt autoremove --yes

		"⏳ Upgrading installed Snap packages [step 4/4]..."
		& sudo snap refresh
	} else {
		"Sorry, not supported yet"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed updates in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
