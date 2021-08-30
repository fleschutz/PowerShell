<#
.SYNOPSIS
	list-profiles.ps1
.DESCRIPTION
	Lists your PowerShell profiles.
.EXAMPLE
	PS> .\list-profiles.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function ListProfile { param([int]$Level, [string]$Profile, [string]$Location)
	if (test-path "$Location") { $Existent = "yes" } else { $Existent = "no" }
	new-object PSObject -Property @{
		'Level' = "$Level"
		'Profile' = "$Profile"
		'Location' = "$Location"
		'Existent' = "$Existent"
	}
}

function ListProfiles { 
	ListProfile 1 "AllUsersAllHosts"       $PROFILE.AllUsersAllHosts
	ListProfile 2 "AllUsersCurrentHost"    $PROFILE.AllUsersCurrentHost
	ListProfile 3 "CurrentUserAllHosts"    $PROFILE.CurrentUserAllHosts
	ListProfile 4 "CurrentUserCurrentHost" $PROFILE.CurrentUserCurrentHost
}


try {
	ListProfiles | format-table -property Level,Profile,Location,Existent
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
