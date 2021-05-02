<#
.SYNTAX       configure-git.ps1 [<full-name>] [<email-address>] [<favorite-editor>]
.DESCRIPTION  sets up the Git user configuration
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($FullName = "", $EmailAddress = "", $FavoriteEditor = "")
if ($FullName -eq "") { $FullName = read-host "Enter your full name" }
if ($EmailAddress -eq "") { $EmailAddress   = read-host "Enter your e-mail address"}
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
	write-host -foregroundColor green "✔️ your Git configuration has been saved, it's now:"
	& git config --list
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
