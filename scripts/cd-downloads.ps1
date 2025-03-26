<#
.SYNOPSIS
	Sets the working directory to the user's downloads folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's downloads folder.
.EXAMPLE
	PS> ./cd-downloads
	📂C:\Users\Markus\Downloads
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$path = Resolve-Path "~/Downloads"
	} else {
		$path = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
	}
	if (-not(Test-Path "$path" -pathType container)) {
		throw "User's downloads folder at 📂$path doesn't exist (yet)"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
