<#
.SYNOPSIS
	list-cli-tools.ps1
.DESCRIPTION
	Lists command-line tools available
.EXAMPLE
	PS> .\list-cli-tools.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

function CheckTool { param([string]$Name, [string]$Arg)
	$Version = (git $Arg)
	if ($lastExitCode -ne "0") { return }

	$Location = (which $Name)
	if ($lastExitCode -ne "0") { return }

	new-object PSObject -Property @{ Name=$Name; Version=$Version; Location=$Location }
}

function ListTools { 
	"Checking CLI tools ..."
	CheckTool git "--version"
	CheckTool ipfs "--version"
	CheckTool wget "--version"
}
 
try {
	ListTools | format-table 
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
