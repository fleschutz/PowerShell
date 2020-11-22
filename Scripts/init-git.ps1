#!/snap/bin/powershell

# Syntax:	./init-git.ps1
# Description:	initializes the Git configuration
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$UserName   = read-host "Enter your full name"
$UserEmail  = read-host "Enter your email address"
$UserEditor = read-host "Enter your favorite editor (nano, vi, emacs)"

try {
	git config --global user.name $UserName
	git config --global user.email $UserEmail
	git config --global core.editor $UserEditor
	echo "Done."
	exit 0
} catch { Write-Error $Error[0] }
exit 1
