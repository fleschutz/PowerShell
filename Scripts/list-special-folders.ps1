<#
.SYNOPSIS
	Lists special folders
.DESCRIPTION
	This PowerShell script lists all special folders (sorted alphabetically).
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
        if ($IsLinux) { return "/tmp/" }
        return "C:\Temp"
}

function AddLine { param([string]$FolderName, [string]$FolderPath)
	if (Test-Path "$FolderPath" -pathType container) {
		New-Object PSObject -property @{ 'Folder Name' = "$FolderName"; 'Folder Path' = "📂$FolderPath" }
	}
}

function ListSpecialFolders {
	if ($IsLinux) {
		AddLine "Desktop"          "$HOME/Desktop/"
		AddLine "Documents"        "$HOME/Documents/"
		AddLine "Downloads"        "$HOME/Downloads/"
		AddLine "Dropbox"          "$HOME/Dropbox/"
		AddLine "Home"             "$HOME/"
		AddLine "Music"            "$HOME/Music/"
		AddLine "Pictures"         "$HOME/Pictures/"
		AddLine "Repositories"     "$HOME/Repos/"
		AddLine "Repositories"     "$HOME/Repositories/"
		AddLine "Screenshots"      "$HOME/Pictures/Screenshots/"
		AddLine "Snap"             "$HOME/snap/"
		AddLine "SSH"              "$HOME/.ssh/"
		AddLine "Trash"            "$HOME/.local/share/Trash/"
		AddLine "Templates"        "$Home/Templates/"
		AddLine "Temporary"        "$(GetTempDir)"
		$Path = Resolve-Path "$HOME/.."
		AddLine "Users"            "$Path/"
		AddLine "Videos"           "$HOME/Videos/"
	} else {
		$FolderNames = [System.Enum]::GetNames('System.Environment+SpecialFolder')
		$FolderNames | Sort-Object | ForEach-Object {
			if ($Path = [System.Environment]::GetFolderPath($_)) {
				AddLine "$_" "$Path"
			}
		}
		AddLine "Repositories"     "$HOME\source\repos"
		AddLine "SSH"              "$HOME\.ssh"
		AddLine "Temporary"        "$(GetTempDir)"
		$Path = Resolve-Path "$HOME/.."
		AddLine "Users"            "$Path"
	}
}

try {
	ListSpecialFolders | Format-Table -property @{e='Folder Name';width=18},'Folder Path'
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
