<#
.SYNOPSIS
	Installs CrystalDiskInfo
.DESCRIPTION
	This PowerShell script installs CrystalDiskInfo from the Microsoft Store.
.EXAMPLE
	PS> ./install-crystal-disk-info.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	"⏳ Installing CrystalDiskInfo from Microsoft Store, please wait..."
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	& winget install "CrystalDiskInfo" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne 0) { throw "Can't install CrystalDiskInfo, is it already installed?" }

	int]$elapsed = $stopWatch.Elapsed.TotalSeconds
        "✅ CrystalDiskInfo installed successfully in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
