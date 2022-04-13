<#
.SYNOPSIS
	Opens an editor to edit a file
.DESCRIPTION
	This PowerShell script opens a text editor to edit the given file.
.PARAMETER Filename
	Specifies the path to the filename
.EXAMPLE
	PS> ./edit C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$Filename = "")

try {
	if ($IsLinux) {
		& vi "$Filename"
		if ($lastExitCode -ne "0") { throw "Can't execute 'vi' - make sure vi is installed and available" }
	} else {
		& notepad.exe "$Filename"
		if ($lastExitCode -ne "0") { throw "Can't execute 'notepad.exe' - make sure notepad.exe is installed and available" }
	}

	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
