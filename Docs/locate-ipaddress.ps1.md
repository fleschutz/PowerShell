# PowerShell Script /home/mf/PowerShell/Scripts/locate-ipaddress.ps1

## Synopsis
locate-ipaddress.ps1 [<IPaddress>]

## Description
Prints the geographic location of the given IP address

## Syntax
```powershell
/home/mf/PowerShell/Scripts/locate-ipaddress.ps1 [[-IPaddr] <String>] [<CommonParameters>]
```

## -IPaddr &lt;String&gt; Parameter

```
-IPaddr <String>
    
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
PS>.\locate-ipaddress.ps1 177.144.67.98
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
