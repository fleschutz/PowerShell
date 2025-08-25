<#
.SYNOPSIS
	Searches for text in a repo
.DESCRIPTION
	This PowerShell script searches for the given text pattern in a Git repository.
.PARAMETER textPattern
	Specifies the text pattern to search for
.PARAMETER path
	Specifies the file path to the local Git repository 
.EXAMPLE
	PS> ./search-repo.ps1 UFO
	list-calendar.ps1:            Write-Host (" " * 4 * [int](Get-Date $day -uformat %u)) -NoNewLine
	list-calendar.ps1:            $dayOffset = [int](Get-Date -day 1 -month ($month + $i) -year $year -uformat %u)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$textPattern = "", [string]$path = "$PWD")


try {
	if ($textPattern -eq "" ) { $textPattern = Read-Host "Enter the text pattern, e.g. 'UFO'" }

	if (-not(Test-Path "$path" -pathType container)) { throw "Can't access Git repository at: $path" }

	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git -C "$path" grep $textPattern
	if ($lastExitCode -ne 0) { throw "'git grep' failed with exit code $lastExitCode" }

	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
