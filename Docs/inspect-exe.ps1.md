# PowerShell Script /home/mf/PowerShell/Scripts/inspect-exe.ps1

## Synopsis
inspect-exe.ps1 [<path-to-exe-file>]

## Description
Prints basic information of the given executable file

## Syntax
```powershell
/home/mf/PowerShell/Scripts/inspect-exe.ps1 [[-PathToExe] <String>] [<CommonParameters>]
```

## -PathToExe &lt;String&gt; Parameter

```
-PathToExe <String>
    
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
PS>.\inspect-exe.ps1 C:\MyApp.exe
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
