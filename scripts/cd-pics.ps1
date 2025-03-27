<#
.SYNOPSIS
	Sets the working directory to the user's pictures folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's pictures folder.
.EXAMPLE
	PS> ./cd-pics
	📂C:\Users\Markus\Pictures entered (has 7 files and 0 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$path = Resolve-Path "~/Pictures"
	} else {
		$path = [Environment]::GetFolderPath('MyPictures')
	}
	if (-not(Test-Path "$path" -pathType container)) { throw "Pictures folder at 📂$path doesn't exist (yet)" }
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
