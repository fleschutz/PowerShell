<#
.SYNOPSIS
	Downloads a folder (including subfolders) from an URL
.DESCRIPTION
	This PowerShell script downloads a folder (including subfolders) from the given URL.
.PARAMETER URL
	Specifies the URL where to download from
.EXAMPLE
	PS> ./download-dir https://www.cnn.com
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$URL = "")

try {
	if ($URL -eq "") { $URL = read-host "Enter directory URL to download" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	& wget --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'wget' - make sure wget is installed and available" }

	& wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose
	if ($lastExitCode -ne "0") { throw "Can't execute 'wget --mirror $URL'" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ downloaded directory from $URL in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
