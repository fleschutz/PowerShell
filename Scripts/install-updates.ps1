<#
.SYNOPSIS
	install-updates.ps1
.DESCRIPTION
	Installs updates (needs admin rights)
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
		"👉 Step 1/4: Loading update infos..."
		sudo apt update

		"👉 Step 2/4: Installing updates for 'deb' packages..."
		sudo apt upgrade -y

		"👉 Step 3/4: Removing obsolete 'deb' packages..."
		sudo apt autoremove

		"👉 Step 4/4: Installing updates for snap packages..."
		sudo snap refresh
	} else {
		"Sorry, not supported yet"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed updates in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
