<#
.SYNTAX       cd-recycle-bin.ps1 
.DESCRIPTION  go to the user's recycle bin folder 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

function Get-CurrentUserSID { [CmdletBinding()] param()
	Add-Type -AssemblyName System.DirectoryServices.AccountManagement
	return ([System.DirectoryServices.AccountManagement.UserPrincipal]::Current).SID.Value
}


$TargetDir = 'C:\$Recycle.Bin\' + "$(Get-CurrentUserSID)"
set-location "$TargetDir"
"📂$TargetDir"
exit 0
