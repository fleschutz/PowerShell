<#
.SYNOPSIS
        install-knot-resolver.ps1
.DESCRIPTION
        Installs the Knot Resolver (a DNS resolver daemon, needs admin rights).
.EXAMPLE
        PS> .\install-knot-resolver.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
        https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"👉 Step 1/4: Installing Knot Resolver..."
	sudo snap install knot-resolver-gael

	"👉 Step 2/4: Copying default configuration..."
	sudo cp "$PSScriptRoot/../Data/default.kresd.conf" /var/snap/knot-resolver-gael/current/kresd.conf

	"👉 Step 3/4: Let user configure..."
	sudo vi /var/snap/knot-resolver-gael/current/kresd.conf

	"👉 Step 4/4: Starting Knot Resolver..."
	sudo snap start knot-resolver-gael

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Knot Resolver in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
