Script: *decrypt-file.ps1*
========================

This PowerShell script decrypts a file using the given password and AES encryption.

Parameters
----------
```powershell
PS> ./decrypt-file.ps1 [[-Path] <String>] [[-Password] <String>] [<CommonParameters>]

-Path <String>
    Specifies the path to the file to decrypt
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-Password <String>
    Specifies the password
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./decrypt-file.ps1 C:\MyFile.txt "123"

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Decrypts a file
.DESCRIPTION
	This PowerShell script decrypts a file using the given password and AES encryption.
.PARAMETER Path
	Specifies the path to the file to decrypt
.PARAMETER Password
	Specifies the password 
.EXAMPLE
	PS> ./decrypt-file.ps1 C:\MyFile.txt "123"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Path = "", [string]$Password = "")


function DecryptFile {
[CmdletBinding(DefaultParameterSetName='SecureString')]
[OutputType([System.IO.FileInfo[]])]
Param(
    [Parameter(Mandatory=$true, Position=1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath','LiteralPath')]
    [string[]]$FileName,
    [Parameter(Mandatory=$false, Position=2, ValueFromPipelineByPropertyName=$true)]
    [ValidateSet('AES','DES','RC2','Rijndael','TripleDES')]
    [String]$Algorithm = 'AES',
    [Parameter(Mandatory=$true, Position=3, ValueFromPipelineByPropertyName=$true, ParameterSetName='SecureString')]
    [System.Security.SecureString]$Key,
    [Parameter(Mandatory=$true, Position=3, ParameterSetName='PlainText')]
    [String]$KeyAsPlainText,
    [Parameter(Mandatory=$false, Position=4, ValueFromPipelineByPropertyName=$true)]
    [System.Security.Cryptography.CipherMode]$CipherMode = 'CBC',
    [Parameter(Mandatory=$false, Position=5, ValueFromPipelineByPropertyName=$true)]
    [System.Security.Cryptography.PaddingMode]$PaddingMode = 'PKCS7',
    [Parameter(Mandatory=$false, Position=6)]
    [String]$Suffix,
    [Parameter()]
    [Switch]$RemoveSource
)
    Process
    {
        try
        {
            if($PSCmdlet.ParameterSetName -eq 'PlainText')
            {
                $Key = $KeyAsPlainText | ConvertTo-SecureString -AsPlainText -Force
            }

            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Key)
            $EncryptionKey = [System.Convert]::FromBase64String([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR))

            $Crypto = [System.Security.Cryptography.SymmetricAlgorithm]::Create($Algorithm)
            $Crypto.Mode = $CipherMode
            $Crypto.Padding = $PaddingMode
            $Crypto.KeySize = $EncryptionKey.Length*8
            $Crypto.Key = $EncryptionKey
        }
        Catch
        {
            Write-Error $_ -ErrorAction Stop
        }

        if(-not $PSBoundParameters.ContainsKey('Suffix'))
        {
            $Suffix = ".$Algorithm"
        }

        $Files = Get-Item -LiteralPath $FileName

        ForEach($File in $Files)
        {
            If(-not $File.Name.EndsWith($Suffix))
            {
                Write-Error "$($File.FullName) does not have an extension of '$Suffix'."
                Continue
            }

            $DestinationFile = $File.FullName -replace "$Suffix$"

            Try
            {
                $FileStreamReader = New-Object System.IO.FileStream($File.FullName, [System.IO.FileMode]::Open)
                $FileStreamWriter = New-Object System.IO.FileStream($DestinationFile, [System.IO.FileMode]::Create)

                [Byte[]]$LenIV = New-Object Byte[] 4
                $FileStreamReader.Seek(0, [System.IO.SeekOrigin]::Begin) | Out-Null
                $FileStreamReader.Read($LenIV,  0, 3) | Out-Null
                [Int]$LIV = [System.BitConverter]::ToInt32($LenIV,  0)
                [Byte[]]$IV = New-Object Byte[] $LIV
                $FileStreamReader.Seek(4, [System.IO.SeekOrigin]::Begin) | Out-Null
                $FileStreamReader.Read($IV, 0, $LIV) | Out-Null
                $Crypto.IV = $IV

                $Transform = $Crypto.CreateDecryptor()
                $CryptoStream = New-Object System.Security.Cryptography.CryptoStream($FileStreamWriter, $Transform, [System.Security.Cryptography.CryptoStreamMode]::Write)
                $FileStreamReader.CopyTo($CryptoStream)

                $CryptoStream.FlushFinalBlock()
                $CryptoStream.Close()
                $FileStreamReader.Close()
                $FileStreamWriter.Close()

                if($RemoveSource){Remove-Item $File.FullName}

                Get-Item $DestinationFile | Add-Member –MemberType NoteProperty –Name SourceFile –Value $File.FullName -PassThru
            }
            Catch
            {
                Write-Error $_
                If($FileStreamWriter)
                {
                    $FileStreamWriter.Close()
                    Remove-Item -LiteralPath $DestinationFile -Force
                }
                Continue
            }
            Finally
            {
                if($CryptoStream){$CryptoStream.Close()}
                if($FileStreamReader){$FileStreamReader.Close()}
                if($FileStreamWriter){$FileStreamWriter.Close()}
            }
        }
    }
}


try {
	if ($Path -eq "" ) { $Path = read-host "Enter path to file" }
	if ($Password -eq "" ) { $Password = read-host "Enter password" }
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$PasswordBase64 = [System.Convert]::ToBase64String($Password)
	DecryptFile "$Path" -Algorithm AES -KeyAsPlainText $PasswordBase64 -RemoveSource

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅  file decrypted in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 08/25/2025 16:51:25)*
