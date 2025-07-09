﻿<#
.SYNOPSIS
	Installs Unbound server (needs admin rights)
.DESCRIPTION
	This PowerShell script installs Unbound, a validating, recursive, caching DNS resolver. It needs admin rights.
.EXAMPLE
	PS> ./install-unbound-server.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1 -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/10) Updating package infos..."
	& sudo apt update -y
	if ($lastExitCode -ne 0) { throw "'apt update' failed" }

	"⏳ (2/10) Installing the Unbound packages..."
	& sudo apt install unbound unbound-anchor -y
	if ($lastExitCode -ne 0) { throw "'apt install unbound' failed" }

	"⏳ (3/10) Setting up Unbound..."
	& sudo unbound-control-setup
	if ($lastExitCode -ne 0) { throw "'unbound-control-setup' failed" }

	"⏳ (4/10) Updating DNSSEC Root Trust Anchors..."
	& sudo unbound-anchor
	if ($lastExitCode -ne 0) { throw "'unbound-anchor' failed" }

	"⏳ (5/10) Checking config file..."
	& unbound-checkconf "$PSScriptRoot/../data/unbound.conf"
	if ($lastExitCode -ne 0) { throw "'unbound-checkconf' failed - check the syntax" }

	"⏳ (6/10) Copying config file to /etc/unbound/unbound.conf ..."
	& sudo cp "$PSScriptRoot/../data/unbound.conf" /etc/unbound/unbound.conf
	if ($lastExitCode -ne 0) { throw "'cp' failed" }

	"⏳ (7/10) Stopping default DNS cache daemon systemd-resolved..."
	& sudo systemctl stop systemd-resolved
	& sudo systemctl disable systemd-resolved

	"⏳ (8/10) (Re-)starting Unbound..."
	& sudo unbound-control stop
	& sudo unbound-control start
	if ($lastExitCode -ne 0) { throw "'unbound-control start' failed" }

	"⏳ (9/10) Checking status of Unbound..."
	& sudo unbound-control status
	if ($lastExitCode -ne 0) { throw "'unbound-control status' failed" }

	"⏳ (10/10) Training Unbound with 100 popular domain names..."
	& "$PSScriptRoot/check-dns.ps1" 
	if ($lastExitCode -ne 0) { throw "'unbound-control status' failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ Installed Unbound in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
