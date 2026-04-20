<#
.SYNOPSIS
	Unzips a file
.DESCRIPTION
	This PowerShell script unzips a file (.ZIP suffix).
.PARAMETER path
	Specifies the path to the .ZIP file.
.EXAMPLE
	PS> ./unzip-file.ps1 C:\file.zip
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the path to the .ZIP file" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Extracting $path to $pwd ..."
	$fullPath = Get-ChildItem -Path $pwd -Filter $path | ForEach-Object { $_.FullName }

	Expand-Archive -Path $fullPath -DestinationPath $pwd

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅  File unzipped in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
