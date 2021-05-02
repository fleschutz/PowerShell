<#
.SYNTAX       edit.ps1 <filename>
.DESCRIPTION  starts the built-in text editor to edit the given file
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Filename = "")

try {
	if ($IsLinux) {
		& vi "$Filename"
		if ($lastExitCode -ne "0") { throw "Can't execute 'vi' - make sure vi is installed and available" }
	} else {
		& notepad.exe "$Filename"
		if ($lastExitCode -ne "0") { throw "Can't execute 'notepad.exe' - make sure notepad.exe is installed and available" }
	}

	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
