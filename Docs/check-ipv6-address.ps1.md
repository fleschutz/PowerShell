# PowerShell Script check-ipv6-address.ps1

## Synopsis & Description
```powershell
check-ipv6-address.ps1 [<address>]
```

Checks the given IPv6 address for validity.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/check-ipv6-address.ps1 [[-Address] <String>] [<CommonParameters>]
```

```
-Address <String>
    
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
PS>.\check-ipv6-address.ps1 fe80::200:5aee:feaa:20a2
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of check-ipv6-address.ps1 by convert-ps2md.ps1*
