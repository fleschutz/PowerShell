﻿<#
.SYNOPSIS
	Installs Mozilla Firefox
.DESCRIPTION
	This PowerShell script installs the Mozilla Firefox browser from Microsoft Store.
.EXAMPLE
	PS> ./install-firefox.ps1
	⏳ Installing Mozilla Firefox from Microsoft Store...
        ✅ Mozilla Firefox installed successfully in 25s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	"⏳ Installing Mozilla Firefox from Microsoft Store..."

	& winget install --id 9NZVDKPMR9RD --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne 0) { throw "Can't install Mozilla Firefox, is it already installed?" }

        [int]$elapsed = $stopWatch.Elapsed.TotalSeconds
        "✅ Mozilla Firefox installed successfully in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
