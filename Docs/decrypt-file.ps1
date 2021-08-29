# PowerShell Script /home/mf/PowerShell/Scripts/decrypt-file.ps1

## Synopsis
decrypt-file.ps1 [<path>] [<password>]

## Description
Decrypts the given file

## Syntax
```powershell
/home/mf/PowerShell/Scripts/decrypt-file.ps1 [[-Path] <String>] [[-Password] <String>] [<CommonParameters>]
```

## -Path &lt;String&gt; Parameter

```
-Path <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -Password &lt;String&gt; Parameter

```
-Password <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\decrypt-file-rules.ps1 C:\MyFile.txt "123"
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
