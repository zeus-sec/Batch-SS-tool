@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
:Main
color b
title SStool ^| by zEus
cls
wmic csproduct get UUID | findstr /v "UUID" >> %ProgramData%\hwid.txt
set /p uuid=<%ProgramData%\hwid.txt
echo.
echo ███████╗███████╗    ████████╗ ██████╗  ██████╗ ██╗     
echo ██╔════╝██╔════╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     
echo ███████╗███████╗       ██║   ██║   ██║██║   ██║██║     
echo ╚════██║╚════██║       ██║   ██║   ██║██║   ██║██║     
echo ███████║███████║       ██║   ╚██████╔╝╚██████╔╝███████╗
echo ╚══════╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
echo  HWID: !uuid!
echo.
echo [1] Prefetch
echo [2] Mouse detector
echo [3] Sus Files
echo [4] ProcessHacker
echo [5] Recycled Bin

echo.
set /p options=[+] Option: 

if %options% == 1 goto :Prefetch
if %options% == 2 goto :Mousedetector
if %options% == 3 goto :susfiles
if %options% == 4 goto :ProcessHacker
if %options% == 5 goto :RecycledBin


:Prefetch
echo Add-Type -AssemblyName System.Windows.Forms >> %ProgramData%\prefetch_list.ps1
echo Add-Type -AssemblyName System.Drawing >> %ProgramData%\prefetch_list.ps1
echo $form = New-Object Windows.Forms.Form >> %ProgramData%\prefetch_list.ps1
echo $form.Text = "Informations des fichiers Prefetch" >> %ProgramData%\prefetch_list.ps1
echo $form.Size = New-Object Drawing.Size(1200, 700) >> %ProgramData%\prefetch_list.ps1
echo $form.StartPosition = "CenterScreen" >> %ProgramData%\prefetch_list.ps1
echo $dataGridView = New-Object Windows.Forms.DataGridView >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.Size = New-Object Drawing.Size(1170, 600) >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.Location = New-Object Drawing.Point(10, 40)  # Décalage de 40 pixels vers le bas pour faire place à la barre de recherche >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.AutoSizeColumnsMode = [System.Windows.Forms.DataGridViewAutoSizeColumnsMode]::Fill >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.ColumnCount = 5  # Ajout d'une colonne pour la date de modification >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.Columns[0].Name = "Date de Modification"  # Nouvelle colonne pour la date de modification >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.Columns[1].Name = "Nom du fichier" >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.Columns[2].Name = "Chemin du fichier" >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.Columns[3].Name = "Signature du fichier" >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.Columns[4].Name = "Extension du fichier" >> %ProgramData%\prefetch_list.ps1
echo $prefetch_folder = "C:\Windows\Prefetch" >> %ProgramData%\prefetch_list.ps1
echo if (-Not (Test-Path $prefetch_folder)) { >> %ProgramData%\prefetch_list.ps1
echo     [System.Windows.Forms.MessageBox]::Show("Le dossier Prefetch n'existe pas.") >> %ProgramData%\prefetch_list.ps1
echo     exit >> %ProgramData%\prefetch_list.ps1
echo } >> %ProgramData%\prefetch_list.ps1
echo Get-ChildItem -Path $prefetch_folder -Filter * ^| ForEach-Object { >> %ProgramData%\prefetch_list.ps1
echo     $filename = $_.Name >> %ProgramData%\prefetch_list.ps1
echo     $filepath = $_.FullName >> %ProgramData%\prefetch_list.ps1
echo     $extension = $_.Extension >> %ProgramData%\prefetch_list.ps1
echo     $signatureStatus = (Get-AuthenticodeSignature -FilePath $filepath).Status >> %ProgramData%\prefetch_list.ps1
echo     if ($signatureStatus -eq 'Valid') { >> %ProgramData%\prefetch_list.ps1
echo         $filesignature = ':)' >> %ProgramData%\prefetch_list.ps1
echo     } else { >> %ProgramData%\prefetch_list.ps1
echo         $filesignature = '!' >> %ProgramData%\prefetch_list.ps1
echo     } >> %ProgramData%\prefetch_list.ps1
echo     $modifiedDate = $_.LastWriteTime  # Récupérer la date de dernière modification >> %ProgramData%\prefetch_list.ps1
echo     $row = @($modifiedDate, $filename, $filepath, $filesignature, $extension) >> %ProgramData%\prefetch_list.ps1
echo     $dataGridView.Rows.Add($row) ^| Out-Null >> %ProgramData%\prefetch_list.ps1
echo } >> %ProgramData%\prefetch_list.ps1
echo $contextMenu = New-Object Windows.Forms.ContextMenuStrip >> %ProgramData%\prefetch_list.ps1
echo $openLocationMenuItem = New-Object Windows.Forms.ToolStripMenuItem("Ouvrir l'emplacement") >> %ProgramData%\prefetch_list.ps1
echo $contextMenu.Items.Add($openLocationMenuItem) >> %ProgramData%\prefetch_list.ps1
echo $dataGridView.add_MouseClick({ >> %ProgramData%\prefetch_list.ps1
echo     param($sender, $e) >> %ProgramData%\prefetch_list.ps1
echo     if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Right) { >> %ProgramData%\prefetch_list.ps1
echo         $currentMouseOverRow = $dataGridView.HitTest($e.X, $e.Y).RowIndex >> %ProgramData%\prefetch_list.ps1
echo         if ($currentMouseOverRow -ge 0) { >> %ProgramData%\prefetch_list.ps1
echo             $dataGridView.ClearSelection() >> %ProgramData%\prefetch_list.ps1
echo             $dataGridView.Rows[$currentMouseOverRow].Selected = $true >> %ProgramData%\prefetch_list.ps1
echo             $contextMenu.Show($dataGridView, $e.Location) >> %ProgramData%\prefetch_list.ps1
echo         } >> %ProgramData%\prefetch_list.ps1
echo     } >> %ProgramData%\prefetch_list.ps1
echo }) >> %ProgramData%\prefetch_list.ps1
echo $openLocationMenuItem.add_Click({ >> %ProgramData%\prefetch_list.ps1
echo     $selectedRow = $dataGridView.SelectedRows[0] >> %ProgramData%\prefetch_list.ps1
echo     $filePath = $selectedRow.Cells[1].Value >> %ProgramData%\prefetch_list.ps1
echo     if (Test-Path $filePath) { >> %ProgramData%\prefetch_list.ps1
echo         $directory = Split-Path "$filePath" >> %ProgramData%\prefetch_list.ps1
echo         Start-Process explorer.exe $directory >> %ProgramData%\prefetch_list.ps1
echo     } >> %ProgramData%\prefetch_list.ps1
echo }) >> %ProgramData%\prefetch_list.ps1
echo $searchBox = New-Object Windows.Forms.TextBox >> %ProgramData%\prefetch_list.ps1
echo $searchBox.Location = New-Object Drawing.Point(10, 10) >> %ProgramData%\prefetch_list.ps1
echo $searchBox.Size = New-Object Drawing.Size(1170, 20) >> %ProgramData%\prefetch_list.ps1
echo $searchBox.Anchor = "Top, Left, Right" >> %ProgramData%\prefetch_list.ps1
echo $searchBox.add_TextChanged({ >> %ProgramData%\prefetch_list.ps1
echo     $searchText = $searchBox.Text.Trim() >> %ProgramData%\prefetch_list.ps1
echo     foreach ($row in $dataGridView.Rows) { >> %ProgramData%\prefetch_list.ps1
echo         foreach ($cell in $row.Cells) { >> %ProgramData%\prefetch_list.ps1
echo             if ($cell.Value -like "*$searchText*") { >> %ProgramData%\prefetch_list.ps1
echo                 $row.Visible = $true >> %ProgramData%\prefetch_list.ps1
echo                 break >> %ProgramData%\prefetch_list.ps1
echo             } else { >> %ProgramData%\prefetch_list.ps1
echo                 $row.Visible = $false >> %ProgramData%\prefetch_list.ps1
echo             } >> %ProgramData%\prefetch_list.ps1
echo         } >> %ProgramData%\prefetch_list.ps1
echo     } >> %ProgramData%\prefetch_list.ps1
echo }) >> %ProgramData%\prefetch_list.ps1
echo $form.Controls.Add($searchBox) >> %ProgramData%\prefetch_list.ps1
echo $form.Controls.Add($dataGridView) >> %ProgramData%\prefetch_list.ps1
echo $form.Add_Shown({$form.Activate()}) >> %ProgramData%\prefetch_list.ps1
echo [void] $form.ShowDialog() >> %ProgramData%\prefetch_list.ps1
powershell -ExecutionPolicy Bypass -File "%ProgramData%\prefetch_list.ps1"
pause > nul
del /f /q /s %ProgramData%\prefetch_list.ps1
goto :Main


:Mousedetector
cls
echo.
echo.
if NOT EXIST "C:\ProgramData\Alienware\AlienWare" (
    set AlienWare=Alienware ❌
) else (
    set AlienWare=AlienWare ✅
)
if NOT EXIST "C:\users\%username%\documents\ASUS\ROG\ROG Armoury\common\" (
    set ASUS=Asus ❌
) else (
    set ASUS=Asus ✅
)
if NOT EXIST "C:\Program Files\AYAX GamingMouse." (
    set Ayax=Ayax ❌
) else (
    set Ayax=Ayax ✅
)
if NOT EXIST "C:\Program Files (x86)\Bloody7\Bloody7\UserLog\Mouse" (
    set Bloody7=Bloody7 ❌
) else (
    set Bloody7=Bloody7 ✅
)
if NOT EXIST "C:\ProgramData\CoolerMaster\PORTAL\config\" (
    set CoolerMaster=CoolerMaster ❌
) else (
    set CoolerMaster=CoolerMaster ✅
)
if NOT EXIST "C:\users\%USERNAME%\appdata\local\corsair\CUE" (
    set corsair=corsair ❌
) else (
    set corsair=corsair ✅
)
if NOT EXIST "C:\Users\%username%\AppData\Local\VirtualStore\Program Files (x86)\KROM KOLT\Config" (
    set KROM=KROM ❌
) else (
    set KROM=KROM ✅
)
if NOT EXIST "C:\Users\%username%\AppData\Local\LGHUB" (
    set LGHUB=LGHUB ❌
) else (
    set LGHUB=LGHUB ✅
)
if NOT EXIST "C:\Program Files (x86)\MARSGAMING\MMGX\modules\macro" (
    set MARSGAMING=MARSGAMING ❌
) else (
    set MARSGAMING=MARSGAMING ✅
)
if NOT EXIST "%localappdata%\BY-COMBO2\Mac" (
    set Glorious=Glorious ❌
) else (
    set Glorious=Glorious ✅
)
if NOT EXIST "C:\Program Files (x86)\MotoSpeed Gaming Mouse\V60\modules\" (
    set MotoSpeed=MotoSpeed ❌
) else (
    set MotoSpeed=MotoSpeed ✅
)
if NOT EXIST "C:\Users\%username%\AppData\Roaming\ROCCAT\SWARM\macro" (
    set ROCCAT=ROCCAT ❌
) else (
    set ROCCAT=ROCCAT ✅
)
if NOT EXIST "C:\Program Files (x86)\Xenon200\" (
    set Xenon200=Xenon200 ❌
) else (
    set Xenon200=Xenon200 ✅
)
echo %AlienWare%
echo %ASUS%
echo %Ayax%
echo %Bloody7%
echo %CoolerMaster%
echo %corsair%
echo %KROM%
echo %LGHUB%
echo %MARSGAMING%
echo %Glorious%
echo %MotoSpeed%
echo %ROCCAT%
echo %Xenon200%
pause > nul
goto :Main





:susfiles
cls
set "prefetch_dir=C:\Windows\Prefetch"
set "keywords=auto cheat aimassist vape Contrainer"

set "lunarClientDir=%userprofile%\.lunarclient\settings\game\accounts.json"
findstr "username" "%lunarClientDir%" > "%temp%\Minecraftacc.txt"
set /p minecraftAccount=<"%temp%\Minecraftacc.txt"
echo !minecraftAccount!
echo.
for %%f in (%prefetch_dir%\*) do (
    set "filename=%%~nxf"

    rem Parcourir chaque mot-clé
    for %%k in (%keywords%) do (
        echo !filename! | find /I "%%k" >nul
        if !errorlevel! == 0 (
            echo [+] %%~nxf
        )
    )
)
echo.
echo.
echo [1;35mEND
timeout 3 > nul
del /q /f "%temp%\Minecraftacc.txt"
goto :Main


:ProcessHacker
cls
start https://processhacker.sourceforge.io/downloads.php
goto :Main

:RecycledBin
cls
echo Last Recycled Bin:
forfiles /P C:\$Recycle.Bin /C "cmd /c echo @fdate @ftime"
pause > nul
goto :Main