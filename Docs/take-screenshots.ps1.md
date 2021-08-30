# PowerShell Script take-screenshots.ps1

## Synopsis & Description
```powershell
take-screenshots.ps1 [<directory>] [<interval>]
```

Takes screenshots every 60 seconds and saves them into the current/given directory.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/take-screenshots.ps1 [[-Directory] <String>] [[-Interval] <Int32>] [<CommonParameters>]
```

```
-Directory <String>
    
    Required?                    false
    Position?                    1
    Default value                "$PWD"
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-Interval <Int32>
    
    Required?                    false
    Position?                    2
    Default value                60
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
PS>.\take-screenshots.ps1 C:\Temp 60
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of take-screenshots.ps1 by convert-ps2md.ps1*
