<#
.SYNOPSIS
	Sets the working directory to the trash folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's trash folder.
.EXAMPLE
	PS> ./cd-trash
	📂C:\$Recycle.Bin\S-1-5-21-123404-23309-294260-1001
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetCurrentUserSID { [CmdletBinding()] param()
	Add-Type -AssemblyName System.DirectoryServices.AccountManagement
	return ([System.DirectoryServices.AccountManagement.UserPrincipal]::Current).SID.Value
}


try {
	if ($IsLinux) {
		$path = "~/.local/share/Trash/"
	} else {
		$path = "C:\`$Recycle.Bin\$(GetCurrentUserSID)"
	}
	if (-not(Test-Path "$path" -pathType container)) { throw "Trash folder at 📂$path doesn't exist (yet)" }
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
