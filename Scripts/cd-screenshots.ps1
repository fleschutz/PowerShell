<#
.SYNOPSIS
	Sets the working directory to the user's screenshots folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's screenshots folder.
.EXAMPLE
	PS> ./cd-screenshots
	📂C:\Users\Markus\Pictures\Screenshots
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetScreenshotsFolder {
        if ($IsLinux) {
                $Path = "$HOME/Pictures"
		if (-not(Test-Path "$Path" -pathType container)) { throw "Pictures folder at $Path doesn't exist (yet)"	}
		if (Test-Path "$Path/Screenshots" -pathType container) { $Path = "$Path/Screenshots" }
        } else {
                $Path = [Environment]::GetFolderPath('MyPictures')
		if (-not(Test-Path "$Path" -pathType container)) { throw "Pictures folder at $Path doesn't exist (yet)" }
		if (Test-Path "$Path\Screenshots" -pathType container) { $Path = "$Path\Screenshots" }
        }
	return $Path
}

try {
	$Path = GetScreenshotsFolder
	Set-Location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}