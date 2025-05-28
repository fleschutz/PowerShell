<#
.SYNOPSIS
	Sets the working directory to the user's music folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's music folder.
.EXAMPLE
	PS> ./cd-music
	📂C:\Users\Markus\Music entered (has 3 folders and 0 files)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		if (-not(Test-Path "~/Music/" -pathType container)) {
			throw "No music folder at ~/Music/"
		}
		$path = Resolve-Path "~/Music"
	} else {
		$path = [Environment]::GetFolderPath('MyMusic')
		if (-not(Test-Path "$path" -pathType container)) {
			throw "No music folder at: $path"
		}
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($folders.Count) folders and $($files.Count) files)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
