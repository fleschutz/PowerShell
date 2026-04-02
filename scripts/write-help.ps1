<#
.SYNOPSIS
        Writes a help page
.DESCRIPTION
        This PowerShell script writes a PowerShell help page to the console.
.EXAMPLE
        PS> ./write-help.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function White($line) {
	Write-Host $line -foregroundColor white -backgroundColor black -noNewline
}

function Blue($line) {
	Write-Host $line -foregroundColor blue -backgroundColor black -noNewline
}

Write-Host ""
Write-Host " _  _   ___   _   _  ____        ____   ___   __    __  ____  ____  ____  _   _  ____  _     _"
Write-Host "( \/ ) / _ \ | | | ||  _ \      |  _ \ / _ \ \  \/\/  /| ___)|  _ \/  __)| |_| || ___)| |   | |"
Write-Host " \  / ( (_) )| |_| ||    /      |  __/( (_) ) \      / | __) |    /\__  \|  _  || __) | |__ | |__"
Write-Host " (__)  \___/ |_____||_|\_)      |_|    \___/   \_/\_/  |____)|_|\_)(____/|_| |_||____)|____)|____)"
Write-Host ""
White "█████████████████████████████████████ Version: $($PSVersionTable.PSVersion) $($PSVersionTable.PSEdition) Edition`n"
White "█████████████████████████████████████`n"
White "█████████████████████████████████████ Modules: $((Get-Module).Count), find more at: "; Blue "https://www.powershellgallery.com`n"
White "█████████████████████████████████████`n"
White "████ ▄▄▄▄▄ █▀ █▀▀█▀▀  ▄▄██ ▄▄▄▄▄ ████ Guide: "; Blue "https://powershellguide.com/PowerShell/Guide`n"
White "████ █   █ █▀ ▄ █▀ ▀ ▀▄█ █ █   █ ████`n"
White "████ █▄▄▄█ █▀█ █▄▀▄▀ ▀ ▄▄█ █▄▄▄█ ████ Documentation: "; Blue "https://docs.microsoft.com/en-us/powershell`n"
White "████▄▄▄▄▄▄▄█▄█▄█ █▄█ █▄▀ █▄▄▄▄▄▄▄████`n" 
White "████▄▄  ▄█▄▄  ▄█▄▄ █▀ ▀▀▀ ▀▄▀▄█▄▀████ Tutorials: "; Blue "https://www.guru99.com/powershell-tutorial.html`n"
White "████▀▄▄█▀█▄██ ▀ ▄▄▀ █▄█▀ ▀ ▄▀▀█▀█████`n" 
White "█████ ▄▄█▄▄▀▄ ▀▄▀ ▄▄  ▀ ▀▀▀ ▀▄▄█▀████ Videos: "; Blue "https://www.youtube.com/results?search_query=PowerShell`n"
White "████▄ ▀ ▄ ▄▄█  █▀██▄ ██▀▄█▄▄▀▄▄▀█████`n"
White "████  ████▄▄  ▄█▄▄▄██  ▀ ▀▀▀▀▄ █▀████ FAQs: "; Blue "https://github.com/fleschutz/PowerShell/blob/main/docs/FAQs.md`n"
White "████ ███▄ ▄▀▀██ ▄█ ▄▄▄█▀ ▄▄ ██▄▀█████`n" 
White "████▄█▄███▄▄▀▄▄▄▀ ▄▄ ▄▀▄ ▄▄▄ ▀   ████ Cheat Sheet: "; Blue "https://github.com/fleschutz/PowerShell/blob/main/docs/cheat-sheet.md`n"
White "████ ▄▄▄▄▄ █▄▄▄█▀█▄  ██  █▄█ ▄▄█▀████`n" 
White "████ █   █ █ ▀▄█▄ ▄▄  ▀█ ▄▄▄▄▀   ████ Sample Scripts: "; Blue "https://github.com/fleschutz/PowerShell`n" 
White "████ █▄▄▄█ █ ██ ▄█▄  ▄▀▀▀ ▄▄  ▄ █████`n"
White "████▄▄▄▄▄▄▄█▄▄█▄▄████▄▄▄██▄▄▄█▄██████ Donation: "; Blue "https://www.paypal.com/paypalme/Fleschutz`n"
White "█████████████████████████████████████           (press <Ctrl> + <Click> to follow the links above)`n"
Write-Host ""
Write-Host "NOTE: Type 'help' for the help system, or 'Get-Help <NAME>' to display information about <NAME>"
exit 0 # success
