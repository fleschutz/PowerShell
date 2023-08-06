<#
.SYNOPSIS
        Installs Chocolatey (needs admin rights)
.DESCRIPTION
        This PowerShell script installs Chocolatey onto the local computer (needs admin rights).
.EXAMPLE
        PS> ./install-chocolatey.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

try {
	[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
	iwr https://community.chocolatey.org/install.ps1 -UseBasicParsing | iex
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
