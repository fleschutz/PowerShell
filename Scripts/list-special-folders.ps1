<#
.SYNOPSIS
	Lists special folders
.DESCRIPTION
	This PowerShell script lists all special folders (sorted alphabetically).
.EXAMPLE
	PS> ./list-special-folders

	Folder Name     Folder Path
	-----------     -----------
	📂Autostart     C:\Users\Markus\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetTempDir {
        if ("$env:TEMP" -ne "") { return "$env:TEMP" }
        if ("$env:TMP" -ne "")  { return "$env:TMP" }
        if ($IsLinux) { return "/tmp" }
        return "C:\Temp"
}

function AddLine { param([string]$FolderName, [string]$FolderPath)
	New-Object PSObject -property @{ 'Folder Name' = "$FolderName"; 'Folder Path' = "$FolderPath" }
}

function ListSpecialFolders {
	if ($IsLinux) {
		AddLine "📂Desktop"          "$HOME/Desktop"
		AddLine "📂Downloads"        "$HOME/Downloads"
		AddLine "📂Home Folder"      "$HOME"
		AddLine "📂My Documents"     "$HOME/Documents"
		AddLine "📂My Music"         "$HOME/Music"
		AddLine "📂My Pictures"      "$HOME/Pictures"
		AddLine "📂My Screenshots"   "$HOME/Pictures/Screenshots"
		AddLine "📂My Videos"        "$HOME/Videos"
		AddLine "📂Temporary Folder" "$(GetTempDir)"
		$Path = Resolve-Path "$HOME/.."
		AddLine "📂Users"            "$Path"
	} else {
		$Path = Resolve-Path "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
		AddLine "📂Autostart"        "$Path"
		AddLine "📂Desktop"          "$([Environment]::GetFolderPath('DesktopDirectory'))"
		AddLine "📂Downloads"        "$((New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path)"
		AddLine "📂Fonts"            "$([Environment]::GetFolderPath('Fonts'))"
		AddLine "📂Home Folder"      "$HOME"
		AddLine "📂My Documents"     "$([Environment]::GetFolderPath('MyDocuments'))"
		AddLine "📂My Music"         "$([Environment]::GetFolderPath('MyMusic'))"
		AddLine "📂My Pictures"      "$([Environment]::GetFolderPath('MyPictures'))"
		AddLine "📂My Screenshots"   "$([Environment]::GetFolderPath('MyPictures'))\Screenshots"
		AddLine "📂My Videos"        "$([Environment]::GetFolderPath('MyVideos'))"
		AddLine "📂Temporary Folder" "$(GetTempDir)"
		$Path = Resolve-Path "$HOME/.."
		AddLine "📂Users"            "$Path"
		AddLine "📂Windows"          "$([Environment]::GetFolderPath('Windows'))"
	}
}

try {
	ListSpecialFolders | Format-Table -property @{e='Folder Name';width=20},'Folder Path'
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}