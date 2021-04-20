#  My PowerShell Profile
#  =====================
#  Welcome to 'my-profile.ps1' - this file defines the look & feel of PowerShell.
#  Comment, uncomment or adapt the following lines to your needs, please.


#  My Welcome Message
#  ------------------
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$Hostname = $(hostname)
$host.ui.RawUI.WindowTitle = "$Username @ $Hostname"
"🧑$Username entered 💻$Hostname at 📂$(Get-Location)"


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
del alias:ls -force
set-alias -name ls -value list-dir.ps1		# ls = list directory 
