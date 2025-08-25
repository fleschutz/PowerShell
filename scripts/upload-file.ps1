<#
.SYNOPSIS
	Uploads a local file to a FTP server
.DESCRIPTION
	This PowerShell script uploads a local file to a FTP server.
.PARAMETER File
	Specifies the path to the local file
.PARAMETER URL
	Specifies the FTP server URL
.PARAMETER Username
	Specifies the user name
.PARAMETER Password
	Specifies the password
.EXAMPLE
	PS> .\upload-file.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$File = "", [string]$URL = "", [string]$Username = "", [string]$Password = "")

try {
	if ($File -eq "") { $File = read-host "Enter local file to upload" }
	if ($URL -eq "") { $URL = read-host "Enter URL of FTP server" }
	if ($Username -eq "") { $Username = read-host "Enter username for login" }
	if ($Password -eq "") { $Password = read-host "Enter password for login" }
	[bool]$EnableSSL = $true
	[bool]$UseBinary = $true
	[bool]$UsePassive = $true
	[bool]$KeepAlive = $true
	[bool]$IgnoreCert = $true

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	# check local file:
	$FullPath = Resolve-Path "$File"
	if (-not(test-path "$FullPath" -pathType leaf)) { throw "Can't access file: $FullPath" }
	$Filename = (Get-Item $FullPath).Name
	$FileSize = (Get-Item $FullPath).Length
	"⏳ Uploading 📄$Filename ($FileSize bytes) to $URL ..."

	# prepare request:
	$Request = [Net.WebRequest]::Create("$URL/$Filename")
	$Request.Credentials = New-Object System.Net.NetworkCredential("$Username", "$Password")
	$Request.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile 
	$Request.EnableSSL = $EnableSSL
	$Request.UseBinary = $UseBinary
	$Request.UsePassive = $UsePassive
	$Request.KeepAlive = $KeepAlive
	[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$IgnoreCert}

	$fileStream = [System.IO.File]::OpenRead("$FullPath")
	$ftpStream = $Request.GetRequestStream()

	$Buf = New-Object Byte[] 32KB
	while (($DataRead = $fileStream.Read($Buf, 0, $Buf.Length)) -gt 0)
	{
	    $ftpStream.Write($Buf, 0, $DataRead)
	    $pct = ($fileStream.Position / $fileStream.Length)
	    Write-Progress -Activity "Uploading" -Status ("{0:P0} complete:" -f $pct) -PercentComplete ($pct * 100)
	}

	# cleanup:
	$ftpStream.Dispose()
	$fileStream.Dispose()

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ uploaded 📄$Filename to $URL in $Elapsed sec"
	exit 0 # success
} catch {
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
