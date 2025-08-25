<#
.SYNOPSIS
	Create a new tab in Windows Terminal
.DESCRIPTION
	This PowerShell script creates and opens a new tab in Windows Terminal.
.EXAMPLE
	PS> ./new-tab.ps1 
	✅ Created a new tab in Windows Terminal.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	& wt.exe --window 0 new-tab
	if ($lastExitCode -ne 0) { throw "Executing wt.exe has failed with exit code $lastExitCode" }

	"✅ Created a new tab in Windows Terminal."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
