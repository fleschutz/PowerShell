<#
.SYNOPSIS
	Scans a folder for malware
.DESCRIPTION
	This PowerShell script scans a folder for malware (including subfolders). Requires ESET Endpoint Security or Windows Defender.
.PARAMETER path
	Specifies the file path to the folder (default is working directory).
.EXAMPLE
	PS> ./scan-folder.ps1 C:\Windows
	⏳ Scanning C:\Windows with ESET Endpoint Security...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(Test-Path $path -pathType container)) { throw "Invalid file path: $path" }
	$path = Resolve-Path $path

	if (Test-Path "C:\Program Files\ESET\ESET Security\ecls.exe" -pathType leaf) {
		Write-Host "⏳ Scanning $path with ESET Endpoint Security..."
		& "C:\Program Files\ESET\ESET Security\ecls.exe" $path
		if ($lastExitCode -ne 0) { throw "ESET Endpoibnt Security exited with code $lastExitCode - POTENTIAL THREAT !!!" }

	} elseif (Test-Path "C:\Program Files\Windows Defender\MpCmdRun.exe" -pathType leaf) {
		Write-Host "⏳ Scanning $path with Windows Defender..."
		& "C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2 -File $path
		if ($lastExitCode -ne 0) { throw "Windows Defender exited with code $lastExitCode - POTENTIAL THREAT !!!" }

	} else {
		throw "No ESET Endpoint Security or Windows Defender available - please install one."
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	Write-Host "✅ Scanned $path in $($elapsed)s: No malware found."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
