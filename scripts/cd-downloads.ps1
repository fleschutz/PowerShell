<#
.SYNOPSIS
	Sets the working directory to the user's downloads folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's downloads folder.
.EXAMPLE
	PS> ./cd-downloads
	📂C:\Users\Markus\Downloads entered (has 0 files and 0 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux -or $IsMacOS) {
		if (-not(Test-Path "~/Downloads" -pathType container)) {
			throw "No 📂Downloads folder in your home directory yet"
		}
		$path = Resolve-Path "~/Downloads"
	} else {
		$path = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
		if (-not(Test-Path "$path" -pathType container)) {
			throw "No downloads folder at 📂$path"
		}
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
