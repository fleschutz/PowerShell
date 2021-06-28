<#
.SYNTAX       configure-git.ps1 [<full-name>] [<email-address>] [<favorite-editor>]
.DESCRIPTION  sets up the Git user configuration
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($FullName = "", $EmailAddress = "", $FavoriteEditor = "")
if ($FullName -eq "") { $FullName = read-host "Enter your full name" }
if ($EmailAddress -eq "") { $EmailAddress = read-host "Enter your e-mail address"}
if ($FavoriteEditor -eq "") { $FavoriteEditor = read-host "Enter your favorite text editor (emacs,nano,vi,vim,...)" }

try {
	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git config --global user.name $FullName
	& git config --global user.email $EmailAddress
	& git config --global core.editor $FavoriteEditor
	& git config --global http.sslVerify false
	& git config --global core.autocrlf false
	& git config --global core.symlinks true
	& git config --global core.longpaths true
	& git config --global init.defaultBranch main
	& git config --global merge.renamelimit 99999
	if ($lastExitCode -ne "0") { throw "'git config' for settings failed" }

	# Basic shortcuts:
	& git config --global alias.co "checkout"
	& git config --global alias.br "branch"
	& git config --global alias.ci "commit"
	& git config --global alias.st "status"
	& git config --global alias.pl "pull --recurse-submodules"
	& git config --global alias.ps "push"
	& git config --global alias.mrg "merge --no-commit --no-ff"
	& git config --global alias.chp "cherry-pick --no-commit"
	& git config --global alias.ls "log -n20 --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)by %an%Creset %C(green)%cr%Creset' --abbrev-commit"
	& git config --global alias.smu "submodule update --init"
	if ($lastExitCode -ne "0") { throw "'git config' for aliases failed" }

	write-host -foregroundColor green "✔️ saved your Git configuration, it's now:"
	& git config --list
	if ($lastExitCode -ne "0") { throw "'git config --list' failed" }
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
