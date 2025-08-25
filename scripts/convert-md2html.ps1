<#
.SYNOPSIS
	Converts Markdown file(s) into HTML 
.DESCRIPTION
	This PowerShell script converts Markdown file(s) into HTML.
.PARAMETER FilePattern
	Specifies the file pattern to the Markdown file(s)
.EXAMPLE
	PS> ./convert-md2html.ps1 *.md
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$FilePattern = "")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($FilePattern -eq "" ) { $FilePattern = Read-Host "Enter the file pattern to the Markdown file(s)" }

	Write-Host "⏳ Searching for pandoc..." 
	$null = (pandoc --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'pandoc' - make sure it's installed and available" }

	Write-Host "⏳ Converting..."
	gci -r -i $FilePattern | foreach {
		$TargetPath = $_.directoryname + "\" + $_.basename + ".html"
		pandoc --standalone --template "$PSScriptRoot/../data/templates/template.html" -s $_.name -o $TargetPath
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ converted in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
