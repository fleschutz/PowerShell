<#
.SYNOPSIS
	Installs software updates
.DESCRIPTION
	This PowerShell script installs software updates for the local machine (might need admin rights).
	NOTE: Use the script 'list-updates.ps1' to list the latest software updates before.
.EXAMPLE
	PS> ./install-updates.ps1
	⏳ (1/2) Checking drive and swap space...
	✅ Drive C: uses 56% of 1TB · 441GB free
	✅ Swap space uses 2% of 1GB · 1GB free

	⏳ (2/2) Installing updates from winget and Microsoft Store...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		"⏳ (1/5) Checking drive and swap space..."
		& "$PSScriptRoot/check-drive-space.ps1" /
		& "$PSScriptRoot/check-swap-space.ps1"
		""
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
		"⏳ (1/2) Checking drive and swap space..."
		& "$PSScriptRoot/check-drive-space.ps1" C
		& "$PSScriptRoot/check-swap-space.ps1"
		""
		"⏳ (2/2) Installing updates from winget and Microsoft Store..."
		""
		& winget upgrade --all --include-unknown
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Installed updates in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
