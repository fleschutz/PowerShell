# Help for locate-zip-code.ps1 PowerShell Script

## Synopsis & Description
```powershell
locate-zip-code.ps1 [<country-code>] [<zip-code>]
```

Prints the geographic location of the given zip-code.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/locate-zip-code.ps1 [[-CountryCode] <String>] [[-ZipCode] <String>] [<CommonParameters>]
```

```
-CountryCode <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-ZipCode <String>
    
    Required?                    false
    Position?                    2
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
PS>.\locate-zip-code.ps1
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of locate-zip-code.ps1 by convert-ps2md.ps1*
