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
                $path = "~/Pictures"
		if (-not(Test-Path "$path" -pathType container)) { throw "Pictures folder at $path doesn't exist (yet)"	}
		if (Test-Path "$path/Screenshots" -pathType container) { $path = "$path/Screenshots" }
        } else {
                $path = [Environment]::GetFolderPath('MyPictures')
		if (-not(Test-Path "$path" -pathType container)) { throw "Pictures folder at $path doesn't exist (yet)" }
		if (Test-Path "$path\Screenshots" -pathType container) { $path = "$path\Screenshots" }
        }
	return $path
}

try {
	$path = GetScreenshotsFolder
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
