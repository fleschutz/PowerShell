<#
.SYNOPSIS
	Updates the user's PowerShell profile
.DESCRIPTION
	This PowerShell script write/overwrites the PowerShell profile of the current user.
.PARAMETER path
	Specifies the path to the new profile ($PSScriptRoot/my-profile.ps1 by default)
.EXAMPLE
	PS> ./update-powershell-profile.ps1
	⏳ (1/2) Querying path to PowerShell profile 'CurrentUserCurrentHost'...
	⏳ (2/2) Copying my-profile.ps1 to /home/Markus/.config/powershell/Microsoft.PowerShell_profile.ps1...
	✅ Updated your PowerShell profile, it get's active on next login.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PSScriptRoot/my-profile.ps1")

try {
	"⏳ (1/2) Querying path to PowerShell profile 'CurrentUserCurrentHost'..."
	$pathToProfile = $PROFILE.CurrentUserCurrentHost

	$filename = (Get-Item "$path").Name
	"⏳ (2/2) Copying $filename to $pathToProfile..."
	$null = New-Item -Path $pathToProfile -ItemType "file" -Force
	Copy-Item "$path" "$pathToProfile" -force

	"✅ Updated your PowerShell profile, it get's active on next login."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
