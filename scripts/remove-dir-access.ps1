<#
.SYNOPSIS
	Removes directory access
.DESCRIPTION
	This PowerShell script denies access of the current user to a directory.
.PARAMETER directory
	Specified the path to the diretory
.EXAMPLE
	PS> ./remove-dir-access C:\Temp
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$directory = "$PWD")

try {
	$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

	$acl = Get-ACL $directory

	$denyRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
	    $currentUser, "FullControl", "ContainerInherit,ObjectInherit", "None", "FullControl")

	$acl.SetAccessRule($denyRule)

	Set-ACL $Directory $acl

	"✔️ Access for $currentUser to $directory is denied now."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
