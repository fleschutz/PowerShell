# PowerShell Script /home/mf/PowerShell/Scripts/check-file-system.ps1

## Synopsis
check-file-system.ps1 [<drive>]

## Description
Checks the validity of the file system (needs admin rights)

## Syntax
```powershell
/home/mf/PowerShell/Scripts/check-file-system.ps1 [[-Drive] <String>] [<CommonParameters>]
```

## -Drive &lt;String&gt; Parameter

```
-Drive <String>
    
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
PS>.\check-file-system.ps1 C
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
