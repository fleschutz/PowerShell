<#
.SYNOPSIS
	Writes the PowerShell profile
.DESCRIPTION
	This PowerShell script writes the PowerShell profile for the current user.
.PARAMETER path
	Specifies the path to the new profile ($PSScriptRoot/my-profile.ps1 by default)
.EXAMPLE
	PS> ./write-powershell-profile.ps1
	⏳ (1/2) Querying path to profile 'CurrentUserCurrentHost'...
	         C:\Users\Markus\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
	⏳ (2/2) Copying file 'my-profile.ps1'...
	✔️ New PowerShell profile written - it gets active on next login
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PSScriptRoot/my-profile.ps1")

try {
	"⏳ (1/2) Querying path to profile 'CurrentUserCurrentHost'..."
	$pathToProfile = $PROFILE.CurrentUserCurrentHost
	"         $pathToProfile"

	$filename = (Get-Item "$path").Name
	"⏳ (2/2) Copying file '$filename'..."
	$null = New-Item -Path $pathToProfile -ItemType "file" -Force
	Copy-Item "$path" "$pathToProfile" -force

	"✔️ New PowerShell profile written - it gets active on next login"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
