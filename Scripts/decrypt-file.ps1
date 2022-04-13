<#
.SYNOPSIS
	Decrypts the given file
.DESCRIPTION
	This PowerShell script decrypts the given file.
.PARAMETER Path
	Specifies the path to the file to decrypt
.PARAMETER Password
	Specifies the password 
.EXAMPLE
	PS> ./decrypt-file-rules C:\MyFile.txt "123"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$Path = "", [string]$Password = "")


function DecryptFile {
<#
.SYNOPSIS 
Decrypts a file encrypted with Protect-File.

.DESCRIPTION
Decrypts a file using a provided cryptography key.

.PARAMETER FileName
File(s) to be decrypted.

.PARAMETER Key
Cryptography key as a SecureString be used for decryption.

.PARAMETER KeyAsPlainText
Cryptography key as a String to be used for decryption.

.PARAMETER CipherMode
Specifies the block cipher mode that was used for encryption.

.PARAMETER PaddingMode
Specifies the type of padding that was applied when the message data block was shorter than the full number of bytes needed for a cryptographic operation.

.PARAMETER Suffix
Suffix of the encrypted file to be removed.

.PARAMETER RemoveSource
Removes the source (encrypted) file after decrypting.

.OUTPUTS
System.IO.FileInfo. Unprotect-File will return FileInfo with the SourceFile as an added NoteProperty
#>
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

	$PasswordBase64 = [System.Convert]::ToBase64String($Password)
	DecryptFile "$Path" -algorithm AES -keyAsPlainText $PasswordBase64 -removeSource

	"✔️  Done."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
