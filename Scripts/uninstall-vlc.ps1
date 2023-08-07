<#
.SYNOPSIS
	Uninstalls VLC
.DESCRIPTION
	This PowerShell script uninstalls the VLC media player from the local computer.
.EXAMPLE
	PS> ./uninstall-vlc.ps1
	⏳ Uninstalling VLC media player...
	✔️ Removal of VLC media player took 7 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ Uninstalling VLC media player..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	& winget uninstall --id XPDM1ZW6815MQM
	if ($lastExitCode -ne "0") { throw "Can't uninstall VLC media player, is it installed?" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Removal of VLC media player took $Elapsed sec"
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
