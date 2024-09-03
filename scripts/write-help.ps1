<#
.SYNOPSIS
        Provide help to the user
.DESCRIPTION
        This PowerShell script launches new tabs in the Web browser with help pages.
.EXAMPLE
        PS> ./open-help.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function Line ([string]$line) {
	Write-Host $line -foregroundColor white -backgroundColor black
}

try {
	Line "█████████████████████████████████████"
	Line "█████████████████████████████████████"
	Line "████ ▄▄▄▄▄ █▀ █▀▀█▀▀  ▄▄██ ▄▄▄▄▄ ████"
	Line "████ █   █ █▀ ▄ █▀ ▀ ▀▄█ █ █   █ ████"
	Line "████ █▄▄▄█ █▀█ █▄▀▄▀ ▀ ▄▄█ █▄▄▄█ ████"
	Line "████▄▄▄▄▄▄▄█▄█▄█ █▄█ █▄▀ █▄▄▄▄▄▄▄████"
	Line "████▄▄  ▄█▄▄  ▄█▄▄ █▀ ▀▀▀ ▀▄▀▄█▄▀████"
	Line "████▀▄▄█▀█▄██ ▀ ▄▄▀ █▄█▀ ▀ ▄▀▀█▀█████"
	Line "█████ ▄▄█▄▄▀▄ ▀▄▀ ▄▄  ▀ ▀▀▀ ▀▄▄█▀████"
	Line "████▄ ▀ ▄ ▄▄█  █▀██▄ ██▀▄█▄▄▀▄▄▀█████"
	Line "████  ████▄▄  ▄█▄▄▄██  ▀ ▀▀▀▀▄ █▀████"
	Line "████ ███▄ ▄▀▀██ ▄█ ▄▄▄█▀ ▄▄ ██▄▀█████"
	Line "████▄█▄███▄▄▀▄▄▄▀ ▄▄ ▄▀▄ ▄▄▄ ▀   ████"
	Line "████ ▄▄▄▄▄ █▄▄▄█▀█▄  ██  █▄█ ▄▄█▀████"
	Line "████ █   █ █ ▀▄█▄ ▄▄  ▀█ ▄▄▄▄▀   ████"
	Line "████ █▄▄▄█ █ ██ ▄█▄  ▄▀▀▀ ▄▄  ▄ █████"
	Line "████▄▄▄▄▄▄▄█▄▄█▄▄████▄▄▄██▄▄▄█▄██████"
	Line "█████████████████████████████████████"
	Line "█████████████████████████████████████"
	""
	Write-Host " 🔷 PowerShell Documentation: " -noNewline
	Write-Host "https://docs.microsoft.com/en-us/powershell" -foregroundColor blue

	Write-Host " 🔷 PowerShell Tutorial: " -noNewline
	Write-Host "https://www.guru99.com/powershell-tutorial.html" -foregroundColor blue

	Write-Host " 🔷 PowerShell FAQ's: " -noNewline
	Write-Host "https://github.com/fleschutz/PowerShell/blob/main/docs/FAQ.md" -foregroundColor blue

	Write-Host " 🔷 PowerShell Cheat Sheet: " -noNewline
	Write-Host "https://github.com/fleschutz/PowerShell/blob/main/docs/cheat-sheet.md" -foregroundColor blue
	""
	"NOTE: Use <Ctrl> + <Click> to open the links in your browser."
        exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
