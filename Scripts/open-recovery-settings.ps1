<#
.SYNOPSIS
	Opens Windows recovery settings 
.DESCRIPTION
	This script launches the Windows recovery settings.
.EXAMPLE
	PS> ./open-recovery-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:recovery
exit 0 # success
