<#
.SYNOPSIS
	Change to the crash dumps folder
.DESCRIPTION
	This PowerShell script changes the working directory to the crash dumps directory (Windows only).
.EXAMPLE
	PS> ./cd-crashdumps
	📂C:\Users\Markus\AppData\Local\CrashDumps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[string]$Path = Resolve-Path -Path "~"
	if (!(Test-Path $Path)) { throw "Home directory at $Path doesn't exist (yet)" }
	$Path += "\AppData\Local\CrashDumps"
	if (!(Test-Path $Path)) { throw "Crashdumps directory at $Path doesn't exist (yet)" }
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
