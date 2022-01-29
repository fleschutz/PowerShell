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
	Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"👉 Installing Knot Resolver... [step 1/4]"
	& sudo snap install knot-resolver-gael

	"👉 Copying default configuration... [step 2/4]"
	& sudo cp "$PSScriptRoot/../Data/default.kresd.conf" /var/snap/knot-resolver-gael/current/kresd.conf

	"👉 Let user configure... [step 3/4]"
	& sudo vi /var/snap/knot-resolver-gael/current/kresd.conf

	"👉 Starting Knot Resolver... [step 4/4]"
	& sudo snap start knot-resolver-gael

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Knot Resolver in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
