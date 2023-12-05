<#
.SYNOPSIS
	Creates a new PowerShell script
.DESCRIPTION
	This PowerShell script creates a new PowerShell script file by using the template file ../data/template.ps1.
.PARAMETER filename
	Specifies the path and filename to the new script
.EXAMPLE
	PS> ./new-script myscript.ps1
	✔️ Created the new 'myscript.ps1' PowerShell script in 1 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filename = "")

try {
	if ($filename -eq "" ) { $filename = Read-Host "Enter the new filename" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Copy-Item "$PSScriptRoot/../data/template.ps1" "$filename"

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Created the new '$filename' PowerShell script in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
