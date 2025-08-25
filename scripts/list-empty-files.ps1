<#
.SYNOPSIS
	Lists all empty files in a directory tree
.DESCRIPTION
	This PowerShell script scans a directory tree and lists all empty files.
.PARAMETER path
	Specifies the path to the directory tree (default is current working dir)
.EXAMPLE
	PS> ./list-empty-files.ps1 C:\Windows
	...
	✅ Found 6 empty files within C:\Windows in 54 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$path = Resolve-Path "$path"
	Write-Progress "Scanning $path for empty files..."
	[int]$count = 0
	Get-ChildItem $path -attributes !Directory -recurse | where {$_.Length -eq 0} | Foreach-Object {
		"📄$($_.FullName)"
		$count++
	}
	Write-Progress -completed " "
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Found $count empty files within $path in $elapsed sec" 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
