The 'list-error-types.ps1' Script
========================

list-error-types.ps1 


Parameters
----------
```powershell


[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Script Content
--------------
```powershell
[appdomain]::CurrentDomain.GetAssemblies() | ForEach {
    Try {
        $_.GetExportedTypes() | Where {
            $_.Fullname -match 'Exception'
        }
    } Catch {}
} | Select BaseType,Name,FullName
```

*(page generated from script by convert-ps2md.ps1 as of 11/16/2026 17:46:03)*
