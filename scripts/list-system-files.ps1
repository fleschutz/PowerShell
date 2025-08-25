<#
.SYNOPSIS
	Lists all system files in a directory tree
.DESCRIPTION
	This PowerShell script scans a directory tree and lists all system files.
.PARAMETER path
	Specifies the path to the directory tree (default is current working dir)
.EXAMPLE
	PS> ./list-system-files.ps1 C:\Windows
	...
	✅ Found 764 system files within 📂C:\windows in 50s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$path = Resolve-Path "$path"
	Write-Progress "Scanning $path for system files..."
	[int]$count = 0
	Get-ChildItem "$path" -attributes System -recurse | Foreach-Object {
		"📄$($_.FullName)"
		$count++
	}
	Write-Progress -completed " "
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Found $count system files within 📂$path in $($elapsed)s." 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
