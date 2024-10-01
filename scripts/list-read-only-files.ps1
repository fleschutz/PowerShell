<#
.SYNOPSIS
	Lists all read-only files in a directory tree
.DESCRIPTION
	This PowerShell script scans a directory tree and lists all read-only files.
.PARAMETER path
	Specifies the path to the directory tree (current working dir by default)
.EXAMPLE
	PS> ./list-read-only-files.ps1 C:\Windows
	...
	✅ Found 107 read-only files within 📂C:\Windows in 50 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$path = Resolve-Path "$path"
	Write-Progress "Scanning $path for read-only files..."
	[int]$count = 0
	Get-ChildItem "$path" -attributes ReadOnly -recurse | Foreach-Object {
		"📄$($_.FullName)"
		$count++
	}
	Write-Progress -completed " "
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Found $count read-only files within 📂$path in $elapsed sec" 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
