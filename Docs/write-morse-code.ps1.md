# Help for write-morse-code.ps1 PowerShell Script

## Synopsis & Description
```powershell
write-morse-code.ps1 [<text>] [<speed>]
```

Writes the given text in Morse code.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/write-morse-code.ps1 [[-Text] <String>] [[-OneTimeUnit] <Int32>] [<CommonParameters>]
```

```
-Text <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-OneTimeUnit <Int32>
    
    Required?                    false
    Position?                    2
    Default value                100
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
PS>.\write-morse-code.ps1 "Hello World"
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of write-morse-code.ps1 by convert-ps2md.ps1*
