<#
.SYNOPSIS
	Installs basic snaps
.DESCRIPTION
	This PowerShell script installs basic Windows apps such as browser, e-mail client, etc.
.EXAMPLE
	PS> ./install-basic-snaps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/1) Installing ant..."
	sudo snap install ant
	
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed basic snaps in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
