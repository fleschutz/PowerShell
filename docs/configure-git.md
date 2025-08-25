Script: *configure-git.ps1*
========================

This PowerShell script configures your Git user settings.

Parameters
----------
```powershell
PS> ./configure-git.ps1 [[-fullName] <String>] [[-emailAddress] <String>] [[-favoriteEditor] <String>] [<CommonParameters>]

-fullName <String>
    Specifies the user's full name
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-emailAddress <String>
    Specifies the user's email address
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-favoriteEditor <String>
    Specifies the user's favorite text editor
    
    Required?                    false
    Position?                    3
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./configure-git.ps1 "Joe Doe" joe@doe.com vim
⏳ (1/5) Searching for Git executable...     git version 2.42.0.windows.1
⏳ (2/5) Asking for user details...
⏳ (3/5) Saving basic settings (autocrlf,symlinks,longpaths,etc.)...
⏳ (4/5) Saving user settings (name,email,editor)...
⏳ (5/5) Saving user shortcuts ('git br', 'git ls', 'git st', etc.)...
✅ Saved your Git configuration to ~/.gitconfig in 11s.

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Configures Git 
.DESCRIPTION
	This PowerShell script configures your Git user settings.
.PARAMETER fullName
	Specifies the user's full name
.PARAMETER emailAddress
	Specifies the user's email address
.PARAMETER favoriteEditor
	Specifies the user's favorite text editor
.EXAMPLE
	PS> ./configure-git.ps1 "Joe Doe" joe@doe.com vim
	⏳ (1/5) Searching for Git executable...     git version 2.42.0.windows.1
	⏳ (2/5) Asking for user details...
	⏳ (3/5) Saving basic settings (autocrlf,symlinks,longpaths,etc.)...
	⏳ (4/5) Saving user settings (name,email,editor)...
	⏳ (5/5) Saving user shortcuts ('git br', 'git ls', 'git st', etc.)...
	✅ Saved your Git configuration to ~/.gitconfig in 11s.

.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$fullName = "", [string]$emailAddress = "", [string]$favoriteEditor = "")

try {
	Write-Host "⏳ (1/5) Searching for Git executable...      " -noNewline
	& git --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ (2/5) Asking for user details..."
	if ($fullName -eq "") { $fullName = Read-Host "Enter your full name" }
	if ($emailAddress -eq "") { $emailAddress = Read-Host "Enter your e-mail address"}
	if ($favoriteEditor -eq "") { $favoriteEditor = Read-Host "Enter your favorite text editor, e.g. atom,code,emacs,nano,notepad,subl,vi,vim" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (3/5) Saving basic settings (autocrlf,symlinks,longpaths,etc.)..."
	& git config --global core.autocrlf false          # don't change newlines
	& git config --global core.symlinks true           # enable support for symbolic link files
	& git config --global core.longpaths true          # enable support for long file paths
	& git config --global init.defaultBranch main      # set the default branch name to 'main'
	& git config --global merge.renamelimit 99999      # raise the rename limit
	& git config --global pull.rebase false
	& git config --global fetch.parallel 0             # enable parallel fetching to improve the speed
	if ($lastExitCode -ne 0) { throw "'git config' failed with exit code $lastExitCode" }

	"⏳ (4/5) Saving user settings (name,email,editor)..."
	& git config --global user.name $fullName
	& git config --global user.email $emailAddress
	& git config --global core.editor $favoriteEditor
	if ($lastExitCode -ne 0) { throw "'git config' failed with exit code $lastExitCode" }

	"⏳ (5/5) Saving user shortcuts ('git br', 'git ls', 'git st', etc.)..."
	& git config --global alias.br "branch"
	& git config --global alias.chp "cherry-pick --no-commit"
	& git config --global alias.ci "commit"
	& git config --global alias.co "checkout"
	& git config --global alias.ls "log -n20 --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)by %an%Creset %C(green)%cr%Creset' --abbrev-commit"
	& git config --global alias.mrg "merge --no-commit --no-ff"
	& git config --global alias.pl "pull --recurse-submodules"
	& git config --global alias.ps "push"
	& git config --global alias.smu "submodule update --init"
	& git config --global alias.st "status"
	if ($lastExitCode -ne 0) { throw "'git config' failed" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Saved your Git configuration to ~/.gitconfig in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 08/25/2025 16:51:25)*
