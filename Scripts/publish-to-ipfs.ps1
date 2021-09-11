<#
.SYNOPSIS
	publish-to-ipfs.ps1 [<file(s)/dir>] [<to-hash-list>]
.DESCRIPTION
	Publishes the given files and folders to IPFS.
.EXAMPLE
	PS> .\publish-to-ipfs.ps1 C:\MyFile.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Files = "", [string]$HashList = "IPFS_hashes.txt", [string]$DF_Hashes = "file_checksums.xml")

try {
	if ($Files -eq "") { $Files = read-host "Enter file(s) or directory tree to publish" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	""
	"Step 1/3: Searching for IPFS..."
	& ipfs --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'ipfs' - make sure IPFS is installed and available" }

	if (test-path "$Files" -pathType container) {
		""
		"Step 2/3: Publishing folder $Files/ to IPFS..."
		& ipfs add -r "$Files" > $HashList
		[int]$Count = 1
		""
		echo "Step 3/3: Calculating digital forensics hashes to $DF_HASHES ..."
		& nice hashdeep -c md5,sha1,sha256 -r -d -l -j 1 "$Files" > $DF_Hashes
	} else {
		$FileList = (get-childItem "$Files")
		foreach ($File in $FileList) {
			if (test-path "$Files" -pathType container) {
				"Step 2/3: Publishing folder $File/ to IPFS..."
				& ipfs add -r "$File" >> $HashList
			} else {
				"Step 2/3: Publishing file $File to IPFS..."
				& ipfs add "$File" >> $HashList
			}
		}
		[int]$Count = $FileList.Count
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ published $Count file(s)/folder(s) to IPFS in $Elapsed sec"
	"  NOTE: to publish it to IPNS execute: ipfs name publish <HASH>"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
