# Help for check-mac-address.ps1 PowerShell Script

## Synopsis & Description
```powershell
check-mac-address.ps1 [<MAC>]
```

Checks the given MAC address for validity (MAC address like 00:00:00:00:00:00 or 00-00-00-00-00-00 or 000000000000).

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/check-mac-address.ps1 [[-MAC] <String>] [<CommonParameters>]
```

```
-MAC <String>
    
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
PS>.\check-mac-address.ps1 11:22:33:44:55:66
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of check-mac-address.ps1 by convert-ps2md.ps1*
