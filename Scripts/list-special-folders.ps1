<#
.SYNOPSIS
	Lists special folders
.DESCRIPTION
	This PowerShell script lists all special folders (sorted alphabetically).
.EXAMPLE
	PS> ./list-special-folders.ps1

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

function TryFolder([string]$name, [string]$path) {
	if (Test-Path "$path" -pathType container) {
		New-Object PSObject -property @{ 'Folder Name' = "$name"; 'Folder Path' = "📂$path" }
	}
}

function ListSpecialFolders {
	if ($IsLinux) {
		TryFolder "Boot files"        "/boot"
		TryFolder "Config files"      "/etc"
		TryFolder "Desktop"           "$HOME/Desktop"
		TryFolder "Device files"      "/dev"
		TryFolder "Documents"         "$HOME/Documents"
		TryFolder "Downloads"         "$HOME/Downloads"
		TryFolder "Dropbox"           "$HOME/Dropbox"
		TryFolder "Home"              "$HOME"
		TryFolder "Mount points"      "/mnt"
		TryFolder "Music"             "$HOME/Music"
		TryFolder "Optional packages" "/opt"
		TryFolder "Pictures"          "$HOME/Pictures"
		TryFolder "Recovered files"   "/lost+found"
		TryFolder "Removable media"   "/media"
		TryFolder "Repositories"      "$HOME/Repos"
		TryFolder "Repositories"      "$HOME/Repositories"
		TryFolder "Root"              "/"
		TryFolder "Screenshots"       "$HOME/Pictures/Screenshots"
		TryFolder "Snap"              "$HOME/snap"
		TryFolder "SSH"               "$HOME/.ssh"
		TryFolder "System binaries"   "/sbin"
		TryFolder "Trash"             "$HOME/.local/share/Trash"
		TryFolder "Templates"         "$Home/Templates"
		TryFolder "Temporary"         "$(GetTempDir)"
		$Path = Resolve-Path "$HOME/.."
		TryFolder "Users"             "$Path"
		TryFolder "Videos"            "$HOME/Videos"
	} else {
		$FolderNames = [System.Enum]::GetNames('System.Environment+SpecialFolder')
		$FolderNames | Sort-Object | ForEach-Object {
			if ($Path = [System.Environment]::GetFolderPath($_)) {
				TryFolder "$_" "$Path"
			}
		}
		TryFolder "Repositories"     "$HOME\source\repos"
		TryFolder "SSH"              "$HOME\.ssh"
		TryFolder "Temporary"        "$(GetTempDir)"
		$Path = Resolve-Path "$HOME/.."
		TryFolder "Users"            "$Path"
	}
}

try {
	ListSpecialFolders | Format-Table -property @{e='Folder Name';width=19},'Folder Path'
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
