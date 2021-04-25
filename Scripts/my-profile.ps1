#  My PowerShell Profile
#  =====================
#  Welcome to 'my-profile.ps1' - this file defines the look & feel of PowerShell.
#  Comment, uncomment or adapt the following lines to your needs, please.


#  My Welcome Message
#  ------------------
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$Hostname = $(hostname)
$host.ui.RawUI.WindowTitle = "$Username @ $Hostname"
$Time = (get-date).ToString('t')
"Hi 🧑$Username, welcome to 💻$Hostname at 📂$(Get-Location), it's $Time"


#  My Command Prompt
#  -----------------
# function prompt {$null}	# result is: PS> 

# function prompt { "$ " }	# result is: $

function prompt { "`n💲 " }	# result is: 💲 


#  My Alias Names (sorted alphabetically)
#  --------------
del alias:pwd -force
set-alias -name pwd -value list-workdir.ps1	# pwd = print working directory
set-alias -name ll -value get-childitem		# ll = list long
set-alias -name lsf -value list-dir.ps1		# lsf = list directory formatted
set-alias -name mute -value mute-audio.ps1
set-alias -name unmute -value unmute-audio.ps1
set-alias -name .. -value cd-up.ps1		# 1 dir level up
set-alias -name ... -value cd-up2.ps1		# 2 dir levels up
set-alias -name .... -value cd-up3.ps1		# 3 dir levels up
set-alias -name ..... -value cd-up4.ps1		# 4 dir levels up
