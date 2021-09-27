<#
.SYNOPSIS
	cd-recycle-bin.ps1 
.DESCRIPTION
	Change the working directory to the user's recycle bin folder
.EXAMPLE
	PS> ./cd-recycle-bin
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

function Get-CurrentUserSID { [CmdletBinding()] param()
	Add-Type -AssemblyName System.DirectoryServices.AccountManagement
	return ([System.DirectoryServices.AccountManagement.UserPrincipal]::Current).SID.Value
}


$TargetDir = 'C:\$Recycle.Bin\' + "$(Get-CurrentUserSID)"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's recycle bin folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
