# my-profile.ps1 - Your Personal PowerShell Profile
# -------------------------------------------------
# 
# NOTE: simply comment/uncomment/adapt the following lines:

# function prompt {$null}
# resulting prompt is: PS> 

# function prompt { "$ " }
# resultinng prompt is: $

function prompt {
	$host.ui.RawUI.WindowTitle = "$(whoami)@$(hostname)"
	write-host -foregroundColor blue -noNewLine "$(Get-Location)"
	return "> "
}
# resulting prompt is: C:\> 

set-alias -name lsf -value get-childitem # lsf means list directory formatted
