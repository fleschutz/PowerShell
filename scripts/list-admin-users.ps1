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
	# Get a list of local groups that have administrators 
	$adminGroup = Get-LocalGroupMember -Group "Administrators" 

	# Output the members of the administrators group 
	Write-Host "Users with administrator privileges:" 
	foreach ($user in $adminGroup) { 
	    Write-Host $user.Name 
	} 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
