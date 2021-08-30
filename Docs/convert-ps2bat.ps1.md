# Help for convert-ps2bat.ps1 PowerShell Script

## Synopsis & Description
```powershell
convert-ps2bat.ps1 [<pattern>]
```

Converts a PowerShell script to .bat files.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/convert-ps2bat.ps1 [[-Pattern] <String>] [<CommonParameters>]
```

```
-Pattern <String>
    
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
PS>.\convert-ps2bat.ps1 *.ps1
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of convert-ps2bat.ps1 by convert-ps2md.ps1*
