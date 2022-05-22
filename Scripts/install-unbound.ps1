<#
.SYNOPSIS
        Installs Unbound (needs admin rights)
.DESCRIPTION
        This PowerShell script installs Unbound, a validating, recursive, caching DNS resolver. It needs admin rights.
.EXAMPLE
        PS> ./install-unbound
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/7: Updating package infos..."
	& sudo apt update -y
	if ($lastExitCode -ne "0") { throw "'sudo apt update' failed" }

	"⏳ Step 2/7: Installing Unbound..."
	& sudo apt install unbound -y
	if ($lastExitCode -ne "0") { throw "'sudo apt install unbound' failed" }

	"⏳ Step 3/7: Setting up Unbound..."
	& sudo unbound-control-setup
	if ($lastExitCode -ne "0") { throw "'unbound-control-setup' failed" }

	"⏳ Step 4/7: Updating DNSSEC Root Trust Anchors..."
	& sudo unbound-anchor
	if ($lastExitCode -ne "0") { throw "'unbound-anchor' failed" }

	"⏳ Step 5/7: Copying default configuration..."
	& sudo cp "$PSScriptRoot/../Data/unbound.conf" /etc/unbound/unbound.conf
	if ($lastExitCode -ne "0") { throw "'cp' failed" }

	"⏳ Step 6/7: (Re-)starting Unbound..."
	& sudo unbound-control stop
	& sudo unbound-control start
	if ($lastExitCode -ne "0") { throw "'unbound-control start' failed" }

	"⏳ Step 7/7: Checking status..."
	& sudo unbound-control status
	if ($lastExitCode -ne "0") { throw "'unbound-control status' failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Unbound in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
