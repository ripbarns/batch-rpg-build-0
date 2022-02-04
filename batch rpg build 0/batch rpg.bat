echo off
setlocal enabledelayedexpansion
set build=0
title batch rpg build !build!
cd "%~dp0"/bin

:menu
cls
echo.
echo  batch rpg build !build! !debug!
echo.
echo  1. Continue
echo  2. New
echo  3. Information
echo  4. Exit
choice /c 12348d /n
if !errorlevel! equ 1 goto load
if !errorlevel! equ 2 goto new
if !errorlevel! equ 3 goto info
if !errorlevel! equ 4 exit
if !errorlevel! equ 5 set debug=true
if !errorlevel! equ 6 if !debug! equ true goto debug
goto menu

:info
cls
echo.
echo  batch rpg build !build! - Information
echo.
echo  Created and programmed by: @ripbarns
echo.
echo  Follow me on all major platforms.
echo.
echo  Press any key to continue.
pause > nul
goto menu

:debug
cls
echo.
set /p input=debug: 
!input!
goto debug

:new
set HPM=10
set HPC=10
set ATK=2
set DEF=1
set X=1
set Y=1
set Z=2
set space=" "
goto map

:save
cls
echo save
pause
goto menu

:load
cls
echo load
pause
goto menu

:map
(
	set /p line0=
	set /p line1=
	set /p line2=
	set /p line3=
	set /p line4=
) < map.txt
goto refresh

:refresh
set disp0=!line0!
set disp1=!line1!
set disp2=!line2!
set disp3=!line3!
set disp4=!line4!

set disp!Y!=!line%Y%:~0,%X%!@!line%Y%:~%Z%!
goto screen

:screen
cls
echo.
echo  !disp0!
echo  !disp1!
echo  !disp2!
echo  !disp3!
echo  !disp4!
echo !space!
echo !line%Y%:~%X%,1!
choice /c wasd /n
if !errorlevel! equ 1 goto move
if !errorlevel! equ 2 goto move
if !errorlevel! equ 3 goto move
if !errorlevel! equ 4 goto move
goto screen

:move
if !errorlevel! equ 1 set /a Y=!Y! - 1
if !errorlevel! equ 2 set /a X=!X! - 1
if !errorlevel! equ 3 set /a Y=!Y! + 1
if !errorlevel! equ 4 set /a X=!X! + 1

set /a Z=!X! + 1

goto collide

:collide
if "!line%Y%:~%X%,1!" neq !space! (
	if !errorlevel! equ 1 set /a Y=!Y! + 1
	if !errorlevel! equ 2 set /a X=!X! + 1
	if !errorlevel! equ 3 set /a Y=!Y! - 1
	if !errorlevel! equ 4 set /a X=!X! - 1
)

set /a Z=!X! + 1

goto refresh