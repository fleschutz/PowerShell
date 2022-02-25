<#
.SYNOPSIS
	Sets the working directory to the documents folder
.DESCRIPTION
	This PowerShell script changes the working directory to the documents folder.
.EXAMPLE
	PS> ./cd-docs
	📂C:\Users\Joe\Documents
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	if ($IsLinux) {
		$DocsFolder = Resolve-Path "$HOME/Documents"
	} else {
		$DocsFolder = [Environment]::GetFolderPath('MyDocuments')
	}
	if (-not(Test-Path "$DocsFolder" -pathType container)) {
		throw "Documents folder at 📂$DocsFolder doesn't exist (yet)"
	}
	set-location "$DocsFolder"
	"📂$DocsFolder"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
