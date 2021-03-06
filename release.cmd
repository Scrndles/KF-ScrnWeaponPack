@echo off

setlocal
set KFDIR=d:\Games\kf
set STEAMDIR=c:\Steam\steamapps\common\KillingFloor
set outputdir=D:\KFOut\ScrnWeaponPack

echo Removing previous release files...
del /S /Q %outputdir%\*


echo Compiling project...
call make.cmd
if %ERRORLEVEL% NEQ 0 goto end

echo Exporting .int file...
%KFDIR%\system\ucc dumpint ScrnWeaponPack.u

echo.
echo Copying release files...
mkdir %outputdir%\Animations
mkdir %outputdir%\Sounds
mkdir %outputdir%\StaticMeshes
mkdir %outputdir%\System
mkdir %outputdir%\Textures
REM mkdir %outputdir%\uz2


copy /y %KFDIR%\system\ScrnWeaponPack.* %outputdir%\System\
copy /y %STEAMDIR%\Animations\ScrnWeaponPack_A.ukx %outputdir%\Animations\
copy /y %STEAMDIR%\Sounds\ScrnWeaponPack_SND.uax %outputdir%\Sounds\
copy /y %STEAMDIR%\StaticMeshes\ScrnWeaponPack_SM.usx %outputdir%\StaticMeshes\
copy /y %STEAMDIR%\Textures\ScrnWeaponPack_T.utx %outputdir%\Textures\
copy /y readme.txt  %outputdir%
copy /y changes.txt  %outputdir%


REM echo Compressing to .uz2...
REM %KFDIR%\system\ucc compress %KFDIR%\system\ScrnWeaponPack.u
REM %KFDIR%\system\ucc compress %STEAMDIR%\Animations\ScrnWeaponPack_A.ukx
REM %KFDIR%\system\ucc compress %STEAMDIR%\Sounds\ScrnWeaponPack_SND.uax
REM %KFDIR%\system\ucc compress %STEAMDIR%\StaticMeshes\ScrnWeaponPack_SM.usx
REM %KFDIR%\system\ucc compress %STEAMDIR%\Textures\ScrnWeaponPack_T.utx
REM
REM move /y %KFDIR%\system\ScrnWeaponPack.u.uz2 %outputdir%\uz2
REM move /y %STEAMDIR%\Animations\ScrnWeaponPack_A.ukx.uz2 %outputdir%\uz2
REM move /y %STEAMDIR%\Sounds\ScrnWeaponPack_SND.uax.uz2 %outputdir%\uz2
REM move /y %STEAMDIR%\StaticMeshes\ScrnWeaponPack_SM.usx.uz2 %outputdir%\uz2
REM move /y %STEAMDIR%\Textures\ScrnWeaponPack_T.utx.uz2 %outputdir%\uz2

echo Release is ready!

endlocal

pause

:end
