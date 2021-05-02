<#
.SYNTAX       list-profiles.ps1
.DESCRIPTION  lists your PowerShell profiles
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
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
