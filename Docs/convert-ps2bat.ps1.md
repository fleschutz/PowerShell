# PowerShell Script /home/mf/PowerShell/Scripts/convert-ps2bat.ps1

## Synopsis
convert-ps2bat.ps1 [<pattern>]

## Description
Converts PowerShell script(s) to .bat files

## Syntax
```powershell
/home/mf/PowerShell/Scripts/convert-ps2bat.ps1 [[-Pattern] <String>] [<CommonParameters>]
```

## -Pattern &lt;String&gt; Parameter

```
-Pattern <String>
    
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
PS>.\convert-ps2bat.ps1 *.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
