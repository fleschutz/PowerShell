# PowerShell Script /home/mf/PowerShell/Scripts/edit.ps1

## Synopsis
edit.ps1 <filename>

## Description
Opens the built-in text editor to edit the given file

## Syntax
```powershell
/home/mf/PowerShell/Scripts/edit.ps1 [[-Filename] <String>] [<CommonParameters>]
```

## -Filename &lt;String&gt; Parameter

```
-Filename <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\edit.ps1 C:\MyFile.txt
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
