<#
.SYNOPSIS
	Syncronizes two folders
.DESCRIPTION
	This PowerShell script synchronizes (mirrors) the content of 2 directory trees by using Robocopy.
	Typical use cases are backups: at first everything is copied (full backup), afterward only changes are copied (incremental backup).
	IMPORTANT NOTE: Make sure the target path is correct because the content gets replaced (DATA LOSS)!
.PARAMETER sourcePath
	Specifies the path to the source folder
.PARAMETER targetPath
	Specifies the path to the target folder
.EXAMPLE
	PS> ./sync-folder.ps1 C:\MyPhotos D:\Backups\MyPhotos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$sourcePath = "", [string]$targetPath = "")

try {
	if ($sourcePath -eq "") { $sourcePath = Read-Host "Enter the path to the source folder" }
	if ($targetPath -eq "") { $targetPath = Read-Host "Enter the path to the target folder" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$robocopyParameters = $sourcePath, $targetPath, '/MIR', '/FFT', '/NDL', '/NP', '/NS'
	# /MIR = mirror a directory tree
	# /FFT = assume FAT file times (2-second granularity)
	# /NDL = don't log directory names
	# /NP  = don't display percentage copied
	# /NS  = don't log file sizes

	robocopy.exe $robocopyParameters
	if ($lastExitCode -gt 3) { throw 'Robocopy failed.' }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Synced 📂$sourcePath to 📂$targetPath in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}