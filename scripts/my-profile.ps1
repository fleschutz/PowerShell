# MY POWERSHELL PROFILE - it defines the look & feel of PowerShell.

# WINDOW TITLE
if ($IsLinux) { $username = $(whoami) } else { $username = $env:USERNAME }
$host.ui.RawUI.WindowTitle = "$username @ $(hostname)"

# GREETING
Write-Host "👋 Welcome $username to $(hostname)'s PowerShell - type 'hlp' if you need help." -foregroundColor green

# PROMPT
function prompt { Write-Host "`n➤ " -noNewline -foregroundColor yellow; return " " }

# ALIASES
set-alias -name enter -value enter-host.ps1
set-alias -name hlp -value write-help.ps1
set-alias -name ll -value Get-ChildItem		# ll = list folder (long format)
del alias:ls -force -errorAction SilentlyContinue 
set-alias -name ls -value list-folder.ps1	# ls = list folder (short format)
del alias:pwd -force -errorAction SilentlyContinue
set-alias -name pwd -value list-workdir.ps1	# pwd = print working directory
