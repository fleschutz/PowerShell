<#
.SYNOPSIS
	zip-dir.ps1 [<directory>]
.DESCRIPTION
	Creates a .zip archive of the given directory.
.EXAMPLE
	PS> .\zip-dir.ps1 C:\Windows
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$directory = "")

try {
	if ($directory -eq "" ) { $directory = read-host "Enter the path to the directory to zip" }
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$directory = resolve-path $directory
	compress-archive -path $directory -destinationPath $directory.zip

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created zip archive: $($directory).zip in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
