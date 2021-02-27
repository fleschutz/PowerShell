# Personal PowerShell Profile
# ---------------------------
# comment/uncomment/adapt as you like

#function prompt {$null} # PS> 

#function prompt { "$ " } # $

function prompt { "$(Get-Location)> " } # C:\> 

set-alias -name lsf -value get-childitem # lsf means list formatted
