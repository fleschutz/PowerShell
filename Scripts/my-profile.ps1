#  My PowerShell Profile
#  =====================
#  Welcome to 'my-profile.ps1' - this file defines the look & feel of PowerShell.
#  Comment, uncomment or adapt the following lines to your needs, please.


#  My Welcome Message
#  ------------------
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$Hostname = $(hostname)
$host.ui.RawUI.WindowTitle = "$Username @ $Hostname"
write-host "🧑 $Username enters PowerShell $($PSVersionTable.PSVersion) at $Hostname in $(Get-Location)"
write-host ""


#  My Command Prompt
#  -----------------
# function prompt {$null}	# result is: PS> 

# function prompt { "$ " }	# result is: $

function prompt { "`n💲 " }	# result is: 💲 


#  My Alias Names (sorted alphabetically)
#  --------------
set-alias -name cwd -value list-workdir.ps1	# cwd = current working directory
set-alias -name ll -value get-childitem		# ll = list long
set-alias -name lsf -value list-formatted.ps1	# lsf = list directory formatted




