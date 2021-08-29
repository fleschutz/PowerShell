# PowerShell Script /home/mf/PowerShell/Scripts/translate-text.ps1

## Synopsis
translate-text.ps1 [<text>] [<source-lang>] [<target-lang>]

## Description
Translates the given text into other languages

## Syntax
```powershell
/home/mf/PowerShell/Scripts/translate-text.ps1 [[-Text] <String>] [[-SourceLang] <String>] [[-TargetLang] <String>] [<CommonParameters>]
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

## -SourceLang &lt;String&gt; Parameter

```
-SourceLang <String>
    
    Required?                    false
    Position?                    2
    Default value                en
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -TargetLang &lt;String&gt; Parameter

```
-TargetLang <String>
    
    Required?                    false
    Position?                    3
    Default value                any
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\translate-text.ps1 "Hello World" de en
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
