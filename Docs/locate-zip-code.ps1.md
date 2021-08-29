# PowerShell Script /home/mf/PowerShell/Scripts/locate-zip-code.ps1

## Synopsis
locate-zip-code.ps1 [<country-code>] [<zip-code>]

## Description
Prints the geographic location of the given zip-code

## Syntax
```powershell
/home/mf/PowerShell/Scripts/locate-zip-code.ps1 [[-CountryCode] <String>] [[-ZipCode] <String>] [<CommonParameters>]
```

## -CountryCode &lt;String&gt; Parameter

```
-CountryCode <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -ZipCode &lt;String&gt; Parameter

```
-ZipCode <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\locate-zip-code.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
