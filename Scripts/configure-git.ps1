#!/snap/bin/powershell
<#
.SYNTAX         ./configure-git.ps1
.DESCRIPTION	sets up the Git configuration
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
		requires installation of Git 
#>

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
