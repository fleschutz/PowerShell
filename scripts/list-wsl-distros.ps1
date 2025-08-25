<#
.SYNOPSIS
        Lists distros for Windows Subsystem for Linux
.DESCRIPTION
        This PowerShell script lists installed/available Linux distributions for Windows Subsystem for Linux (WSL).
.EXAMPLE
        PS> ./list-wsl-distros.ps1
	  NAME            STATE           VERSION
	* Ubuntu-24.04    Stopped         2
	...
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux -or $IsMacOS) { throw "Requires Windows Subsystem for Linux (WSL)" }

	& wsl.exe --list --verbose
	" "
	& wsl.exe --list --online
	" "
	& wsl.exe --status
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
