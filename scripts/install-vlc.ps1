<#
.SYNOPSIS
	Installs VLC
.DESCRIPTION
	This PowerShell script installs the VLC media player.
.EXAMPLE
	PS> ./install-vlc.ps1
	⏳ Installing VLC media player...
	✔️ Installation of VLC media player took 25 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ Installing VLC media player..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	& winget install --id XPDM1ZW6815MQM --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "Can't install VLC media player, is it already installed?" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Installation of VLC media player took $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
