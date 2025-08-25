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
		TryFolder "Config files"      "/etc"
		TryFolder "Desktop"           "$HOME/Desktop"
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
		TryFolder "Scripts"           "$PSScriptRoot"
		TryFolder "Snaps"             "$HOME/snap"
		TryFolder "SSH keys"          "$HOME/.ssh"
		TryFolder "System boot"       "/boot"
		TryFolder "System binaries"   "/sbin"
		TryFolder "System devices"    "/dev"
		TryFolder "System logs"       "/var/log"
		TryFolder "Trash"             "$HOME/.local/share/Trash"
		TryFolder "Templates"         "$Home/Templates"
		TryFolder "Temporary files"   "$(GetTempDir)"
		$path = Resolve-Path "$HOME/.."
		TryFolder "Users"             "$path"
		TryFolder "Videos"            "$HOME/Videos"
	} else {
		$folderNames = [System.Enum]::GetNames('System.Environment+SpecialFolder')
		$folderNames | Sort-Object | ForEach-Object {
			if ($path = [System.Environment]::GetFolderPath($_)) {
				TryFolder "$_" "$path"
			}
		}
		TryFolder "CrashDumps"        "$HOME\AppData\Local\CrashDumps"
		TryFolder "Repositories"      "$HOME\source\repos"
		TryFolder "Scripts"           "$PSScriptRoot"
		TryFolder "SSH keys"          "$HOME\.ssh"
		TryFolder "Temporary files"   "$(GetTempDir)"
		$path = Resolve-Path "$HOME/.."
		TryFolder "Users"             "$path"
	}
}

try {
	ListSpecialFolders | Format-Table -property @{e='Folder Name';width=22},'Folder Path'
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
