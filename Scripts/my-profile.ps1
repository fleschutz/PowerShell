# My PowerShell Profile
# =====================
# Welcome to 'my-profile.ps1' - this file defines the look & feel of PowerShell.
# Adapt the following lines to your needs, please.


# My Welcome Message
# ------------------
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$Time = (get-date).ToString('t')
$host.ui.RawUI.WindowTitle = "$Username @ $(hostname)"
"🧑$Username entered 📂$(get-location) at 💻$(hostname), it's $Time"


#  My Command Prompt
#  -----------------
function prompt { write-host -noNewline -foregroundColor yellow "`n➤"; return " " }


#  My Alias Names (sorted alphabetically)
#  --------------
del alias:pwd -force -errorAction SilentlyContinue
set-alias -name pwd -value list-workdir.ps1	# pwd = print working directory
set-alias -name ll -value get-childitem		# ll = list long
del alias:ls -force -errorAction SilentlyContinue
set-alias -name ls -value list-dir.ps1
set-alias -name .. -value cd-up.ps1		# 1 dir level up
set-alias -name ... -value cd-up2.ps1		# 2 dir levels up
set-alias -name .... -value cd-up3.ps1		# 3 dir levels up
