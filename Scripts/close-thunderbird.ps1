#!/snap/bin/powershell

# Syntax:       ./close-thunderbird.ps1 
# Description:	closes Mozilla Thunderbird gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$ExitCode = close-program.ps1 "thunderbird" 
exit $ExitCode
