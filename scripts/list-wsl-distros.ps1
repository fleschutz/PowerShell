<#
.SYNOPSIS
        Lists distros for Windows Subsystem for Linux
.DESCRIPTION
        This PowerShell script lists available Linux distributions for Windows Subsystem for Linux (WSL).
.EXAMPLE
        PS> ./list-wsl-distros.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	& wsl.exe --list --online
	" "
	& wsl.exe --status
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}