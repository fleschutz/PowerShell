<#
.SYNOPSIS
	Opens a text editor
.DESCRIPTION
	This PowerShell script opens the installed text editor with the given text file.
	Supported are: Emacs, Helix, pico, nano, neovim, Notepad, vi, vim, Visual Studio Code and Wordpad.
.PARAMETER path
	Specifies the path to the text file (default is to query the user to specify it)
.EXAMPLE
	PS> ./edit.ps1 C:\MyDiary.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

function TryEditor { param([string]$editor, [string]$path)
	try {
		Write-Host "$editor..." -noNewline
		& $editor "$path"
		if ($lastExitCode -ne 0) { "⚠️ Can't execute '$editor' - make sure it's installed and available"; exit 1 }
		exit 0 # success
	} catch { return }
}

if ($path -eq "" ) { $path = Read-Host "Enter the path to the text file" }
if (-not(Test-Path "$path" -pathType leaf)) { throw "Can't access file '$path'" }
Write-Host "⏳ Editing '$path' by executing " -noNewline
TryEditor "nvim"        $path
TryEditor "vim"         $path
TryEditor "vi"          $path
TryEditor "nano"        $path
TryEditor "pico"        $path
TryEditor "hx"          $path
TryEditor "emacs"       $path
TryEditor "Code"        $path
TryEditor "notepad.exe" $path
TryEditor "edit.exe"    $path
TryEditor "wordpad.exe" $path
Write-Host ""

"⚠️ Sorry, no text editor found. Please install your favorite one (e.g. by executing 'winget install helix.helix')."
exit 1
