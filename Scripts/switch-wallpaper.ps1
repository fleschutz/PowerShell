<#
.SYNOPSIS
	Switches to a random wallpaper
.DESCRIPTION
	This script downloads a random photo and sets it as desktop wallpaper.
.EXAMPLE
	PS> ./switch-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function GetTempDir {
        if ("$env:TEMP" -ne "") { return "$env:TEMP" }
        if ("$env:TMP" -ne "")  { return "$env:TMP" }
        if ($IsLinux) { return "/tmp" }
        return "C:\Temp"
}

try {
	& "$PSScriptRoot/give-reply.ps1" "Loading one from Unsplash..."

	$Path = "$(GetTempDir)/next_wallpaper.jpg"
	& wget -O $Path "https://picsum.photos/3840/2160"
	if ($lastExitCode -ne "0") { throw "Download failed" }

	& "$PSScriptRoot/set-wallpaper.ps1" -ImageFile "$Path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
