<#
.SYNOPSIS
	Sets the working directory to the trash folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's trash folder.
.EXAMPLE
	PS> ./cd-trash
	📂C:\$Recycle.Bin\S-1-5-21-123404-23309-294260-1001 entered (has 4 files and 0 subfolders)
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
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No trash folder at $path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) subfolders)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
