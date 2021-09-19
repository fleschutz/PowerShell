<#
.SYNOPSIS
	publish-to-ipfs.ps1 [<FilePattern>] [<to-hash-list>]
.DESCRIPTION
	Publishes the given files & folders to IPFS
.EXAMPLE
	PS> .\publish-to-ipfs.ps1 C:\MyFile.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$FilePattern = "", [string]$HashList = "IPFS_hashes.txt", [string]$DF_Hashes = "file_checksums.xml")

try {
	if ($FilePattern -eq "") { $FilePattern = read-host "Enter file(s)/directories to publish" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	""
	"Step 1/3: Searching IPFS executable..."
	& ipfs --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'ipfs' - make sure IPFS is installed and available" }

	if (test-path "$FilePattern" -pathType container) {
		""
		"Step 2/3: Publishing folder $FilePattern/..."
		& ipfs add -r "$FilePattern" > $HashList
		[int]$Count = 1
		""
		echo "Step 3/3: Calculating digital forensics hashes to $DF_HASHES ..."
		& nice hashdeep -c md5,sha1,sha256 -r -d -l -j 1 "$FilePattern" > $DF_Hashes
	} else {
		$FileList = (get-childItem "$FilePattern")
		foreach ($File in $FileList) {
			if (test-path "$FilePattern" -pathType container) {
				"Step 2/3: Publishing folder $File/..."
				& ipfs add -r "$File" >> $HashList
			} else {
				"Step 2/3: Publishing file $File..."
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
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
