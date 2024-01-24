<#
.SYNOPSIS
	Installs software updates
.DESCRIPTION
	This PowerShell script installs software updates for the local machine (needs admin rights).
	NOTE: Use the script 'list-updates.ps1' to list the latest software updates.
.EXAMPLE
	PS> ./install-updates.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		"⏳ (1/5) Checking drive space..."
		& "$PSScriptRoot/check-drive-space.ps1" /

		"⏳ (2/5) Querying latest package information..."
		& sudo apt update

		"⏳ (3/5) Removing obsolete packages..."
		& sudo apt autoremove --yes

		"⏳ (4/5) Upgrading installed packages..."
		& sudo apt upgrade --yes

		"⏳ (5/5) Upgrading installed Snaps..."
		& sudo snap refresh
	} elseif ($IsMacOS) {
		Write-Progress "⏳ Installing updates..."
		& sudo softwareupdate -i -a
		Write-Progress -completed " "
	} else {
		Write-Progress "⏳ Installing updates from winget and Microsoft Store..."
		& winget upgrade --all --include-unknown
		Write-Progress -completed " "
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ Installed updates in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
