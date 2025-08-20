# MY POWERSHELL PROFILE 

# WINDOW TITLE
if ($IsLinux) { $username = $(whoami) } else { $username = $env:USERNAME }
$host.ui.RawUI.WindowTitle = "$username @ $(hostname)"

# GREETING
Write-Host "✨ Welcome $username to $(hostname) - type 'FAQ' for help." -foregroundColor green

# PROMPT
function prompt { Write-Host "`n➤ " -noNewline -foregroundColor yellow; return " " }

# ALIASES
Set-Alias -name enter -value enter-host.ps1
Set-Alias -name FAQ -value write-help.ps1
Set-Alias -name ll -value Get-ChildItem		# ll = list folder (long format)
Del alias:ls -force -errorAction SilentlyContinue 
Set-Alias -name ls -value list-folder.ps1	# ls = list folder (short format)
Del alias:pwd -force -errorAction SilentlyContinue
Set-Alias -name pwd -value list-workdir.ps1	# pwd = print working directory
