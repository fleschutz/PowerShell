# my-profile.ps1 - Your Personal PowerShell Profile
# -------------------------------------------------
# 
# NOTE: simply comment/uncomment/adapt the following lines:

#function prompt {$null} # PS> 

#function prompt { "$ " } # $

function prompt { write-host -foregroundColor blue "$(Get-Location)> " } # C:\> 

set-alias -name lsf -value get-childitem # lsf means list directory formatted
