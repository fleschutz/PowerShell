write-host -foregroundColor green "Welcome to PowerShell $($PSVersionTable.PSVersion)"

#function prompt {$null} # PS> 

#function prompt { "$ " } # $

function prompt { "$(Get-Location)\> " } # C:\
