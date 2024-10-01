<#
.SYNOPSIS
	Lists all executables in a dir tree
.DESCRIPTION
	This PowerShell script scans a given directory tree and lists all executables with suffix .EXE.
.PARAMETER path
	Specifies the path to the directory tree (current working directory by default)
.EXAMPLE
	PS> ./list-executables.ps1 C:\Windows
	C:\Windows\bfsvc.exe
	...
	✅ Found 7967 executables within 📂C:\Windows in 168 sec.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Progress "Listing executables within $path ..."
	$path = Resolve-Path "$path"
	[int]$count = 0
	Get-ChildItem "$path" -attributes !Directory -recurse -force | Where-Object { $_.Name -like "*.exe" } | ForEach-Object {
		"$($_.FullName)"
		$count++
	}
	Write-Progress -completed " "
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Found $count executables within 📂$path in $elapsed sec." 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
