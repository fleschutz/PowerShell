# PowerShell Script /home/mf/PowerShell/Scripts/add-firewall-rules.ps1

## Synopsis
add-firewall-rules.ps1 [<path-to-executables>]

## Description
Adds firewall rules for the given executables (needs administrator rights)

## Syntax
```powershell
/home/mf/PowerShell/Scripts/add-firewall-rules.ps1 [[-PathToExecutables] <String>] [<CommonParameters>]
```

## -PathToExecutables &lt;String&gt; Parameter

```
-PathToExecutables <String>
    
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
PS>.\add-firewall-rules.ps1 C:\MyApp\bin
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
