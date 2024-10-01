<#
.SYNOPSIS
	Lists all hidden files in a directory tree
.DESCRIPTION
	This PowerShell script scans a directory tree and lists all hidden files.
.PARAMETER path
	Specifies the path to the directory tree (default is current working dir)
.EXAMPLE
	PS> ./list-hidden-files.ps1 C:\Windows
	...
	✅ Found 256 hidden files within 📂C:\Windows in 40 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$path = Resolve-Path "$path"
	Write-Progress "Scanning $path for hidden files..."
	[int]$count = 0
	Get-ChildItem "$path" -attributes Hidden -recurse | Foreach-Object {
		"📄$($_.FullName)"
		$count++
	}
	Write-Progress -completed " "
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Found $count hidden files within 📂$path in $elapsed sec" 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
