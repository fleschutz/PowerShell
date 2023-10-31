<#
.SYNOPSIS
	Installs evcc
.DESCRIPTION
	This PowerShell script installs evcc. Sevcc is an extensible EV Charge Controller with PV integration implemented in Go. See https://evcc.io for details.
.EXAMPLE
	PS> ./install-evcc.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		"⏳ (1/6) Installing necessary packets..."
		& sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl

		"⏳ (2/6) Installing keyring for evcc..."
		& curl -1sLf 'https://dl.cloudsmith.io/public/evcc/stable/setup.deb.sh' | sudo -E bash

		"⏳ (3/6) Updating packet list...."
		& sudo apt update

		"⏳ (4/6) Installing evcc packet..."
		& sudo apt install -y evcc

		"⏳ (5/6) Configuring evcc..."
		& evcc configure

		"⏳ (6/6) Starting evcc Web server on :7070 as system service..."
		& sudo systemctl start evcc
	} else {
		throw "Sorry, only Linux installation currently supported"
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ evcc installed successfully in $Elapsed sec"
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
