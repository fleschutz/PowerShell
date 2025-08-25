<#
.SYNOPSIS
	Installs signal-cli 
.DESCRIPTION
	This PowerShell script installs signal-cli from github.com/AsamK/signal-cli.
	See the Web page for the correct version number.
.PARAMETER Version
	Specifies the version to install
.EXAMPLE
	PS> ./install-signal-cli 0.11.12
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$Version = "")

try {
	if ($Version -eq "") { $Version = read-host "Enter version to install (see https://github.com/AsamK/signal-cli)" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	set-location /tmp

	& wget --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'wget' - make sure wget is installed and available" }

	& wget "https://github.com/AsamK/signal-cli/releases/download/v$Version/signal-cli-$($Version).tar.gz"
	if ($lastExitCode -ne 0) { throw "'wget' failed" }

	sudo tar xf "signal-cli-$Version.tar.gz" -C /opt
	if ($lastExitCode -ne 0) { throw "'sudo tar xf' failed" }

	sudo ln -sf "/opt/signal-cli-$Version/bin/signal-cli" /usr/local/bin/
	if ($lastExitCode -ne 0) { throw "'sudo ln -sf' failed" }

	rm "signal-cli-$Version.tar.gz"
	if ($lastExitCode -ne 0) { throw "'rm' failed" }

	[int]$elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ Signal-cli $Version installed to /opt and /usr/local/bin in $elapsed sec."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
