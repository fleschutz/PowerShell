#!/usr/bin/pwsh
<#
.SYNTAX       upload-file.ps1 [<file>] [<URL>] [<username>] [<password>]
.DESCRIPTION  uploads the local file to the given FTP server
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($File = "", $URL = "", $Username = "", $Password = "")
if ($File -eq "") { $File = read-host "Enter local file to upload" }
if ($URL -eq "") { $URL = read-host "Enter URL of FTP server" }
if ($Username -eq "") { $Username = read-host "Enter login username" }
if ($Password -eq "") { $Password = read-host "Enter login password" }

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	# check local file first:
	if (-not(test-path "$File" -pathType leaf)) { throw "Can't access file: $File" }
	$FullPath = Resolve-Path $File
	$Filename = (Get-Item $File).Name
	$FileSize = (Get-Item $File).Length
	"Local file: $FullPath ($FileSize bytes)"

	$request = [Net.WebRequest]::Create("$URL/$Filename")
	$request.Credentials = New-Object System.Net.NetworkCredential("$Username", "$Password")
	$request.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile 
	$request.EnableSSL = $false
	$request.KeepAlive = $true
	$request.UseBinary = $true
	$request.UsePassive = $false

	$fileStream = [System.IO.File]::OpenRead("$FullPath")
	$ftpStream = $request.GetRequestStream()

	"Uploading ..."
	$buffer = New-Object Byte[] 64KB
	while (($read = $fileStream.Read($buffer, 0, $buffer.Length)) -gt 0)
	{
	    $ftpStream.Write($buffer, 0, $read)
	    $pct = ($fileStream.Position / $fileStream.Length)
	    Write-Progress -Activity "Uploading" -Status ("{0:P0} complete:" -f $pct) -PercentComplete ($pct * 100)
	}

	# cleanup:
	$ftpStream.Dispose()
	$fileStream.Dispose()

	write-host -foregroundColor green "✔️ uploaded $File to $URL in $($StopWatch.Elapsed.Seconds) second(s)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
