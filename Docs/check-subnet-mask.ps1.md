# PowerShell Script check-subnet-mask.ps1

## Synopsis & Description
```powershell
check-subnet-mask.ps1 [<address>]
```

Checks the given subnet mask for validity.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/check-subnet-mask.ps1 [[-address] <String>] [<CommonParameters>]
```

```
-address <String>
    
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
PS>.\check-subnet-mask.ps1 255.255.255.0
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of check-subnet-mask.ps1 by convert-ps2md.ps1*
