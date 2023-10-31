<#
.SYNOPSIS
	Lists all executables in a directory tree
.DESCRIPTION
	This PowerShell script scans a directory tree and lists all executables.
.PARAMETER path
	Specifies the path to the directory tree (current working directory by default)
.EXAMPLE
	PS> ./list-executables.ps1 C:\Windows
	...
	✔️ Found 8239 executables within 📂C:\Windows in 99 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$path = Resolve-Path "$path"
	Write-Progress "Scanning $path for executables..."
	[int]$count = 0
	Get-ChildItem "$path" -attributes !Directory -recurse -force | Where-Object { $_.Name -like "*.exe" } | ForEach-Object {
		"📂$($_.FullName)"
		$count++
	}
	Write-Progress -completed " "
	[int]$Elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Found $count executables within 📂$path in $elapsed sec" 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
