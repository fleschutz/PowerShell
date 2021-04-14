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
	$StartTime = get-date

	# check local file first:
	if (-not(test-path "$File" -pathType leaf)) { throw "Can't access file: $File" }
	$FullPath = Resolve-Path $File
	$Filename = (Get-Item $File).Name
	write-debug "Local file: $FullPath, filename: $Filename"

	$request = [Net.WebRequest]::Create("$URL/$Filename")
	$request.Credentials = New-Object System.Net.NetworkCredential("$Username", "$Password")
	$request.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile 
	$request.EnableSSL = $false
	$request.KeepAlive = $true
	$request.UseBinary = $true
	$request.UsePassive = $false

	$fileStream = [System.IO.File]::OpenRead("$FullPath")
	$ftpStream = $request.GetRequestStream()

	$fileStream.CopyTo($ftpStream)

	# cleanup:
	$ftpStream.Dispose()
	$fileStream.Dispose()

	$StopTime = get-date
	$TimeInterval = New-Timespan -start $StartTime -end $StopTime
	write-host -foregroundColor green "OK - uploaded $File to $URL in $($TimeInterval.seconds) second(s)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
