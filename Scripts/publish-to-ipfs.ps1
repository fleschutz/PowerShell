<#
.SYNOPSIS
	publish-to-ipfs.ps1 [<file(s)/dir>] [<to-hash-list>]
.DESCRIPTION
	Publishes the given files and folders to IPFS
.EXAMPLE
	PS> .\publish-to-ipfs.ps1 C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$Files = "", [string]$HashList = "IPFS_hashes.txt", [string]$DF_Hashes = "file_checksums.xml")

try {
	& ipfs --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'ipfs' - make sure IPFS is installed and available" }

	if ($Files -eq "") { $Files = read-host "Enter file(s) or directory tree to publish" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if (test-path "$Files" -pathType container) {
		"Adding folder $Files to IPFS..."
		[int]$Count = 1
		& ipfs add -r "$Files" > $HashList

		echo "Calculating digital forensics hashes to $DF_HASHES ..."
		& nice hashdeep -c md5,sha1,sha256 -r -d -l -j 1 "$Files" > $DF_Hashes
	} else {
		$FileList = (get-childItem "$Files")
		[int]$Count = $FileList.Count
		foreach ($File in $FileList) {
			if (test-path "$Files" -pathType container) {
				"Adding folder $File to IPFS..."
				& ipfs add -r "$File" >> $HashList
			} else {
				"Adding file $File to IPFS..."
				& ipfs add "$File" >> $HashList
			}
		}
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ published $Count file(s)/folder(s) to IPFS in $Elapsed sec"
	"  NOTE: to publish it to IPNS execute: ipfs name publish <HASH>"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
