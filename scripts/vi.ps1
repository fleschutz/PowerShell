<#
.SYNOPSIS
	Edit a text file
.DESCRIPTION
	This PowerShell script opens the installed text editor with the given text file.
	It tries to use neovim, vim, vi, nano, pico, Helix, Emacs, Visual Studio Code,
	Notepad, Microsoft Edit, or Wordpad (in that order).
.PARAMETER path
	Specifies the path to the file to edit (default: ask user)
.EXAMPLE
	PS> ./vi.ps1 C:\MyDiary.txt
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

"⚠️ Sorry, no supported text editor found (Emacs, Helix, pico, nano, neovim, Notepad, vi, vim, Visual Studio Code, Wordpad)"
exit 1
