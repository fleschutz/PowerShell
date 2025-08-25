<#
.SYNOPSIS
	Publishes files & folders to IPFS
.DESCRIPTION
	This script publishes the given files and folders to IPFS.
.PARAMETER FilePattern
	Specifies the file pattern
.PARAMETER HashList
	Specifies the path to the resulting hash list
.PARAMETER DF_Hashes
	Specifies the path to the resulting digital forensic hashes
.EXAMPLE
	PS> ./publish-to-ipfs C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$FilePattern = "", [string]$HashList = "IPFS_hashes.txt", [string]$DF_Hashes = "file_checksums.xml")

try {
	if ($FilePattern -eq "") { $FilePattern = read-host "Enter file(s)/directories to publish" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/3) Searching for IPFS executable..." -NoNewline
	& ipfs --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'ipfs' - make sure IPFS is installed and available" }

	if (test-path "$FilePattern" -pathType container) {
		"⏳ (2/3) Publishing folder $FilePattern/..."
		& ipfs add -r "$FilePattern" > $HashList
		[int]$Count = 1
		""
		"⏳ (3/3) Calculating digital forensics hashes to $DF_HASHES ..."
		& nice hashdeep -c md5,sha1,sha256 -r -d -l -j 1 "$FilePattern" > $DF_Hashes
	} else {
		$FileList = (get-childItem "$FilePattern")
		foreach ($File in $FileList) {
			if (test-path "$FilePattern" -pathType container) {
				"⏳ (2/3) Publishing folder $File/..."
				& ipfs add -r "$File" >> $HashList
			} else {
				"⏳ (3/3) Publishing file $File..."
				& ipfs add "$File" >> $HashList
			}
		}
		[int]$Count = $FileList.Count
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ published $Count file(s)/folder(s) to IPFS in $Elapsed sec"
	"  NOTE: to publish it to IPNS execute: ipfs name publish <HASH>"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
