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

	"⏳ Installing basic snaps..."
	sudo snap install ant
	sudo snap install bashtop
	sudo snap install cmake
	sudo snap install cppcheck
	sudo snap install firefox
	sudo snap install go
	sudo snap install hugo
	sudo snap install nano --classic
	
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed basic snaps in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
