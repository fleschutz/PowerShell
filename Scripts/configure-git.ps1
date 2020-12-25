#!/snap/bin/powershell

# Syntax:	./configure-git.ps1
# Description:	sets up the Git configuration
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# NOTE:		requires installation of Git 

$UserName   = read-host "Enter your full name"
$UserEmail  = read-host "Enter your email address"
$UserEditor = read-host "Enter your favorite editor (nano, vi, emacs, ...)"

try {
	git config --global user.name $UserName
	git config --global user.email $UserEmail
	git config --global core.editor $UserEditor
	git config --global init.defaultBranch main
	write-output "Done."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
