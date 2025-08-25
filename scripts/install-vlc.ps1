<#
.SYNOPSIS
	Installs VLC
.DESCRIPTION
	This PowerShell script installs the VLC media player.
.EXAMPLE
	PS> ./install-vlc.ps1
	⏳ Installing VLC media player from Winget...
	✅ VLC media player installed successfully in 25s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	"⏳ Installing VLC media player from WinGet..."
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	& winget install --id VideoLAN.VLC --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne 0) { throw "Can't install VLC media player, is it already installed?" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ VLC media player installed successfully in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
