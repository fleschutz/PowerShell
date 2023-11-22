<#
.SYNOPSIS
	Sync's two folders
.DESCRIPTION
	This PowerShell script synchronizes two folders via Robocopy (useful for e.g. backups).
	NOTE: Make sure the target folder is correct because the content gets replaced!
.PARAMETER Source
	Path to the source folder
.PARAMETER Destination
	Path to the destination folder
.EXAMPLE
	sync-folder -source C:\Folder01 -destination C:\Folder02
#>

function Sync-Folder
{

	[CmdletBinding()]
	param (
		
		[Parameter(Mandatory)][string]$Source,
		[Parameter(Mandatory)][string]$Destination
	)
	
	$RobocopyParams = $Source, $Destination, '/MIR', '/FFT', '/NDL', '/NP', '/NS'

	robocopy.exe $RobocopyParams

	if ($LastExitCode -gt 3) { throw 'Robocopy failed.' }

}