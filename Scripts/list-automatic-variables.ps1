#!/snap/bin/powershell
<#
.SYNTAX         ./list-automatic-variables.ps1
.DESCRIPTION	lists PowerShell automatic variables
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	write-output ""
	write-output "PowerShell Automatic Variables"
	write-output "=============================="
	write-output "`$args            = $args"
	write-output "`$ConsoleFileName = $ConsoleFileName"
	write-output "`$Error[0]        = $($Error[0])"
	write-output "`$Event           = $Event"
	write-output "`$EventArgs       = $EventArgs"
	write-output "`$EventSubscriber = $EventSubscriber"
	write-output "`$ExecutionContext= $ExecutionContext"
	write-output "`$false           = $false"
	write-output "`$foreach         = $foreach"
	write-output "`$HOME            = $HOME"
	write-output "`$input           = $input"
	write-output "`$IsCoreCLR       = $IsCoreCLR"
	write-output "`$IsLinux         = $IsLinux"
	write-output "`$IsMacOS         = $IsMacOS"
	write-output "`$IsWindows       = $IsWindows"
	write-output "`$LastExitCode    = $LastExitCode"
	write-output "`$Matches         = $Matches"
	write-output "`$MyInvocation.PSScriptRoot  = $($MyInvocation.PSScriptRoot)"
	write-output "`$MyInvocation.PSCommandPath = $($MyInvocation.PSCommandPath)"
	write-output "`$NestedPromptLevel          = $NestedPromptLevel"
	write-output "`$null            = $null"
	write-output "`$PID             = $PID"
	write-output "`$PROFILE         = $PROFILE"
	write-output "`$PSBoundParameters = $PSBoundParameters"
	write-output "`$PSCmdlet        = $PSCmdlet"
	write-output "`$PSCommandPath   = $PSCommandPath"
	write-output "`$PSCulture       = $PSCulture"
	write-output "`$PSDebugContext  = $PSDebugContext"
	write-output "`$PSHOME          = $PSHOME"
	write-output "`$PSItem          = $PSItem"
	write-output "`$PSScriptRoot    = $PSScriptRoot"
	write-output "`$PSSenderInfo    = $PSSenderInfo"
	write-output "`$PSUICulture     = $PSUICulture"
	write-output "`$PSVersionTable.PSVersion = $($PSVersionTable.PSVersion)"
	write-output "`$PSVersionTable.PSEdition = $($PSVersionTable.PSEdition)"
	write-output "`$PSVersionTable.GitCommitId = $($PSVersionTable.GitCommitId)"
	write-output "`$PSVersionTable.OS = $($PSVersionTable.OS)"
	write-output "`$PSVersionTable.Platform = $($PSVersionTable.Platform)"
	write-output "`$PSVersionTable.PSCompatibleVersions = $($PSVersionTable.PSCompatibleVersions)"
	write-output "`$PSVersionTable.PSRemotingProtocolVersion = $($PSVersionTable.PSRemotingProtocolVersion)"
	write-output "`$PSVersionTable.SerializationVersion = $($PSVersionTable.SerializationVersion)"
	write-output "`$PSVersionTable.WSManStackVersion = $($PSVersionTable.WSManStackVersion)"
	write-output "`$PWD             = $PWD"
	write-output "`$Sender          = $Sender"
	write-output "`$ShellId         = $ShellId"
	write-output "`$StackTrace      = $StackTrace"
	write-output "`$switch          = $switch"
	write-output "`$this            = $this"
	write-output "`$true            = $true"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
