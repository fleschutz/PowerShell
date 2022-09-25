<#
.SYNOPSIS
	Lists special folders
.DESCRIPTION
	This PowerShell script lists the special folders (sorted alphabetically).
.EXAMPLE
	PS> ./list-special-folders

	Folder Name     Folder Path
	-----------     -----------
	AdminTools      📂C:\Users\Markus\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Administrative Tools
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
	New-Object PSObject -property @{ 'Folder Name' = "$FolderName"; 'Folder Path' = "📂$FolderPath" }
}

function ListSpecialFolders {
	if ($IsLinux) {
		AddLine "Desktop"          "$HOME/Desktop"
		AddLine "Downloads"        "$HOME/Downloads"
		AddLine "Home Folder"      "$HOME"
		AddLine "MyDocuments"      "$HOME/Documents"
		AddLine "MyMusic"          "$HOME/Music"
		AddLine "MyPictures"       "$HOME/Pictures"
		AddLine "MyScreenshots"    "$HOME/Pictures/Screenshots"
		AddLine "MyVideos"         "$HOME/Videos"
		AddLine "Temporary Folder" "$(GetTempDir)"
		$Path = Resolve-Path "$HOME/.."
		AddLine "Users"            "$Path"
	} else {
		$FolderNames = [System.Enum]::GetNames('System.Environment+SpecialFolder')
		$FolderNames | Sort-Object | ForEach-Object {
			if ($Path = [System.Environment]::GetFolderPath($_)) {
				AddLine "$_" "$Path"
			}
		}
		AddLine "TemporaryFolder"  "$(GetTempDir)"
		$Path = Resolve-Path "$HOME/.."
		AddLine "Users"            "$Path"
	}
}

try {
	ListSpecialFolders | Format-Table -property @{e='Folder Name';width=22},'Folder Path'
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}