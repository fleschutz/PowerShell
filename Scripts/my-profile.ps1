#  My PowerShell Profile
#  =====================
#  Welcome to 'my-profile.ps1' - this file defines the look&feel of PowerShell for the user.
#  Simply comment/uncomment/adapt the following lines.
#
#
#  My Command Prompt
#  -----------------

# function prompt {$null}	# result is: PS> 

# function prompt { "$ " }	# result is: $

function prompt {
	if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
	$host.ui.RawUI.WindowTitle = "$Username @ $(hostname)"
	write-host -foregroundColor blue -noNewLine "$(Get-Location)"
	return "> "
} # result is: C:\> 


#  My Alias Names
#  --------------
set-alias -name lsf -value get-childitem # lsf means list directory formatted


#  My Welcome Message
#  ------------------
clear-host
write-host "Welcome to PowerShell $($PSVersionTable.PSVersion) at $(hostname), it's $(Get-date)"
write-host ""