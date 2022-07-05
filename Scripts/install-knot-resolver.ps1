<#
.SYNOPSIS
        Installs Knot Resolver (needs admin rights)
.DESCRIPTION
        This PowerShell script installs Knot Resolver. Knot Resolver is a DNS resolver daemon. It needs admin rights.
.EXAMPLE
        PS> ./install-knot-resolver
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/4: Installing Knot Resolver..."
	& sudo snap install knot-resolver-gael

	"⏳ Step 2/4: Copying default configuration..."
	& sudo cp "$PSScriptRoot/../Data/default.kresd.conf" /var/snap/knot-resolver-gael/current/kresd.conf

	"⏳ Step 3/4: Let user configure..."
	& sudo vi /var/snap/knot-resolver-gael/current/kresd.conf

	"⏳ Step 4/4: Starting Knot Resolver..."
	& sudo snap start knot-resolver-gael

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Knot Resolver in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
