# PowerShell Script /home/mf/PowerShell/Scripts/list-pins.ps1

## Synopsis
list-pins.ps1 [<pin-length>] [<columns>] [<rows>]

## Description
Prints a list of random PIN's

## Syntax
```powershell
/home/mf/PowerShell/Scripts/list-pins.ps1 [[-PinLength] <Int32>] [[-Columns] <Int32>] [[-Rows] <Int32>] [<CommonParameters>]
```

## -PinLength &lt;Int32&gt; Parameter

```
-PinLength <Int32>
    
    Required?                    false
    Position?                    1
    Default value                5
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -Columns &lt;Int32&gt; Parameter

```
-Columns <Int32>
    
    Required?                    false
    Position?                    2
    Default value                12
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -Rows &lt;Int32&gt; Parameter

```
-Rows <Int32>
    
    Required?                    false
    Position?                    3
    Default value                30
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\list-pins.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
