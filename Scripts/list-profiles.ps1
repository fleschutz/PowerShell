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

function ShowProfile { param([string]$Level, [string]$Name, [string]$Filename)
	"$Level Profile '$Name'"
	if (test-path "$Filename") {
		"  at $Filename"
	} else {
		"  at $Filename (file missing)"
	}
}

try {
	ShowProfile "1" "AllUsersAllHosts"       $PROFILE.AllUsersAllHosts
	""
	ShowProfile "2" "AllUsersCurrentHost"    $PROFILE.AllUsersCurrentHost
	""
	ShowProfile "3" "CurrentUserAllHosts"    $PROFILE.CurrentUserAllHosts
	""
	ShowProfile "4" "CurrentUserCurrentHost" $PROFILE.CurrentUserCurrentHost
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
