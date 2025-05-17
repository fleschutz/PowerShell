<#
.SYNOPSIS
	Installs Syncthing
.DESCRIPTION
	This PowerShell scripts installs Syncthing on your computer.
.EXAMPLE
	PS> ./install-syncthing.ps1
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
	"✅ Syncthing installed successfully in $($elapsed)s. Visit 127.0.0.1:8384 for setup and see the ~/Sync folder"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
