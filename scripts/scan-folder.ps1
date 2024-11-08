<#
.SYNOPSIS
	Scans a directory tree for malware
.DESCRIPTION
	This PowerShell script scans a directory tree for malware. Requires the installation of ESET or Windows Defender.
.PARAMETER path
	Specifies the file path to the folder (default is working directory).
.EXAMPLE
	PS> ./scan-folder.ps1 C:\Windows
	⏳ Scanning 📂C:\Windows with ESET Antivirus...
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

		"⏳ Scanning 📂$path with ESET Antivirus..."
		& "C:\Program Files\ESET\ESET Security\ecls.exe" $path
		if ($lastExitCode -ne 0) { throw "ESET Antivirus failed with exit code $lastExitCode - POTENTIAL DANGER!!!" }

	} elseif (Test-Path "C:\Program Files\Windows Defender\MpCmdRun.exe" -pathType leaf) {

		"⏳ Scanning 📂$path with Windows Defender..."
		& "C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2 -File $path
		if ($lastExitCode -ne 0) { throw "Windows Defender failed with exit code $lastExitCode - POTENTIAL DANGER !!!" }

	} else {
		throw "Found no ESET or Windows Defender - please install one."
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Scanned 📂$path in $($elapsed)s: No malware found."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
