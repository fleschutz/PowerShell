# Help for list-pins.ps1 PowerShell Script

## Synopsis & Description
```powershell
list-pins.ps1 [<pin-length>] [<columns>] [<rows>]
```

Prints a list of random PIN's.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/list-pins.ps1 [[-PinLength] <Int32>] [[-Columns] <Int32>] [[-Rows] <Int32>] [<CommonParameters>]
```

```
-PinLength <Int32>
    
    Required?                    false
    Position?                    1
    Default value                5
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-Columns <Int32>
    
    Required?                    false
    Position?                    2
    Default value                12
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-Rows <Int32>
    
    Required?                    false
    Position?                    3
    Default value                30
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
PS>.\list-pins.ps1
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of list-pins.ps1 by convert-ps2md.ps1*
