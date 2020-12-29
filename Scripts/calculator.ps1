#!/snap/bin/powershell
<#
.SYNTAX         ./calculator.ps1 
.DESCRIPTION	starts a calculator (GUI)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

clear-host  
write-host "      PowerShell Calculator      " -for green 
write-host "" 
 
 
Function MiniReg 
{ 
    #registry keys used as memory in this program 
     
    # Mem (number in memory) 
    # OpP "1" (operator last key pressed, set to "1" to detect if operator pressed again or different operator selected) 
    # Fin "1" (operator last key pressed, set to "1" to clear screen when next number entered) 
    # Fin "2" (set to "2" when equals(=) key last pressed, if number now entered screen cleared or (=) pressed again total is cumulated) 
    # Val (first part of equation + operator) 
    # Val2 (second part of equation) 
 
   param 
   ( 
      [string]$key,  
      [string]$value,  
      [switch]$set, 
      [string]$reg="HKCU:\Software\PowerShell\Calculator" 
   )  
    
   if (! (test-path $Reg)) 
   { 
      New-Item -path $Reg -force 
      MiniReg Mem "0" -s 
   } 
 
   if ($set) 
   { 
      Set-ItemProperty -path $Reg -name $key -value $value 
   } 
   else 
   { 
      return (Get-ItemProperty -path $Reg -name $Key).$key 
   } 
} 
 
 
 
Function EnterNumber 
{   
   Param([int]$n) 
    
   MiniReg OpP "0" -s 
   if ((MiniReg Fin) -eq "1") 
   { 
      MiniReg Fin "0" -s 
      $textBoxDisplay.Text ="" 
   } 
    
   if ((MiniReg Fin) -eq "2") 
   { 
      MiniReg Fin "0" -s 
      MiniReg Val "" -s 
      $textBoxDisplay.Text ="" 
   } 
    
   $Display = $textBoxDisplay.Text + $n 
   if ($textBoxDisplay.Text.contains(".")) 
   { 
      $textBoxDisplay.Text = $Display 
   } 
   else 
   { 
      $textBoxDisplay.Text = $Display -replace "^0*"     
   } 
} 
 
Function operators 
{ 
   Param([string]$a) 
    
   if ((MiniReg OpP) -eq "0") 
   {   
      MiniReg OpP "1" -s  
      if ((MiniReg Fin) -eq "2") 
      { 
         MiniReg Fin "0" -s 
         MiniReg Val "" -s 
      }    
       
      $Display=$textBoxDisplay.Text 
      $y=MiniReg Val 
      if (!($Display -eq "")) 
      { 
         if ($y -eq "") 
         { 
            MiniReg Val "$Display$a" -s  
         } 
         else 
         { 
            [double]$w0=$y.substring(0,$y.length-1) 
            [double]$w1=$Display 
            [string]$op=$y.substring($y.length-1, 1) 
          
            if ($op -eq "+"){$subT=($w0+$w1)} 
            if ($op -eq "-"){$subT=($w0-$w1)} 
            if ($op -eq "x"){$subT=($w0*$w1)} 
            if ($op -eq "/"){$subT=($w0/$w1)} 
          
            write-host "$w0 $op $w1 = $subT"          
            MiniReg Val "$subT$a" -s  
            $textBoxDisplay.Text = $subT        
         } 
      } 
      MiniReg Fin "1" -s 
   } 
   else 
   { 
      #operator button pressed more than once in a row. (just use new operator) 
       
      $y=MiniReg Val 
      [double]$w0=$y.substring(0,$y.length-1) 
      MiniReg Val "$w0$a" -s 
   } 
} 
 
 
 
function GenerateForm { 
 
#region Import the Assemblies 
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null 
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null 
[System.Windows.Forms.Application]::EnableVisualStyles() 
 
#region Generated Form Objects 
$form1 = New-Object System.Windows.Forms.Form 
$buttonMemClear = New-Object System.Windows.Forms.Button 
$buttonback = New-Object System.Windows.Forms.Button 
$textBoxMem = New-Object System.Windows.Forms.TextBox 
$buttonMemSave = New-Object System.Windows.Forms.Button 
$buttonMemRecal = New-Object System.Windows.Forms.Button 
$buttonMemPlus = New-Object System.Windows.Forms.Button 
$buttonCE = New-Object System.Windows.Forms.Button 
$buttonC = New-Object System.Windows.Forms.Button 
$buttonF4 = New-Object System.Windows.Forms.Button 
$buttonEquals = New-Object System.Windows.Forms.Button 
$buttonF3 = New-Object System.Windows.Forms.Button 
$buttonF2 = New-Object System.Windows.Forms.Button 
$buttonF1 = New-Object System.Windows.Forms.Button 
$buttonplus = New-Object System.Windows.Forms.Button 
$buttonMinus = New-Object System.Windows.Forms.Button 
$buttonMultip = New-Object System.Windows.Forms.Button 
$buttonDiv = New-Object System.Windows.Forms.Button 
$buttonDot = New-Object System.Windows.Forms.Button 
$buttonSign = New-Object System.Windows.Forms.Button 
$button0 = New-Object System.Windows.Forms.Button 
$button9 = New-Object System.Windows.Forms.Button 
$button8 = New-Object System.Windows.Forms.Button 
$button7 = New-Object System.Windows.Forms.Button 
$button6 = New-Object System.Windows.Forms.Button 
$button5 = New-Object System.Windows.Forms.Button 
$button4 = New-Object System.Windows.Forms.Button 
$button3 = New-Object System.Windows.Forms.Button 
$button2 = New-Object System.Windows.Forms.Button 
$button1 = New-Object System.Windows.Forms.Button 
$textBoxDisplay = New-Object System.Windows.Forms.TextBox 
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState 
 
 
#---------------------------------------------- 
#Generated Event Script Blocks 
#---------------------------------------------- 
#Provide Custom Code for events specified in PrimalForms. 
$handler_button0_Click=  
{ 
   MiniReg OpP "0" -s    
   if ((MiniReg Fin) -eq "1") 
   { 
      MiniReg Fin "0" -s 
      $textBoxDisplay.Text ="" 
   } 
    
   if ((MiniReg Fin) -eq "2") 
   { 
      MiniReg Fin "0" -s 
      MiniReg Val "" -s 
      $textBoxDisplay.Text ="" 
   } 
    
   if ($textBoxDisplay.Text -ne "0") 
   { 
      $textBoxDisplay.Text = $textBoxDisplay.Text + "0" 
   } 
} 
 
$button1_OnClick=  
{ 
   EnterNumber 1 
} 
 
$button2_OnClick=  
{ 
   EnterNumber 2 
} 
 
$button3_OnClick=  
{ 
   EnterNumber 3 
} 
 
$button4_OnClick=  
{ 
   EnterNumber 4 
} 
 
$button5_Click=  
{ 
   EnterNumber 5 
} 
 
$button6_OnClick=  
{ 
   EnterNumber 6 
} 
 
$button7_OnClick=  
{ 
   EnterNumber 7 
} 
 
$button8_OnClick=  
{ 
   EnterNumber 8 
} 
 
$button9_OnClick=  
{ 
   EnterNumber 9 
} 
 
$buttonDot_OnClick=  
{ 
   MiniReg OpP "0" -s 
   if ((MiniReg Fin) -eq "1") 
   { 
      MiniReg Fin "0" -s 
      $textBoxDisplay.Text ="0" 
   } 
    
   if ((MiniReg Fin) -eq "2") 
   { 
      MiniReg Fin "0" -s 
      MiniReg Val "" -s 
      MiniReg Val2 "" -s 
      $textBoxDisplay.Text ="0" 
   } 
       
   if (!($textBoxDisplay.Text.contains("."))) 
   { 
      $textBoxDisplay.Text = $textBoxDisplay.Text + "." 
   } 
} 
 
 
 
 
 
 
$buttonMemClear_OnClick=  
{ 
   if ((MiniReg Fin) -eq "0") 
   { 
      MiniReg Fin "1" -s 
   } 
 
   MiniReg Mem "0" -s  
 
   Write-host "Memory = 0" 
   $textBoxMem.Text = "" 
} 
 
$buttonMemRecal_OnClick=  
{    
   if ((MiniReg Fin) -eq "0") 
   { 
      MiniReg Fin "1" -s 
   } 
    
   $memR = MiniReg Mem 
 
   $textBoxDisplay.Text = $memR 
    
   Write-host "Memory = $MemR" 
} 
 
$buttonMemSave_OnClick=  
{ 
   if ((MiniReg Fin) -eq "0") 
   { 
      MiniReg Fin "1" -s 
   } 
    
   [string]$Display = $textBoxDisplay.Text 
   MiniReg Mem $Display -s 
 
   Write-host "Memory = $Display" 
   $textBoxMem.Text = "M" 
} 
 
$buttonMemPlus_OnClick=  
{ 
   if ((MiniReg Fin) -eq "0") 
   { 
      MiniReg Fin "1" -s 
   } 
    
   [double]$w0 = MiniReg Mem 
   [double]$w1=$textBoxDisplay.Text 
   [string]$MemPlus = ($w0+$w1) 
   MiniReg Mem $MemPlus -s 
    
   Write-host "Memory + $w1 = $MemPlus" 
   $textBoxMem.Text = "M" 
} 
 
#Clear/initialise memory 
MiniReg Fin "0" -s 
MiniReg Val "" -s 
MiniReg Val2 "" -s 
MiniReg OpP "0" -s  
 
$memR = MiniReg Mem  
if ($memR -ne "0") 
{ 
   Write-host "Last Session Memory Retained = $memR`a" -for red 
   $textBoxMem.Text = "M" 
} 
 
 
 
 
 
#Custom Function1 'Square Root value in display' 
$buttonF1.Text = "sqrt" 
$buttonF1_OnClick=  
{ 
   [double]$Display = $textBoxDisplay.Text 
   $SQRoot = [math]::sqrt($Display)    
   $textBoxDisplay.Text = $SQRoot 
   Write-Host "Square Root $Display = $SQRoot"  
    
   MiniReg OpP "0" -s 
   MiniReg Fin "1" -s     
} 
 
 
#Custom Function2 'emulates windows calc.exe % key functionality' 
$buttonF2.Text = "%" 
$buttonF2_OnClick=  
{ 
   [double]$Display = $textBoxDisplay.Text 
   $y=MiniReg Val 
 
   if ((MiniReg Fin) -eq "2") 
   { 
      MiniReg Fin "0" -s 
      MiniReg Val "" -s 
   } 
 
   if (!($Display -eq "") -and !($y -eq "")) 
   { 
      [double]$w0=$y.substring(0,$y.length-1) 
      [double]$w1=$Display 
      [string]$op=$y.substring($y.length-1, 1) 
      $per=$w0*$w1/100 
      $textBoxDisplay.Text=$per 
      Write-Host "$w1% of $w0 = $per"     
   } 
   MiniReg OpP "0" -s 
   MiniReg Fin "1" -s 
}  
 
 
#Custom Function3 '1/x' 
$buttonF3.Text = "1/x" 
$buttonF3_OnClick=  
{    
   if ((MiniReg Fin) -eq "2") 
   { 
      MiniReg Fin "0" -s 
      MiniReg Val "" -s 
   } 
    
   [double]$Display = $textBoxDisplay.Text 
   $x1 = 1/$Display   
   $textBoxDisplay.Text = $x1  
   Write-Host "1 / $Display = $x1" 
          
   MiniReg Fin "1" -s    
   MiniReg OpP "0" -s 
} 
 
 
#Custom Function4 'Pi' 
$buttonF4.Text = "Pi" 
$buttonF4_OnClick=  
{ 
   if ((MiniReg Fin) -eq "2") 
   { 
      MiniReg Fin "0" -s 
      MiniReg Val "" -s 
   } 
    
   [double]$Display = $textBoxDisplay.Text 
   $Pi = [math]::PI  
   $textBoxDisplay.Text = $Pi  
   Write-Host "Pi = $Pi"  
    
   MiniReg Fin "1" -s    
   MiniReg OpP "0" -s 
} 
 
 
 
 
 
 
$buttonplus_OnClick=  
{ 
   operators "+" 
} 
 
$buttonMinus_OnClick=  
{ 
   operators "-" 
} 
 
$buttonMultip_OnClick=  
{ 
   operators "x" 
} 
 
$buttonDiv_OnClick=  
{ 
   operators "/" 
} 
 
$buttonEquals_OnClick=  
{    
   MiniReg OpP "0" -s 
   if ((MiniReg Fin) -eq "2") 
   { 
      $y=MiniReg Val 
      [double]$w0=$y.substring(0,$y.length-1) 
      [double]$w1=MiniReg Val2 
      [string]$op=$y.substring($y.length-1, 1) 
      if ($op -eq "+"){$subT=($w0+$w1)} 
      if ($op -eq "-"){$subT=($w0-$w1)} 
      if ($op -eq "x"){$subT=($w0*$w1)} 
      if ($op -eq "/"){$subT=($w0/$w1)} 
          
      write-host "$w0 $op $w1 = $subT" 
          
      MiniReg Fin "2" -s  
      MiniReg Val "$subT$op" -s 
      MiniReg Val2 $W1 -s       
          
      $textBoxDisplay.Text = $subT            
   } 
   else 
   { 
      $x=$textBoxDisplay.Text 
      $y=MiniReg Val 
      if (!($x -eq "") -and !($y -eq "")) 
      { 
         [double]$w0=$y.substring(0,$y.length-1) 
         [double]$w1=$x 
         [string]$op=$y.substring($y.length-1, 1) 
         if ($op -eq "+"){$subT=($w0+$w1)} 
         if ($op -eq "-"){$subT=($w0-$w1)} 
         if ($op -eq "x"){$subT=($w0*$w1)} 
         if ($op -eq "/"){$subT=($w0/$w1)} 
          
         write-host "$w0 $op $w1 = $subT" 
          
         MiniReg Fin "2" -s  
         MiniReg Val "$subT$op" -s 
         MiniReg Val2 $W1 -s      
          
         $textBoxDisplay.Text = $subT         
      } 
      else 
      { 
         MiniReg Fin "1" -s 
      } 
   } 
} 
 
 
 
 
 
 
$buttonback_OnClick=  
{ 
   [string]$Display=$textBoxDisplay.Text 
   if ((MiniReg Fin) -eq "0") 
   { 
      if (!($Display -eq "0")) 
      { 
         if($Display.length -eq 1) 
         { 
            $Display="0" 
         } 
         else 
         {       
            $Display = $Display.substring(0,$Display.length-1) 
    
            if($Display.substring($Display.length-1,1) -eq ".") 
            {   
               $Display = $Display.substring(0,$Display.length-1) 
            } 
    
            if($Display -eq "-" -or $Display -eq "-0") 
            { 
               $Display="0" 
            }       
         } 
         $textBoxDisplay.Text = $Display  
      }   
   } 
   else 
   { 
      write-host "Backspace disabled on $Display" -for red  
   } 
} 
 
$buttonCE_OnClick=  
{ 
   MiniReg OpP "0" -s 
   $textBoxDisplay.Text = "0" 
} 
 
$buttonC_OnClick=  
{ 
   $textBoxDisplay.Text = "0"  
   MiniReg OpP "0" -s 
   MiniReg Fin "0" -s 
   MiniReg Val "" -s 
   MiniReg Val2 "" -s   
    
   clear-host    
   Write-Host "      PowerShell Calculator      " -for green 
   Write-Host ""   
    
} 
 
$buttonSign_OnClick=  
{ 
   MiniReg OpP "0" -s 
   [string]$Display = $textBoxDisplay.Text    
   if (!($Display -eq "0")) 
   { 
      if ($Display.contains("-")) 
      {    
         $Display = $Display.substring(1,$Display.length-1) 
      } 
      else 
      { 
         $Display = "-" + $Display 
      } 
      $textBoxDisplay.Text = $display    
   } 
} 
 
$OnLoadForm_StateCorrection= 
{#Correct the initial state of the form to prevent the .Net maximized form issue 
    $form1.WindowState = $InitialFormWindowState   
} 
 
#---------------------------------------------- 
#region Generated Form Code 
$form1.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",8.25,0,3,0) 
$form1.Text = "PowerShell Calculator" 
$form1.Name = "form1" 
$form1.DataBindings.DefaultDataSourceUpdateMode = 0 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 267 
$System_Drawing_Size.Height = 194 
$form1.ClientSize = $System_Drawing_Size 
 
$buttonMemClear.TabIndex = 29 
$buttonMemClear.Name = "buttonMemClear" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 39 
$System_Drawing_Size.Height = 23 
$buttonMemClear.Size = $System_Drawing_Size 
$buttonMemClear.UseVisualStyleBackColor = $True 
 
$buttonMemClear.Text = "MC" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 14 
$System_Drawing_Point.Y = 69 
$buttonMemClear.Location = $System_Drawing_Point 
$buttonMemClear.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonMemClear.add_Click($buttonMemClear_OnClick) 
 
$form1.Controls.Add($buttonMemClear) 
 
$buttonback.TabIndex = 28 
$buttonback.Name = "buttonback" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 39 
$System_Drawing_Size.Height = 23 
$buttonback.Size = $System_Drawing_Size 
$buttonback.UseVisualStyleBackColor = $True 
 
$buttonback.Text = "BS" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 43 
$System_Drawing_Point.Y = 41 
$buttonback.Location = $System_Drawing_Point 
$buttonback.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonback.add_Click($buttonback_OnClick) 
 
$form1.Controls.Add($buttonback) 
 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 20 
$System_Drawing_Size.Height = 20 
$textBoxMem.Size = $System_Drawing_Size 
$textBoxMem.DataBindings.DefaultDataSourceUpdateMode = 0 
$textBoxMem.TextAlign = 2 
$textBoxMem.ReadOnly = $True 
$textBoxMem.BorderStyle = 1 
$textBoxMem.Name = "textBoxMem" 
$textBoxMem.BackColor = [System.Drawing.Color]::FromArgb(255,236,233,216) 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 17 
$System_Drawing_Point.Y = 42 
$textBoxMem.Location = $System_Drawing_Point 
$textBoxMem.TabIndex = 0 
$textBoxMem.add_TextChanged($handler_textBox2_TextChanged) 
 
$form1.Controls.Add($textBoxMem) 
 
$buttonMemSave.TabIndex = 26 
$buttonMemSave.Name = "buttonMemSave" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 39 
$System_Drawing_Size.Height = 23 
$buttonMemSave.Size = $System_Drawing_Size 
$buttonMemSave.UseVisualStyleBackColor = $True 
 
$buttonMemSave.Text = "MS" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 14 
$System_Drawing_Point.Y = 127 
$buttonMemSave.Location = $System_Drawing_Point 
$buttonMemSave.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonMemSave.add_Click($buttonMemSave_OnClick) 
 
$form1.Controls.Add($buttonMemSave) 
 
$buttonMemRecal.TabIndex = 25 
$buttonMemRecal.Name = "buttonMemRecal" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 39 
$System_Drawing_Size.Height = 23 
$buttonMemRecal.Size = $System_Drawing_Size 
$buttonMemRecal.UseVisualStyleBackColor = $True 
 
$buttonMemRecal.Text = "MR" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 14 
$System_Drawing_Point.Y = 98 
$buttonMemRecal.Location = $System_Drawing_Point 
$buttonMemRecal.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonMemRecal.add_Click($buttonMemRecal_OnClick) 
 
$form1.Controls.Add($buttonMemRecal) 
 
$buttonMemPlus.TabIndex = 24 
$buttonMemPlus.Name = "buttonMemPlus" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 39 
$System_Drawing_Size.Height = 23 
$buttonMemPlus.Size = $System_Drawing_Size 
$buttonMemPlus.UseVisualStyleBackColor = $True 
 
$buttonMemPlus.Text = "M+" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 14 
$System_Drawing_Point.Y = 157 
$buttonMemPlus.Location = $System_Drawing_Point 
$buttonMemPlus.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonMemPlus.add_Click($buttonMemPlus_OnClick) 
 
$form1.Controls.Add($buttonMemPlus) 
 
$buttonCE.TabIndex = 23 
$buttonCE.Name = "buttonCE" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 39 
$System_Drawing_Size.Height = 23 
$buttonCE.Size = $System_Drawing_Size 
$buttonCE.UseVisualStyleBackColor = $True 
 
$buttonCE.Text = "CE" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 86 
$System_Drawing_Point.Y = 41 
$buttonCE.Location = $System_Drawing_Point 
$buttonCE.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonCE.add_Click($buttonCE_OnClick) 
 
$form1.Controls.Add($buttonCE) 
 
$buttonC.TabIndex = 22 
$buttonC.Name = "buttonC" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 39 
$System_Drawing_Size.Height = 23 
$buttonC.Size = $System_Drawing_Size 
$buttonC.UseVisualStyleBackColor = $True 
 
$buttonC.Text = "C" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 130 
$System_Drawing_Point.Y = 41 
$buttonC.Location = $System_Drawing_Point 
$buttonC.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonC.add_Click($buttonC_OnClick) 
 
$form1.Controls.Add($buttonC) 
 
$buttonF4.TabIndex = 21 
$buttonF4.Name = "buttonF4" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$buttonF4.Size = $System_Drawing_Size 
$buttonF4.UseVisualStyleBackColor = $True 
 
#$buttonF4.Text = "F4" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 175 
$System_Drawing_Point.Y = 127 
$buttonF4.Location = $System_Drawing_Point 
$buttonF4.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonF4.add_Click($buttonF4_OnClick) 
 
$form1.Controls.Add($buttonF4) 
 
$buttonEquals.TabIndex = 20 
$buttonEquals.Name = "buttonEquals" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$buttonEquals.Size = $System_Drawing_Size 
$buttonEquals.UseVisualStyleBackColor = $True 
 
$buttonEquals.Text = "=" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 175 
$System_Drawing_Point.Y = 156 
$buttonEquals.Location = $System_Drawing_Point 
$buttonEquals.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonEquals.add_Click($buttonEquals_OnClick) 
 
$form1.Controls.Add($buttonEquals) 
 
$buttonF3.TabIndex = 19 
$buttonF3.Name = "buttonF3" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$buttonF3.Size = $System_Drawing_Size 
$buttonF3.UseVisualStyleBackColor = $True 
 
#$buttonF3.Text = "F3" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 175 
$System_Drawing_Point.Y = 98 
$buttonF3.Location = $System_Drawing_Point 
$buttonF3.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonF3.add_Click($buttonF3_OnClick) 
 
$form1.Controls.Add($buttonF3) 
 
$buttonF2.TabIndex = 18 
$buttonF2.Name = "buttonF2" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$buttonF2.Size = $System_Drawing_Size 
$buttonF2.UseVisualStyleBackColor = $True 
 
#$buttonF2.Text = "F2" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 175 
$System_Drawing_Point.Y = 68 
$buttonF2.Location = $System_Drawing_Point 
$buttonF2.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonF2.add_Click($buttonF2_OnClick) 
 
$form1.Controls.Add($buttonF2) 
 
$buttonF1.TabIndex = 17 
$buttonF1.Name = "buttonF1" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 75 
$System_Drawing_Size.Height = 23 
$buttonF1.Size = $System_Drawing_Size 
$buttonF1.UseVisualStyleBackColor = $True 
 
#$buttonF1.Text = "F1" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 175 
$System_Drawing_Point.Y = 41 
$buttonF1.Location = $System_Drawing_Point 
$buttonF1.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonF1.add_Click($buttonF1_OnClick) 
 
$form1.Controls.Add($buttonF1) 
 
$buttonplus.TabIndex = 16 
$buttonplus.Name = "buttonplus" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$buttonplus.Size = $System_Drawing_Size 
$buttonplus.UseVisualStyleBackColor = $True 
 
$buttonplus.Text = "+" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 146 
$System_Drawing_Point.Y = 157 
$buttonplus.Location = $System_Drawing_Point 
$buttonplus.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonplus.add_Click($buttonplus_OnClick) 
 
$form1.Controls.Add($buttonplus) 
 
$buttonMinus.TabIndex = 15 
$buttonMinus.Name = "buttonMinus" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$buttonMinus.Size = $System_Drawing_Size 
$buttonMinus.UseVisualStyleBackColor = $True 
 
$buttonMinus.Text = "-" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 146 
$System_Drawing_Point.Y = 127 
$buttonMinus.Location = $System_Drawing_Point 
$buttonMinus.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonMinus.add_Click($buttonMinus_OnClick) 
 
$form1.Controls.Add($buttonMinus) 
 
$buttonMultip.TabIndex = 14 
$buttonMultip.Name = "buttonMultip" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$buttonMultip.Size = $System_Drawing_Size 
$buttonMultip.UseVisualStyleBackColor = $True 
 
$buttonMultip.Text = "x" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 146 
$System_Drawing_Point.Y = 97 
$buttonMultip.Location = $System_Drawing_Point 
$buttonMultip.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonMultip.add_Click($buttonMultip_OnClick) 
 
$form1.Controls.Add($buttonMultip) 
 
$buttonDiv.TabIndex = 13 
$buttonDiv.Name = "buttonDiv" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$buttonDiv.Size = $System_Drawing_Size 
$buttonDiv.UseVisualStyleBackColor = $True 
 
$buttonDiv.Text = "/" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 146 
$System_Drawing_Point.Y = 69 
$buttonDiv.Location = $System_Drawing_Point 
$buttonDiv.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonDiv.add_Click($buttonDiv_OnClick) 
 
$form1.Controls.Add($buttonDiv) 
 
$buttonDot.TabIndex = 12 
$buttonDot.Name = "buttonDot" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$buttonDot.Size = $System_Drawing_Size 
$buttonDot.UseVisualStyleBackColor = $True 
 
$buttonDot.Text = "." 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 116 
$System_Drawing_Point.Y = 157 
$buttonDot.Location = $System_Drawing_Point 
$buttonDot.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonDot.add_Click($buttonDot_OnClick) 
 
$form1.Controls.Add($buttonDot) 
 
$buttonSign.TabIndex = 11 
$buttonSign.Name = "buttonSign" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$buttonSign.Size = $System_Drawing_Size 
$buttonSign.UseVisualStyleBackColor = $True 
 
$buttonSign.Text = "+/-" 
$buttonSign.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",6,0,3,0) 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 88 
$System_Drawing_Point.Y = 157 
$buttonSign.Location = $System_Drawing_Point 
$buttonSign.DataBindings.DefaultDataSourceUpdateMode = 0 
$buttonSign.add_Click($buttonSign_OnClick) 
 
$form1.Controls.Add($buttonSign) 
 
$button0.TabIndex = 10 
$button0.Name = "button0" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button0.Size = $System_Drawing_Size 
$button0.UseVisualStyleBackColor = $True 
 
$button0.Text = "0" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 59 
$System_Drawing_Point.Y = 157 
$button0.Location = $System_Drawing_Point 
$button0.DataBindings.DefaultDataSourceUpdateMode = 0 
$button0.add_Click($handler_button0_Click) 
 
$form1.Controls.Add($button0) 
 
$button9.TabIndex = 9 
$button9.Name = "button9" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button9.Size = $System_Drawing_Size 
$button9.UseVisualStyleBackColor = $True 
 
$button9.Text = "9" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 116 
$System_Drawing_Point.Y = 69 
$button9.Location = $System_Drawing_Point 
$button9.DataBindings.DefaultDataSourceUpdateMode = 0 
$button9.add_Click($button9_OnClick) 
 
$form1.Controls.Add($button9) 
 
$button8.TabIndex = 8 
$button8.Name = "button8" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button8.Size = $System_Drawing_Size 
$button8.UseVisualStyleBackColor = $True 
 
$button8.Text = "8" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 88 
$System_Drawing_Point.Y = 69 
$button8.Location = $System_Drawing_Point 
$button8.DataBindings.DefaultDataSourceUpdateMode = 0 
$button8.add_Click($button8_OnClick) 
 
$form1.Controls.Add($button8) 
 
$button7.TabIndex = 7 
$button7.Name = "button7" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button7.Size = $System_Drawing_Size 
$button7.UseVisualStyleBackColor = $True 
 
$button7.Text = "7" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 59 
$System_Drawing_Point.Y = 69 
$button7.Location = $System_Drawing_Point 
$button7.DataBindings.DefaultDataSourceUpdateMode = 0 
$button7.add_Click($button7_OnClick) 
 
$form1.Controls.Add($button7) 
 
$button6.TabIndex = 6 
$button6.Name = "button6" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button6.Size = $System_Drawing_Size 
$button6.UseVisualStyleBackColor = $True 
 
$button6.Text = "6" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 116 
$System_Drawing_Point.Y = 98 
$button6.Location = $System_Drawing_Point 
$button6.DataBindings.DefaultDataSourceUpdateMode = 0 
$button6.add_Click($button6_OnClick) 
 
$form1.Controls.Add($button6) 
 
$button5.TabIndex = 5 
$button5.Name = "button5" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button5.Size = $System_Drawing_Size 
$button5.UseVisualStyleBackColor = $True 
 
$button5.Text = "5" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 88 
$System_Drawing_Point.Y = 97 
$button5.Location = $System_Drawing_Point 
$button5.DataBindings.DefaultDataSourceUpdateMode = 0 
$button5.add_Click($button5_Click) 
 
$form1.Controls.Add($button5) 
 
$button4.TabIndex = 4 
$button4.Name = "button4" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button4.Size = $System_Drawing_Size 
$button4.UseVisualStyleBackColor = $True 
 
$button4.Text = "4" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 59 
$System_Drawing_Point.Y = 98 
$button4.Location = $System_Drawing_Point 
$button4.DataBindings.DefaultDataSourceUpdateMode = 0 
$button4.add_Click($button4_OnClick) 
 
$form1.Controls.Add($button4) 
 
$button3.TabIndex = 3 
$button3.Name = "button3" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button3.Size = $System_Drawing_Size 
$button3.UseVisualStyleBackColor = $True 
 
$button3.Text = "3" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 116 
$System_Drawing_Point.Y = 127 
$button3.Location = $System_Drawing_Point 
$button3.DataBindings.DefaultDataSourceUpdateMode = 0 
$button3.add_Click($button3_OnClick) 
 
$form1.Controls.Add($button3) 
 
$button2.TabIndex = 2 
$button2.Name = "button2" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button2.Size = $System_Drawing_Size 
$button2.UseVisualStyleBackColor = $True 
 
$button2.Text = "2" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 88 
$System_Drawing_Point.Y = 127 
$button2.Location = $System_Drawing_Point 
$button2.DataBindings.DefaultDataSourceUpdateMode = 0 
$button2.add_Click($button2_OnClick) 
 
$form1.Controls.Add($button2) 
 
$button1.TabIndex = 1 
$button1.Name = "button1" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 23 
$System_Drawing_Size.Height = 23 
$button1.Size = $System_Drawing_Size 
$button1.UseVisualStyleBackColor = $True 
 
$button1.Text = "1" 
 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 59 
$System_Drawing_Point.Y = 127 
$button1.Location = $System_Drawing_Point 
$button1.DataBindings.DefaultDataSourceUpdateMode = 0 
$button1.add_Click($button1_OnClick) 
 
$form1.Controls.Add($button1) 
 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 236 
$System_Drawing_Size.Height = 20 
$textBoxDisplay.Size = $System_Drawing_Size 
$textBoxDisplay.DataBindings.DefaultDataSourceUpdateMode = 0 
$textBoxDisplay.TextAlign = 1 
$textBoxDisplay.ReadOnly = $True 
$textBoxDisplay.Name = "textBoxDisplay" 
$textBoxDisplay.BackColor = [System.Drawing.Color]::FromArgb(255,255,255,225) 
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = 14 
$System_Drawing_Point.Y = 13 
$textBoxDisplay.Location = $System_Drawing_Point 
$textBoxDisplay.TabIndex = 100 
$textBoxDisplay.Text = "0" 
 
$form1.Controls.Add($textBoxDisplay) 
 
#endregion Generated Form Code 
 
#Save the initial state of the form 
$InitialFormWindowState = $form1.WindowState 
#Init the OnLoad event to correct the initial state of the form 
$form1.add_Load($OnLoadForm_StateCorrection) 
#Show the Form 
$form1.ShowDialog()| Out-Null 
 
} #End Function 
 
#Call the Function 
GenerateForm 
 
 
