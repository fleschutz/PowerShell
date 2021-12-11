# My PowerShell Profile
# =====================
# This file defines the look & feel of PowerShell - adapt the following lines to your needs, please.


# The Welcome Message
# -------------------
"Welcome to PowerShell at $(hostname)'s 📂$(get-location)"


# The Window Title
# ----------------
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$host.ui.RawUI.WindowTitle = "$Username @ $(hostname)"


# The Command Prompt
# ------------------
function prompt { write-host -noNewline -foregroundColor yellow "`n➤"; return " " }


# Supported Alias Names
# ---------------------
del alias:pwd -force -errorAction SilentlyContinue
set-alias -name pwd -value list-workdir.ps1	# pwd = print working directory
set-alias -name ll -value get-childitem		# ll = list long
del alias:ls -force -errorAction SilentlyContinue
set-alias -name ls -value list-folder.ps1
set-alias -name .. -value cd-up.ps1		# 1 dir level up
set-alias -name ... -value cd-up2.ps1		# 2 dir levels up
