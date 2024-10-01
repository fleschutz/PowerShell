<#
.SYNOPSIS
	Lists all empty directories in a directory tree
.DESCRIPTION
	This PowerShell script scans a directory tree and lists all empty directories.
.PARAMETER path
	Specifies the path to the directory tree (current working directory by default)
.EXAMPLE
	PS> ./list-empty-dirs.ps1 C:\Windows
	...
	✅ Found 39972 empty directories within 📂C:\Windows in 222 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$path = Resolve-Path "$path"
	Write-Progress "Scanning $path for empty folders..."
	[int]$count = 0
	Get-ChildItem "$path" -attributes Directory -recurse -force | Where-Object { @(Get-ChildItem $_.FullName -force).Count -eq 0 } | ForEach-Object {
		"📂$($_.FullName)"
		$count++
	}
	Write-Progress -completed " "
	[int]$Elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Found $count empty directories within 📂$path in $elapsed sec" 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
