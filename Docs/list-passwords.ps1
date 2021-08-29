# PowerShell Script /home/mf/PowerShell/Scripts/list-passwords.ps1

## Synopsis
list-passwords.ps1 [<password-length>] [<columns>] [<rows>]

## Description
Prints a list of random passwords

## Syntax
```powershell
/home/mf/PowerShell/Scripts/list-passwords.ps1 [[-PasswordLength] <Int32>] [[-Columns] <Int32>] [[-Rows] <Int32>] [<CommonParameters>]
```

## -PasswordLength &lt;Int32&gt; Parameter

```
-PasswordLength <Int32>
    
    Required?                    false
    Position?                    1
    Default value                15
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -Columns &lt;Int32&gt; Parameter

```
-Columns <Int32>
    
    Required?                    false
    Position?                    2
    Default value                6
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
PS>.\list-passwords.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
