#!/snap/bin/powershell
<#
.SYNTAX         ./encrypt-file.ps1 [<path>] [<password>]
.DESCRIPTION	encrypts the given file
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Path = "", [string]$Password = "")

Set-StrictMode -Version Latest

Function Protect-File
{
<#
.SYNOPSIS 
Encrypts a file using a symmetrical algorithm.

.DESCRIPTION
Encrypts a file using a symmetrical algorithm.

.PARAMETER FileName
File(s) to be encrypted.

.PARAMETER Key
Cryptography key as a SecureString to be used for encryption.

.PARAMETER KeyAsPlainText
Cryptography key as a String to be used for encryption.

.PARAMETER CipherMode
Specifies the block cipher mode to use for encryption.

.PARAMETER PaddingMode
Specifies the type of padding to apply when the message data block is shorter than the full number of bytes needed for a cryptographic operation.

.PARAMETER Suffix
Suffix of the encrypted file to be removed.

.PARAMETER RemoveSource
Removes the source (decrypted) file after encrypting.

.OUTPUTS
System.IO.FileInfo. Protect-File will return FileInfo with the SourceFile, Algorithm, Key, CipherMode, and PaddingMode as added NoteProperties

.EXAMPLE
Protect-File 'C:\secrets.txt' $key
This example encrypts C:\secrets.txt using the key stored in the variable $key. The encrypted file would have the default extension of '.AES' and the source (decrypted) file would not be removed.

.EXAMPLE
Protect-File 'C:\secrets.txt' -Algorithm DES -Suffix '.Encrypted' -RemoveSource
This example encrypts C:\secrets.txt with a randomly generated DES key. The encrypted file would have an extension of '.Encrypted' and the source (decrypted) file would be removed.

.EXAMPLE
Get-ChildItem 'C:\Files' -Recurse | Protect-File -Algorithm AES -Key $key -RemoveSource
This example encrypts all of the files under the C:\Files directory using the key stored in the variable $key. The encrypted files would have the default extension of '.AES' and the source (decrypted) files would be removed.

.NOTES
Author: Tyler Siegrist
Date: 9/22/2017
#>
[CmdletBinding(DefaultParameterSetName='SecureString')]
[OutputType([System.IO.FileInfo[]])]
Param(
    [Parameter(Mandatory=$true, Position=1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [Alias('PSPath','LiteralPath')]
    [string[]]$FileName,
    [Parameter(Mandatory=$false, Position=2)]
    [ValidateSet('AES','DES','RC2','Rijndael','TripleDES')]
    [String]$Algorithm = 'AES',
    [Parameter(Mandatory=$false, Position=3, ParameterSetName='SecureString')]
    [System.Security.SecureString]$Key = (New-CryptographyKey -Algorithm $Algorithm),
    [Parameter(Mandatory=$true, Position=3, ParameterSetName='PlainText')]
    [String]$KeyAsPlainText,
    [Parameter(Mandatory=$false, Position=4)]
    [System.Security.Cryptography.CipherMode]$CipherMode,
    [Parameter(Mandatory=$false, Position=5)]
    [System.Security.Cryptography.PaddingMode]$PaddingMode,
    [Parameter(Mandatory=$false, Position=6)]
    [String]$Suffix = ".$Algorithm",
    [Parameter()]
    [Switch]$RemoveSource
)
    Begin
    {
        #Configure cryptography
        try
        {
            if($PSCmdlet.ParameterSetName -eq 'PlainText')
            {
                $Key = $KeyAsPlainText | ConvertTo-SecureString -AsPlainText -Force
            }

            #Decrypt cryptography Key from SecureString
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Key)
            $EncryptionKey = [System.Convert]::FromBase64String([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR))

            $Crypto = [System.Security.Cryptography.SymmetricAlgorithm]::Create($Algorithm)
            if($PSBoundParameters.ContainsKey('CipherMode')){
                $Crypto.Mode = $CipherMode
            }
            if($PSBoundParameters.ContainsKey('PaddingMode')){
                $Crypto.Padding = $PaddingMode
            }
            $Crypto.KeySize = $EncryptionKey.Length*8
            $Crypto.Key = $EncryptionKey
        }
        Catch
        {
            Write-Error $_ -ErrorAction Stop
        }
    }
    Process
    {
        $Files = Get-Item -LiteralPath $FileName
    
        ForEach($File in $Files)
        {
            $DestinationFile = $File.FullName + $Suffix

            Try
            {
                $FileStreamReader = New-Object System.IO.FileStream($File.FullName, [System.IO.FileMode]::Open)
                $FileStreamWriter = New-Object System.IO.FileStream($DestinationFile, [System.IO.FileMode]::Create)

                #Write IV (initialization-vector) length & IV to encrypted file
                $Crypto.GenerateIV()
                $FileStreamWriter.Write([System.BitConverter]::GetBytes($Crypto.IV.Length), 0, 4)
                $FileStreamWriter.Write($Crypto.IV, 0, $Crypto.IV.Length)

                #Perform encryption
                $Transform = $Crypto.CreateEncryptor()
                $CryptoStream = New-Object System.Security.Cryptography.CryptoStream($FileStreamWriter, $Transform, [System.Security.Cryptography.CryptoStreamMode]::Write)
                $FileStreamReader.CopyTo($CryptoStream)
    
                #Close open files
                $CryptoStream.FlushFinalBlock()
                $CryptoStream.Close()
                $FileStreamReader.Close()
                $FileStreamWriter.Close()

                #Delete unencrypted file
                if($RemoveSource){Remove-Item -LiteralPath $File.FullName}

                #Output ecrypted file
                $result = Get-Item $DestinationFile
                $result | Add-Member –MemberType NoteProperty –Name SourceFile –Value $File.FullName
                $result | Add-Member –MemberType NoteProperty –Name Algorithm –Value $Algorithm
                $result | Add-Member –MemberType NoteProperty –Name Key –Value $Key
                $result | Add-Member –MemberType NoteProperty –Name CipherMode –Value $Crypto.Mode
                $result | Add-Member –MemberType NoteProperty –Name PaddingMode –Value $Crypto.Padding
                $result
            }
            Catch
            {
                Write-Error $_
                If($FileStreamWriter)
                {
                    #Remove failed file
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
	if ($Path -eq "" ) {
		$Path = read-host "Enter path to file"
	}
	if ($Password -eq "" ) {
		$Password = read-host "Enter password"
	}

	$PasswordBase64 = [System.Convert]::ToBase64String($Password)
	Protect-File "$Path" -Algorithm AES -KeyAsPlainText $PasswordBase64 -RemoveSource
	write-output "OK."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
