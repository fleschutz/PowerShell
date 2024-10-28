<#
.SYNOPSIS
        Writes a help page
.DESCRIPTION
        This PowerShell script writes a PowerShell help page.
.EXAMPLE
        PS> ./write-help.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function White([string]$line) {
	Write-Host $line -foregroundColor white -backgroundColor black -noNewline
}
function Blue([string]$line) {
	Write-Host $line -foregroundColor blue -backgroundColor black -noNewline
}

try {
	White "█████████████████████████████████████`n"
	White "█████████████████████████████████████ 👋 Welcome to POWERSHELL $($PSVersionTable.PSVersion) $($PSVersionTable.PSEdition) edition`n"
	White "████ ▄▄▄▄▄ █▀ █▀▀█▀▀  ▄▄██ ▄▄▄▄▄ ████`n"
	White "████ █   █ █▀ ▄ █▀ ▀ ▀▄█ █ █   █ ████ Documentation: "; Blue "https://docs.microsoft.com/en-us/powershell`n"
	White "████ █▄▄▄█ █▀█ █▄▀▄▀ ▀ ▄▄█ █▄▄▄█ ████`n"
	White "████▄▄▄▄▄▄▄█▄█▄█ █▄█ █▄▀ █▄▄▄▄▄▄▄████ Tutorial: "; Blue "https://www.guru99.com/powershell-tutorial.html`n"
	White "████▄▄  ▄█▄▄  ▄█▄▄ █▀ ▀▀▀ ▀▄▀▄█▄▀████`n"
	White "████▀▄▄█▀█▄██ ▀ ▄▄▀ █▄█▀ ▀ ▄▀▀█▀█████ Video tutorials: "; Blue "https://www.youtube.com/results?search_query=PowerShell`n"
	White "█████ ▄▄█▄▄▀▄ ▀▄▀ ▄▄  ▀ ▀▀▀ ▀▄▄█▀████`n"
	White "████▄ ▀ ▄ ▄▄█  █▀██▄ ██▀▄█▄▄▀▄▄▀█████ Execute: 'Get-Help <NAME>' to display information about <NAME>`n"
	White "████  ████▄▄  ▄█▄▄▄██  ▀ ▀▀▀▀▄ █▀████`n"
	White "████ ███▄ ▄▀▀██ ▄█ ▄▄▄█▀ ▄▄ ██▄▀█████ FAQ's: "; Blue "https://github.com/fleschutz/PowerShell/blob/main/docs/FAQ.md`n"
	White "████▄█▄███▄▄▀▄▄▄▀ ▄▄ ▄▀▄ ▄▄▄ ▀   ████`n"
	White "████ ▄▄▄▄▄ █▄▄▄█▀█▄  ██  █▄█ ▄▄█▀████ 500+ sample scripts: "; Blue "https://github.com/fleschutz/PowerShell`n"
	White "████ █   █ █ ▀▄█▄ ▄▄  ▀█ ▄▄▄▄▀   ████`n"
	White "████ █▄▄▄█ █ ██ ▄█▄  ▄▀▀▀ ▄▄  ▄ █████ Cheat sheet: "; Blue "https://github.com/fleschutz/PowerShell/blob/main/docs/cheat-sheet.md`n"
	White "████▄▄▄▄▄▄▄█▄▄█▄▄████▄▄▄██▄▄▄█▄██████`n"
	White "█████████████████████████████████████ NOTE: use <Ctrl> + <Click> to open the links in your browser.`n"
	White "█████████████████████████████████████`n"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptWhiteNumber): $($Error[0])"
	exit 1
}
