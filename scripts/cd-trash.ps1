<#
.SYNOPSIS
	Sets the working dir to the trash folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the user's trash folder.
.EXAMPLE
	PS> ./cd-trash.ps1
	📂C:\$Recycle.Bin\S-1-5-21-123404-23309-294260-1001 with 4 files and 0 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

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
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No trash folder at $path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($files.Count) files and $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
