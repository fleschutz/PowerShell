# PowerShell Script /home/mf/PowerShell/Scripts/add-memo.ps1

## Synopsis
add-memo.ps1 [<text>]

## Description
Adds the given memo text to $HOME/Memos.csv

## Syntax
```powershell
/home/mf/PowerShell/Scripts/add-memo.ps1 [[-text] <String>] [<CommonParameters>]
```

## -text &lt;String&gt; Parameter

```
-text <String>
    
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
PS>.\add-memo.ps1 "Buy apples"
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
