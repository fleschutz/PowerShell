# My PowerShell Profile
# =====================
# This profile file defines the look & feel of PowerShell.

# Window Title
# ------------
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$host.ui.RawUI.WindowTitle = "$Username @ $(hostname)"


# Command Prompt
# --------------
function prompt { write-host -noNewline -foregroundColor yellow "`n➤"; return " " }


# Alias Names
# -----------
del alias:pwd -force -errorAction SilentlyContinue
set-alias -name pwd -value list-workdir.ps1	# pwd = print working directory
set-alias -name ll -value get-childitem		# ll = list long
del alias:ls -force -errorAction SilentlyContinue
set-alias -name ls -value list-folder.ps1
