<#
.SYNOPSIS
	Installs Syncthing
.DESCRIPTION
	This PowerShell script installs Syncthing on your computer.
	Syncthing is a continuous file synchronization program. See https://syncthing.net for details.
.EXAMPLE
	PS> ./install-syncthing.ps1
	⏳ Installing Syncthing from WinGet...
	...
.LINK
	Author: Markus Fleschutz | License: CC0
.NOTES
	https://github.com/fleschutz/PowerShell
#>

#requires -version 5.1

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		"⏳ Installing Syncthing..."
		& sudo apt install syncthing
	} else {
		"⏳ Installing Syncthing from WinGet..."
		& winget install --id Syncthing.Syncthing --accept-package-agreements --accept-source-agreements

		"⏳ Starting Syncthing as daemon..."
		Start-Process -NoNewWindow "$env:LOCALAPPDATA\Microsoft\WinGet\Links\syncthing.exe"
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Syncthing installed successfully in $($elapsed)s."
	"   Web interface:  http://127.0.0.1:8384  (open by: <Ctrl> <click>)"
	"   Sync folder at: ~/Sync/                (execute: cd-sync.ps1)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
