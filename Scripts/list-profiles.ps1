#!/usr/bin/pwsh
<#
.SYNTAX       ./list-profiles.ps1
.DESCRIPTION  lists your PowerShell profiles
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

function ShowProfile { param([int]$Level, [string]$Name, [string]$Filename)
	write-output "Level: $Level"
	write-output "Name:  $Name"
	if (test-path "$Filename") {
		write-output "File:  $Filename"
	} else {
		write-output "File:  $Filename (file missing)"
	}
	write-output ""
}

try {
	write-output ""
	write-output "PowerShell Profiles"
	write-output "==================="
	ShowProfile 1 "AllUsersAllHosts"       $PROFILE.AllUsersAllHosts
	ShowProfile 2 "AllUsersCurrentHost"    $PROFILE.AllUsersCurrentHost
	ShowProfile 3 "CurrentUserAllHosts"    $PROFILE.CurrentUserAllHosts
	ShowProfile 4 "CurrentUserCurrentHost" $PROFILE.CurrentUserCurrentHost
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
