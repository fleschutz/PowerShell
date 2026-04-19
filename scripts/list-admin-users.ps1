<#
.SYNOPSIS
	List admin users
.DESCRIPTION
	This PowerShell script lists all users with administrator privileges.
.EXAMPLE
	PS> ./list-admin-users.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$culture = [system.threading.thread]::currentthread.currentculture
	if ($culture.name -eq "de-de") {
		$adminGroup = Get-LocalGroupMember -Group "Administratoren"
	} else {
		$adminGroup = Get-LocalGroupMember -Group "Administrators" 
	}
	# Output the members of the administrators group 
	foreach ($user in $adminGroup) { 
		Write-Host $user.Name 
	} 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
