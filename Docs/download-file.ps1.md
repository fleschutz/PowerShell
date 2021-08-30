# PowerShell Script download-file.ps1

## Synopsis & Description
```powershell
download-file.ps1 [<URL>]
```

Downloads a file from the given URL.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/download-file.ps1 [[-URL] <String>] [<CommonParameters>]
```

```
-URL <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
[<CommonParameters>]
    This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

## Example
```powershell
PS>.\download-file.ps1 "https://www.cnn.com/index.html"
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of download-file.ps1 by convert-ps2md.ps1*
