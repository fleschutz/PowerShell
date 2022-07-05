<#
.SYNOPSIS
	Changes the wallpaper
.DESCRIPTION
	This PowerShell script downloads a random photo from Unsplash and sets it as desktop background.
.PARAMETER Category
	Specifies the photo category (beach, city, ...)
.EXAMPLE
	PS> ./change-wallpaper 
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Category = "")

function GetTempDir {
        if ("$env:TEMP" -ne "") { return "$env:TEMP" }
        if ("$env:TMP" -ne "")  { return "$env:TMP" }
        if ($IsLinux) { return "/tmp" }
        return "C:\Temp"
}

try {
	& "$PSScriptRoot/give-reply.ps1" "Just a second..."

	$Path = "$(GetTempDir)/next_wallpaper.jpg"
	& wget -O $Path "https://source.unsplash.com/3840x2160?$Category"
	if ($lastExitCode -ne "0") { throw "Download failed" }

	& "$PSScriptRoot/set-wallpaper.ps1" -ImageFile "$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
