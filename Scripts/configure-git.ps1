#!/snap/bin/powershell
<#
.SYNTAX         ./configure-git.ps1 [<full-name>] [<email-address>] [<favorite-editor>]
.DESCRIPTION	sets up the Git user configuration
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($FullName = "", $EmailAddress = "", $FavoriteEditor = "")

try {
	git --version
} catch {
	write-error "No Git installation found - make sure Git is installed"
	exit 1
}

if ($FullName -eq "") {
	$FullName       = read-host "Enter your full name"
}
if ($EmailAddress -eq "") {
	$EmailAddress   = read-host "Enter your e-mail address"
}
if ($FavoriteEditor -eq "") {
	$FavoriteEditor = read-host "Enter your favorite text editor (emacs,nano,vi,vim,...)"
}

try {
	git config --global user.name $FullName
	git config --global user.email $EmailAddress
	git config --global core.editor $FavoriteEditor
	git config --global http.sslVerify false
	git config --global core.autocrlf false
	git config --global core.symlinks true
	git config --global init.defaultBranch main
	write-output "OK - your Git user configuration is now:"
	git config --list
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
