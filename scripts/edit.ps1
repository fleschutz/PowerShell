<#
.SYNOPSIS
	Opens a text editor
.DESCRIPTION
	This PowerShell script opens a text editor with the given text file.
.PARAMETER path
	Specifies the path to the text file (will be queried if none given)
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
		Write-Host -noNewline "$editor·"
		& $editor "$path"
		if ($lastExitCode -ne "0") {
			"⚠️ Can't execute '$editor' - make sure it's installed and available"
			exit 1
		}
		exit 0 # success
	} catch {
		return
	}
}

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the path to the text file" }

	Write-Host -noNewline "Trying "
	TryEditor "vim" $path
	TryEditor "vi" $path
	TryEditor "nano" $path
	TryEditor "pico" $path
	TryEditor "emacs" $path
	TryEditor "notepad.exe" $path
	TryEditor "wordpad.exe" $path
	Write-Host ""

	throw "No text editor found - use 'winget install' to install your favorite text editor."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
