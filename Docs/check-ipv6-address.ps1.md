# PowerShell Script /home/mf/PowerShell/Scripts/check-ipv6-address.ps1

## Synopsis
check-ipv6-address.ps1 [<address>]

## Description
Checks the given IPv6 address for validity

## Syntax
```powershell
/home/mf/PowerShell/Scripts/check-ipv6-address.ps1 [[-Address] <String>] [<CommonParameters>]
```

## -Address &lt;String&gt; Parameter

```
-Address <String>
    
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
PS>.\check-ipv6-address.ps1 fe80::200:5aee:feaa:20a2
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
