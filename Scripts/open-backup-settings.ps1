<#
.SYNOPSIS
	Opens Windows backup settings 
.DESCRIPTION
	This script launches the Windows backup settings.
.EXAMPLE
	PS> ./open-backup-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:backup
exit 0 # success
