<#
.SYNOPSIS
	Installs basic Linux snaps 
.DESCRIPTION
	This PowerShell script installs 16 basic Linux snaps.
.EXAMPLE
	PS> ./install-basic-snaps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if (!$IsLinux) { throw "Only Linux currently support snaps" }

	"⏳ Installing 16 basic snaps (sorted alphabetically)..."
	sudo snap install ant
	sudo snap install audacity
	sudo snap install bashtop
	sudo snap install chromium
	sudo snap install cmake
	sudo snap install cups
	sudo snap install emacs --classic
	sudo snap install --edge ffmpeg
	sudo snap install firefox
	sudo snap install gimp
	sudo snap install go
	sudo snap install groovy --classic
	sudo snap install hugo
	sudo snap install nano --classic
	sudo snap install nextcloud
	sudo snap install plexmediaserver
	
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed basic snaps in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
