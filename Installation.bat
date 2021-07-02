@echo off

echo BEGIN LOG... %date% %time% > %~dp0\log.srr
set Version=1.12.0
set GitVersion=1.1.0
echo Running local version %version%, and Github version %GitVersion%... >> %~dp0\log.srr
:root
net session
if %errorlevel% equ 0 (echo Admin rights detected. >> %~dp0\log.srr) else (echo Admin rights denied. >> %~dp0\log.srr)
cls & color F0
echo Color initialized... %time% >> %~dp0\log.srr
mode con cols=82 lines=25
echo Console size initialized... %time% >> %~dp0\log.srr
echo Running correctly... %time% >> %~dp0\log.srr
echo Current user: %Userprofile% >> %~dp0\log.srr
echo Showing welcome screen... %time% >> %~dp0\log.srr
echo                                                                                                                                                                                                                                                                                           Version %version%                                                                                                                                   Thanks for downloading Swirren's modpack installer.                                             All code was handwritten.                              If the console reports any errors that re-running the program does not fix,       send the "log.srr" file located in this folder to Swirren#8879 on Discord.                                                                               & %SystemRoot%\System32\choice.exe /C Y0S /N /M "[Press Y to continue]"
if %errorlevel% EQU 1 echo Choice returned a value of 1 (Continue) %time% >> %~dp0\log.srr & (goto precontinue)
if %errorlevel% EQU 2 echo --- >> %~dp0\log.srr & echo Choice returned a value of 2 (Devmenu) %time% >> %~dp0\log.srr & (goto deleteall)
if %errorlevel% EQU 3 echo Choice returned a value of 3 (Skipall) %time% >> %~dp0\log.srr & (goto skipall)

:precontinue
color 0B
echo --- >> %~dp0\log.srr

##This checks for an existing installation of Java.
echo JAVA PRECHECK
cls
setlocal EnableExtensions DisableDelayedExpansion
cls
set Location=%ProgramFiles%\Java\jre1.8.0_291\bin
set FileName=javaw.exe
echo  Please wait a moment... Searching for a pre-existing copy of Java 1.8.0 r291...
echo Checking for a pre-existing copy of Java via jre64.exe... %time% >> %~dp0\log.srr
timeout /t 3 /nobreak > NUL
if exist "%Location%\%Filename%" (color 0A & echo Java has already been installed on this computer! & echo Found a pre-existing installation of Java! Continuing... %time% >> %~dp0\log.srr & echo Pre-existing Java installation is at %Location%... %time% >> %~dp0\log.srr & pause & goto preexist) else (goto nojava)

##If the user does NOT have Java already, the script continues as normal.
:nojava
cls
echo No pre-existing copy found. %time% >> %~dp0\log.srr
%SystemRoot%\System32\choice.exe /C Y /N /M "Please click YES when asked to in the upcoming popup. Installing Java is required![Press Y to continue]"
if %errorlevel% EQU 1 echo Choice returned a value of 1 (Accept) %time% >> %~dp0\log.srr & (goto continue)

:continue
echo Installing Java (required)...
timeout 3
echo Installing Java... %time% >> %~dp0\log.srr
cd %~dp0/java
jre64.exe

##This is basically the first Java check, but only after the user has installed Java from the script.
:jcheck
echo JAVA CHECK
cls
echo  Please wait a moment... Searching for "%FileName%" on "%Location%"
echo Searching for Java via jre64.exe... %time% >> %~dp0\log.srr
timeout /t 3 /nobreak > NUL
cls
if exist "%Location%\%FileName%" (color 0A & echo Java has successfully been installed! & echo Found Java! Continuing... %time% >> %~dp0\log.srr & echo Installed Java to %Location% at %time% >> %~dp0\log.srr & pause) else (color 0C & echo Java is not installed! Please re-run this program and try again! & echo Java was rejected or installed elsewhere... %time% >> %~dp0\log.srr & pause & exit)

##This is where the user is directed if/when they have an existing copy of Java.
:preexist
echo FORGE PROFILE INSTALL
color 0B & cls
echo --- >> %~dp0\log.srr
echo Checking for a pre-existing copy of the Forge 1.16.5 profile... >> %~dp0\log.srr
echo Checking for a pre-existing copy of the Forge 1.16.5 profile...
timeout /t 3 /nobreak > NUL
set fpLocation=%AppData%\.minecraft\versions\1.16.5-forge-36.1.0
set fpFileName="1.16.5-forge-36.1.0.json"
if exist "%fpLocation%\%fpFileName%" ( color 0A & echo The Forge launcher profile has already been installed! & echo Found pre-existing Forge profile! Continuing... %time% >> %~dp0\log.srr & echo Pre-existing Forge profile is at %fpLocation%... %time% >> %~dp0\log.srr & echo --- >> %~dp0\log.srr & pause & goto fjarcheck) else (cls & echo No pre-existing Forge profile found. & echo No pre-existing Forge profile found... >> %~dp0\log.srr & goto fpins)

:fpins
echo In the next popup window, please click OK. & pause
echo Installing Forge profile... %time% >> %~dp0\log.srr
cd %~dp0/forge
java -jar forge-1.16.5-36.1.0-installer.jar > NUL

echo FORGE PROFILE CHECK
cls
echo  Please wait a moment...  Searching for Forge 1.16.5 Forge profile...
echo Searching for Forge profile... %time% >> %~dp0\log.srr
timeout /t 3 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A & echo The Forge launcher profile has successfully been installed! & echo Found Forge profile! Continuing... %time% >> %~dp0\log.srr & echo Installed Forge profile to %location% at %time% >> %~dp0\log.srr & pause
) else (
    Color 0C & echo The Forge launcher profile is not installed! Please re-run this program and try again! & echo Forge profile was rejected or installed elsewhere... %time% >> %~dp0\log.srr & pause & exit
)
echo --- >> %~dp0\log.srr

:fjarcheck
echo FORGE JAR PRECHECK
color 0B
cls
set fjLocation=%AppData%\.minecraft\versions\1.16.5-forge-36.1.0
set fjFileName="1.16.5-forge-36.1.0.jar"
echo  Please wait a moment... Searching for a pre-existing Forge library file...
echo Checking for a pre-existing Forge library file... %time% >> %~dp0\log.srr
timeout /t 3 /nobreak > NUL
if exist "%fjLocation%\%fjFilename%" (color 0A & echo  A Forge 1.16.5 library is already installed on this computer! & echo Found a pre-existing Forge 1.16.5 library! Continuing... %time% >> %~dp0\log.srr & echo Pre-existing Forge 1.16.5 library is at %fjLocation%... %time% >> %~dp0\log.srr & pause & goto modins) else (echo No pre-existing Forge 1.16.5 library found. >> %~dp0\log.srr & goto fjins)

:fjins
echo FORGE JAR INSTALL
color 0B & cls
echo Copying Forge .jar... & timeout /t 3 /nobreak > NUL
echo Copying Forge .jar... %time% >> %~dp0\log.srr
copy "%~dp0\forge\1.16.5-forge-36.1.0.jar" "%AppData%\.minecraft\versions\1.16.5-forge-36.1.0" > NUL

echo FORGE JAR CHECK
set Location=%AppData%\.minecraft\versions\1.16.5-forge-36.1.0
set FileName="1.16.5-forge-36.1.0.jar"
echo( & cls
echo( & echo  Please wait a moment...  Searching for "%FileName%" on "%Location%"
echo Searching for Forge .jar... %time% >> %~dp0\log.srr
timeout /t 3 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A & echo Forge has successfully been installed! & echo Found Forge .jar! Continuing... %time% >> %~dp0\log.srr & echo Copied Forge .jar to %location% at %time% >> %~dp0\log.srr & pause
) else (
    Color 0C & echo Forge is not installed! Please re-run this program and try again! & pause & exit
)

::There is no mod check for two reasons: it's an insanely long line that I'm not willing to do (and would be doubled for fastcheck!). Second, there's a dev button to skip the second check which is fast enough for me.

:modins
echo --- >> %~dp0\log.srr
echo MODS COPY
del /q "%~dp0\forge\forge-1.16.5-36.1.0-installer.jar.log"
color 0B & cls
echo Copying mods...
timeout /t 3 /nobreak > NUL
echo Copying mods... %time% >> %~dp0\log.srr
set Location=%AppData%\.minecraft\mods
robocopy "%~dp0\mods" "%AppData%\.minecraft\mods" > NUL

cls
color 0A
echo Mods copied!
echo Mods copied to %location% at %time% >> %~dp0\log.srr
%SystemRoot%\System32\choice.exe /C YSF /N /M "[Press Y to continue]"
if %errorlevel% EQU 1 goto check & echo Choice returned a value of 1 (Continue) %time% >> %~dp0\log.srr
if %errorlevel% EQU 2 goto skipcheck & echo Choice returned a value of 2 (Skipcheck) %time% >> %~dp0\log.srr
if %errorlevel% EQU 3 goto fastcheck & echo Choice returned a value of 3 (Fastcheck) %time% >> %~dp0\log.srr

:check
echo MODS CHECK
echo 1 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="decorative_blocks-1.16.1-1.5.2.jar"
echo Beginning mod filecheck... %time% >> %~dp0\log.srr
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%" & timeout /t 1 /nobreak > NUL
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A & echo Mod 1/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 1/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 2 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Golden-Hopper-Mod-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 2/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 2/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 3 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="gravestone-1.16.3-1.0.2.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 3/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 3/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 4 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Just-Another-Rotten-Flesh-to-Leather-Mod-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 4/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 4/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 5 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Lollipop-Library-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 5/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 5/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 6 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="MrCrayfishs-Vehicle-Mod-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 6/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 6/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 7 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="obfuscate-0.5.0-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 7/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 7/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 8 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Powah-Mod-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 8/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 8/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 9 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="randomite-1.16.3-1.0.1.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 9/10 has successfully been installed! & timeout /t 1 /nobreak > NUL
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 9/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 10 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Xaeros_Minimap_20.26.0_Forge_1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
timeout /t 1 /nobreak > NUL
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 10/10 has successfully been installed! & timeout /t 1 /nobreak > NUL & goto wrapup
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 10/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)

:fastcheck
echo MODS CHECK
echo 1 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="decorative_blocks-1.16.1-1.5.2.jar"
echo Beginning mod filecheck... %time% >> %~dp0\log.srr
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A & echo Mod 1/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 1/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 2 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Golden-Hopper-Mod-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 2/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 2/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 3 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="gravestone-1.16.3-1.0.2.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 3/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 3/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 4 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Just-Another-Rotten-Flesh-to-Leather-Mod-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 4/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 4/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 5 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Lollipop-Library-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 5/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 5/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 6 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="MrCrayfishs-Vehicle-Mod-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 6/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 6/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 7 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="obfuscate-0.5.0-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 7/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 7/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 8 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Powah-Mod-1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 8/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 8/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 9 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="randomite-1.16.3-1.0.1.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 9/10 has successfully been installed!
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 9/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)
echo 10 & color 0B & cls
set Location=%AppData%\.minecraft\mods
set FileName="Xaeros_Minimap_20.26.0_Forge_1.16.3.jar"
echo( & cls
echo( & echo Please wait a moment...  Searching for "%FileName%" on "%Location%"
cls
if exist "%Location%\%FileName%" ( color 0A && echo Mod 10/10 has successfully been installed! & goto wrapup
) else (
    Color 0C & echo Mod is not installed! Please re-run this program and try again! & echo Mod 10/10 did not install correctly... %time% >> %~dp0\log.srr & pause & exit
)

:wrapup
echo END SCREEN & color 0A & cls
echo All mods installed correctly! Wrapping up... %time% >> %~dp0\log.srr
echo All mods installed correctly! & pause & goto pr_end

:skipcheck
cls
echo --- >> %~dp0\log.srr
echo Modcheck skipped. %time% >> %~dp0\log.srr
echo Modcheck skipped. & pause & (goto end)

:skipall
cls
echo --- >> %~dp0\log.srr
echo Everything skipped. %time% >> %~dp0\log.srr
echo Everything skipped.                                                               If this was accidental, please close this window and try again. No files have been copied or modified. & pause & (goto end)

:pr_end
set endLocation=%~dp0
echo Showing completion screen... %time% >> %~dp0\log.srr
cls & color A0
echo                                                                                                                 Installation complete.                                      Open your Minecraft launcher and select the Forge 1.16.5 profile. & echo --- >> %~dp0\log.srr & echo Script folder located at %endLocation% %time% >> %~dp0\log.srr & echo Installation complete and/or skipped. %time% >> %~dp0\log.srr & pause & goto end

:deleteall
echo Awaiting confirmation for deleteall. >> %~dp0\log.srr
cls & color 40
echo                                                                                                                                                                                                                                                                                                                                                 DEVELOPER USE ONLY! CONTINUING WILL DELETE ALL INSTALLED/PRE-EXISTING                            FILES RELATING TO THIS INSTALLATION!                                   If you've reached this screen unintentionally, don't worry.              Closing this window is perfectly fine. Re-running this script should also fix                                 anything amiss.
%SystemRoot%\System32\choice.exe /C Y /N /M "[Press Y to continue]"
if %errorlevel% EQU 1 echo Choice returned a value of 1 (Continue). Deleting... %time% >> %~dp0\log.srr

rd /s /q "%ProgramFiles%\Java\jre1.8.0_291"
echo DIR jre1.8.0_291 DEL
rd /s /q "%AppData%\.minecraft\versions\1.16.5-forge-36.1.0
echo DIR 1.16.5-forge-36.1.0

del /q "%AppData%\.minecraft\mods\decorative_blocks-1.16.1-1.5.2.jar"
echo decorative_blocks-1.16.1-1.5.2.jar DEL
del /q "%AppData%\.minecraft\mods\Golden-Hopper-Mod-1.16.3.jar"
echo Golden-Hopper-Mod-1.16.3.jar DEL
del /q "%AppData%\.minecraft\mods\gravestone-1.16.3-1.0.2.jar"
echo gravestone-1.16.3-1.0.2.jar DEL
del /q "%AppData%\.minecraft\mods\Just-Another-Rotten-Flesh-to-Leather-Mod-1.16.3.jar"
echo Just-Another-Rotten-Flesh-to-Leather-Mod-1.16.3.jar DEL
del /q "%AppData%\.minecraft\mods\Lollipop-Library-1.16.3.jar"
echo Lollipop-Library-1.16.3.jar DEL
del /q "%AppData%\.minecraft\mods\MrCrayfishs-Vehicle-Mod-1.16.3.jar"
echo MrCrayfishs-Vehicle-Mod-1.16.3.jar DEL
del /q "%AppData%\.minecraft\mods\obfuscate-0.5.0-1.16.3.jar"
echo obfuscate-0.5.0-1.16.3.jar DEL
del /q "%AppData%\.minecraft\mods\Powah-Mod-1.16.3.jar"
echo Powah-Mod-1.16.3.jar DEL
del /q "%AppData%\.minecraft\mods\randomite-1.16.3-1.0.1.jar"
echo randomite-1.16.3-1.0.1.jar DEL
del /q "%AppData%\.minecraft\mods\Xaeros_Minimap_20.26.0_Forge_1.16.3.jar"
echo Xaeros_Minimap_20.26.0_Forge_1.16.3.jar DEL

echo Press Y to quit...
%SystemRoot%\System32\choice.exe /C Y0 /N /M "[Press Y to continue]"
if %errorlevel% EQU 1 echo Choice returned a value of 1 (Quit) %time% >> %~dp0\log.srr & (goto end)
if %errorlevel% EQU 2 echo Choice returned a value of 2 (Restart) %time% >> %~dp0\log.srr & echo --- >> %~dp0\log.srr & (goto root)

:end
echo --- >> %~dp0\log.srr
echo Closing... %time% >> %~dp0\log.srr
echo END LOG... %date% %time% >> %~dp0\log.srr
echo SCRIPT END
exit