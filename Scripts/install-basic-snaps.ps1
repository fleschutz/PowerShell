<#
.SYNOPSIS
	Installs basic Linux snaps 
.DESCRIPTION
	This PowerShell script installs 18 basic Linux snaps.
.EXAMPLE
	PS> ./install-basic-snaps.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if (!$IsLinux) { throw "Only Linux currently support snaps" }

	"⏳ Installing 19 Snaps (sorted alphabetically)..."
	sudo snap install ant
	sudo snap install audacity
	sudo snap install bashtop
	sudo snap install chromium
	sudo snap install cmake
	sudo snap install cups
	sudo snap install emacs --classic
	sudo snap install ffmpeg --edge
	sudo snap install firefox
	sudo snap install gimp
	sudo snap install go
	sudo snap install gradle --classic
	sudo snap install groovy --classic
	sudo snap install hugo
	sudo snap install jenkins --edge --classic 
	sudo snap install nano --classic
	sudo snap install nextcloud
	sudo snap install node --classic
	sudo snap install plexmediaserver
	
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed 19 Snaps in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
