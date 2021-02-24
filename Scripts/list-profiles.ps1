#!/bin/powershell
<#
.SYNTAX         ./list-profiles.ps1
.DESCRIPTION	lists your PowerShell profiles
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

function ShowProfile { param([int]$Level, [string]$Name, [string]$Filename)
	write-output "$($Level). '$($Name)'"
	if (test-path "$Filename") {
		write-output "   at $($Filename) containing:"
		$Content = get-content $Filename
		write-output "$Content"
	} else {
		write-output "   at $Filename (file non-existent)"
	}
	write-output ""
}

try {
	write-output ""
	write-output "PowerShell Profiles"
	write-output "-------------------"
	ShowProfile 1 "AllUsersAllHosts"       $PROFILE.AllUsersAllHosts
	ShowProfile 2 "AllUsersCurrentHost"    $PROFILE.AllUsersCurrentHost
	ShowProfile 3 "CurrentUserAllHosts"    $PROFILE.CurrentUserAllHosts
	ShowProfile 4 "CurrentUserCurrentHost" $PROFILE.CurrentUserCurrentHost
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
