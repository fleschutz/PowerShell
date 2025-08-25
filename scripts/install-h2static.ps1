<#
.SYNOPSIS
	Installs h2static
.DESCRIPTION
	This PowerShell script installs the tiny static Web server 'h2static'.
.EXAMPLE
	PS> ./install-h2static.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([int]$port = 8070, [string]$pathToMedia = "/media/")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not($IsLinux)) { throw "Sorry, only Linux installation currently supported" }

	"⏳ (1/4) Installing h2static from Snap Store..."
	& sudo snap install h2static

	$pathToMedia = Resolve-Path $pathToMedia
	"⏳ (2/4) Configuring serve-path = $pathToMedia ..."
	& sudo snap set h2static serve-path=$pathToMedia
	& sudo snap connect h2static:removable-media

	"⏳ (3/4) Configuring disable-index = false..."
	& sudo snap set h2static disable-index=false

	"⏳ (4/4) Configuring listening-port = :$port..."
	& sudo snap set h2static listen=:$port

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ h2static installed in $($elapsed)s, Web server runs at :$port, execute 'snap info h2static' for details."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
