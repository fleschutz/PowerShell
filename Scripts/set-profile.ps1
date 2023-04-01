<#
.SYNOPSIS
	Sets the user's PowerShell profile
.DESCRIPTION
	This PowerShell script sets the PowerShell profile for the current user.
.EXAMPLE
	PS> ./set-profile
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ (1/3) Querying path to PowerShell profile 'CurrentUserCurrentHost'..."
	$PathToProfile = $PROFILE.CurrentUserCurrentHost
	"$PathToProfile"

	"⏳ (2/3) Creating the profile (if non-existent)..."
	$Null = New-Item -Path $profile -ItemType "file" -Force

	"⏳ (3/3) Copying my-profile.ps1..."
	$PathToRepo = "$PSScriptRoot/.."
	Copy-Item "$PathToRepo/Scripts/my-profile.ps1" "$PathToProfile" -force

	"✔️ updated your PowerShell profile by my-profile.ps1 - it gets active on next login"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
