<#
.SYNOPSIS
	Change to the crash dumps folder
.DESCRIPTION
	This PowerShell script changes the working directory to the crash dumps directory (Windows only). Whenever a software crashes and crash dumps are enabled(!) a crash dump file is written. This file helps to identify the reason for the crash.
.EXAMPLE
	PS> ./cd-crashdumps
	📂C:\Users\Markus\AppData\Local\CrashDumps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) { throw "Sorry, Windows only" }

	[string]$path = Resolve-Path -Path "~"
	if (!(Test-Path "$path" -pathType container)) { throw "Home directory at $path doesn't exist (yet)" }

	$path += "\AppData\Local\CrashDumps"
	if (!(Test-Path "$path" -pathType container)) { throw "Crashdumps directory at $path doesn't exist (yet)" }
	Set-Location "$Path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
