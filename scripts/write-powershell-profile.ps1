<#
.SYNOPSIS
	Writes the user's PowerShell profile
.DESCRIPTION
	This PowerShell script writes the PowerShell profile for the current user.
.EXAMPLE
	PS> ./write-powershell-profile.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ (1/3) Querying path to PowerShell profile 'CurrentUserCurrentHost'..."
	$pathToProfile = $PROFILE.CurrentUserCurrentHost

	"⏳ (2/3) Creating the profile (if non-existent)..."
	$null = New-Item -Path $pathToProfile -ItemType "file" -Force

	"⏳ (3/3) Updating the profile by my-profile.ps1..."
	Copy-Item "$PSScriptRoot/my-profile.ps1" "$pathToProfile" -force

	"✔️ Updated your PowerShell profile - it gets active on next login"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
