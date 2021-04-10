#  My PowerShell Profile
#  =====================
#  Welcome to 'my-profile.ps1' - this file defines the look & feel of PowerShell.
#  Comment, uncomment or adapt the following lines to your needs, please.


#  My Welcome Message
#  ------------------
write-host "+++ Welcome to PowerShell $($PSVersionTable.PSVersion) at $(hostname), it's $(Get-date) +++"
write-host ""


#  My Command Prompt
#  -----------------

# function prompt {$null}	# result is: PS> 

# function prompt { "$ " }	# result is: $

function prompt {
	if ($IsLinux) { $User = $(whoami) } else { $User = $env:USERNAME }
	$host.ui.RawUI.WindowTitle = "$User @ $(hostname)"
	write-host -foregroundColor blue -noNewLine "$(Get-Location)"
	return "> "
} # result is: C:\> 


#  My Alias Names (sorted alphabetically)
#  --------------
set-alias -name ll -value get-childitem		# ll = list long
set-alias -name lsf -value list-formatted.ps1	# lsf = list directory formatted in columns



