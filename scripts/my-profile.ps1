# MY POWERSHELL PROFILE (this profile file defines the look & feel of PowerShell)

# WINDOW TITLE
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$host.ui.RawUI.WindowTitle = "$Username @ $(hostname)"

# COMMAND PROMPT
function prompt { write-host -noNewline -foregroundColor yellow "`n➤"; return " " }

# ALIAS NAMES
del alias:pwd -force -errorAction SilentlyContinue
set-alias -name pwd -value list-workdir.ps1	# pwd = print working directory
set-alias -name ll -value get-childitem		# ll = list folder (long format)
del alias:ls -force -errorAction SilentlyContinue 
set-alias -name ls -value list-folder.ps1	# ls = list folder (short format)
