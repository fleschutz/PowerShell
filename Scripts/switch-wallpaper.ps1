<#
.SYNOPSIS
	Switches to a random wallpaper
.DESCRIPTION
	This script download a random photo and sets it as desktop wallpaper.
.PARAMETER Style
        Specifies either Fill, Fit (default), Stretch, Tile, Center, or Span
.EXAMPLE
	PS> ./switch-wallpaper
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Style = "Span")

function GetTempDir {
        if ("$env:TEMP" -ne "") { return "$env:TEMP" }
        if ("$env:TMP" -ne "")  { return "$env:TMP" }
        if ($IsLinux) { return "/tmp" }
        return "C:\Temp"
}

function SetWallPaper {	param([string]$Image, [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')][string]$Style)
 
	$WallpaperStyle = switch($Style) {
	"Fill"    {"10"}
	"Fit"     {"6"}
	"Stretch" {"2"}
	"Tile"    {"0"}
	"Center"  {"0"}
	"Span"    {"22"}
	}
 
	if ($Style -eq "Tile") {
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force
	} else {
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
		New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force
	}
	Add-Type -TypeDefinition @" 
	using System; 
	using System.Runtime.InteropServices;
  
	public class Params
	{ 
	    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
	    public static extern int SystemParametersInfo (Int32 uAction, 
							   Int32 uParam, 
							   String lpvParam, 
							   Int32 fuWinIni);
	}
"@ 
  
	$SPI_SETDESKWALLPAPER = 0x0014
	$UpdateIniFile = 0x01
	$SendChangeEvent = 0x02
	$fWinIni = $UpdateIniFile -bor $SendChangeEvent
	$ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}

try {
	"(1/2) Downloading random photo from Unsplash..."
	$Path = "$(GetTempDir)/next_wallpaper.jpg"
	& wget -O $Path "https://unsplash.it/3840/2160/?random"

	"(2/2) Switching the wallpaper..."
	SetWallPaper -Image $Path -Style $Style

	"✔️  Done."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
