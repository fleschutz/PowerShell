#!/bin/powershell
<#
.SYNTAX       ./set-profile.ps1
.DESCRIPTION  sets the PowerShell profile for the current user
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$PathToProfile = $PROFILE.CurrentUserCurrentHost
	$PathToRepo = "$PSScriptRoot/.."

	copy-item "$PathToRepo/Scripts/my-profile.ps1" "$PathToProfile" -force

	write-host -foregroundColor green "OK - updated profile 'CurrentUserCurrentHost' (gets active on next login)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
