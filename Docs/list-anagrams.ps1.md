# Help for list-anagrams.ps1 PowerShell Script

## Synopsis & Description
```powershell
list-anagrams.ps1 [<word>] [<columns>]
```

Lists all anagrams of the given word.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/list-anagrams.ps1 [[-Word] <String>] [[-Columns] <Int32>] [<CommonParameters>]
```

```
-Word <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-Columns <Int32>
    
    Required?                    false
    Position?                    2
    Default value                8
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
PS>.\list-anagrams.ps1 Markus
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of list-anagrams.ps1 by convert-ps2md.ps1*
