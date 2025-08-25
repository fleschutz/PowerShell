<#
.SYNOPSIS
	Sync's two dirs
.DESCRIPTION
	This PowerShell script synchronizes (mirrors) the content of 2 directory trees by using Robocopy.
	Typical use cases are backups: at first everything is copied (full backup), afterward only changes are copied (incremental backup).
	IMPORTANT NOTE: Make sure the target path is correct because the content gets replaced (DATA LOSS)!
.PARAMETER sourcePath
	Specifies the path to the source dir (to be entered by default)
.PARAMETER targetPath
	Specifies the path to the target dir (to be entered by default)
.EXAMPLE
	PS> ./sync-dir.ps1 C:\Photos D:\Backups\Photos
	⏳ Please wait while syncing content from 📂C:\Photos to 📂D:\Backups\Photos ...
	✅ Synced 📂C:\Photos to 📂D:\Backups\Photos in 32s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$sourcePath = "", [string]$targetPath = "")

try {
	if ($sourcePath -eq "") { $sourcePath = Read-Host "Enter the path to the source directory" }
	if ($targetPath -eq "") { $targetPath = Read-Host "Enter the path to the target directory" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Please wait while syncing content from 📂$sourcePath to 📂$targetPath ..."
	& robocopy.exe $sourcePath $targetPath /MIR /SL /FFT /NJH /NDL /NFL /NP /NS
	#
	# /MIR = mirror a directory tree
	# /SL  = copy Symbolic Links as links instead of as the link targets
	# /FFT = assume FAT file times (2-second granularity)
	# /NJH = no job header
	# /NDL = no directory list (don't log directory names)
	# /NFL = no file list (don't log file names)
	# /NP  = no progress (don't display percentage copied)
	# /NS  = no size (don't log file sizes)
	#
	if ($lastExitCode -gt 3) { throw 'Robocopy failed with exit code $lastExitCode.' }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Synced 📂$sourcePath to 📂$targetPath in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
