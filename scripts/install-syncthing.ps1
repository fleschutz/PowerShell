<#
.SYNOPSIS
	Installs Syncthing
.DESCRIPTION
	This PowerShell script installs Syncthing on your computer.
	Syncthing is a continuous file synchronization program. See https://syncthing.net for details.
.EXAMPLE
	PS> ./install-syncthing.ps1
	⏳ Installing Syncthing...
	...
.LINK
	Author: Markus Fleschutz | License: CC0
.NOTES
	https://github.com/fleschutz/PowerShell
#>

try {
	"⏳ Installing Syncthing..."
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		& sudo apt install syncthing
	} else {
		& winget install --id Syncthing.Syncthing
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Syncthing installed successfully in $($elapsed)s."
	"   Adming GUI at: http://127.0.0.1:8384 (use <Ctrl> <click>)"
	"   Your sync folder is at: ~/Sync/"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
