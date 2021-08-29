# PowerShell Script /home/mf/PowerShell/Scripts/wakeup.ps1

## Synopsis
wakeup.ps1 [<MAC-address>] [<IP-address>]

## Description
Sends a magic packet to the given computer to wake him up

## Syntax
```powershell
/home/mf/PowerShell/Scripts/wakeup.ps1 [[-MACaddress] <String>] [[-IPaddress] <String>] [[-Port] <Int32>] [<CommonParameters>]
```

## -MACaddress &lt;String&gt; Parameter

```
-MACaddress <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -IPaddress &lt;String&gt; Parameter

```
-IPaddress <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -Port &lt;Int32&gt; Parameter

```
-Port <Int32>
    
    Required?                    false
    Position?                    3
    Default value                9
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\wakeup.ps1 11:22:33:44:55:66 192.168.100.100
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
