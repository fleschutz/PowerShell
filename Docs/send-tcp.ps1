# PowerShell Script /home/mf/PowerShell/Scripts/send-tcp.ps1

## Synopsis
send-tcp.ps1 [<target-IP>] [<target-port>] [<message>]

## Description
Sends a TCP message to the given IP address and port

## Syntax
```powershell
/home/mf/PowerShell/Scripts/send-tcp.ps1 [[-TargetIP] <String>] [[-TargetPort] <Int32>] [[-Message] <String>] [<CommonParameters>]
```

## -TargetIP &lt;String&gt; Parameter

```
-TargetIP <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -TargetPort &lt;Int32&gt; Parameter

```
-TargetPort <Int32>
    
    Required?                    false
    Position?                    2
    Default value                0
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -Message &lt;String&gt; Parameter

```
-Message <String>
    
    Required?                    false
    Position?                    3
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\send-tcp.ps1 192.168.100.100 8080 "TEST"
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
