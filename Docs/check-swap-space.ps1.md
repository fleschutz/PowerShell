# PowerShell Script /home/mf/PowerShell/Scripts/check-swap-space.ps1

## Synopsis
check-swap-space.ps1 [<min-level>]

## Description
Checks the free swap space

## Syntax
```powershell
/home/mf/PowerShell/Scripts/check-swap-space.ps1 [[-MinLevel] <Int32>] [<CommonParameters>]
```

## -MinLevel &lt;Int32&gt; Parameter

```
-MinLevel <Int32>
    
    Required?                    false
    Position?                    1
    Default value                50
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\check-swap-space.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
