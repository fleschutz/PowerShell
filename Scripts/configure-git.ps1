#!/snap/bin/powershell
<#
.SYNTAX         ./configure-git.ps1
.DESCRIPTION	sets up the Git configuration
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
		requires installation of Git 
#>

$FullName       = read-host "Enter your full name"
$EmailAddress   = read-host "Enter your e-mail address"
$FavoriteEditor = read-host "Enter your favorite text editor (emacs,nano,vi,vim,...)"

try {
	git config --global user.name $FullName
	git config --global user.email $EmailAddress
	git config --global core.editor $FavoriteEditor
	git config --global http.sslVerify false
	git config --global core.autocrlf false
	git config --global core.symlinks true
#	git config --global init.defaultBranch main
	write-output "OK - your Git configuration is now:"
	git config --list
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
