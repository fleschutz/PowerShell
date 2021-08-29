# PowerShell Script /home/mf/PowerShell/Scripts/write-morse-code.ps1

## Synopsis
write-morse-code.ps1 [<text>] [<speed>]

## Description
Writes the given text in Morse code

## Syntax
```powershell
/home/mf/PowerShell/Scripts/write-morse-code.ps1 [[-Text] <String>] [[-OneTimeUnit] <Int32>] [<CommonParameters>]
```

## -Text &lt;String&gt; Parameter

```
-Text <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -OneTimeUnit &lt;Int32&gt; Parameter

```
-OneTimeUnit <Int32>
    
    Required?                    false
    Position?                    2
    Default value                100
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\write-morse-code.ps1 "Hello World"
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
