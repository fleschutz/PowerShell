<#
.SYNOPSIS
	Sets the working directory to the user's videos folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's videos folder.
.EXAMPLE
	PS> ./cd-videos
	📂/home/Joe/Videos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	if ($IsLinux) {
		$Path = Resolve-Path "$HOME/Videos"
	} else {
		$Path = [Environment]::GetFolderPath('MyVideos')
	}
	if (-not(Test-Path "$Path" -pathType container)) {
		throw "Videos folder at 📂$Path doesn't exist (yet)"
	}
	set-location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
