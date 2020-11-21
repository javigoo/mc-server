@echo off

rem Obtener directorio de descargas

	setlocal EnableExtensions DisableDelayedExpansion

	set "Reg32=%SystemRoot%\System32\reg.exe"
	if not "%ProgramFiles(x86)%" == "" set "Reg32=%SystemRoot%\SysWOW64\reg.exe"

	set "DownloadShellFolder="
	for /F "skip=1 tokens=1,2*" %%T in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" 2^>nul') do (
	    if /I "%%T" == "{374DE290-123F-4565-9164-39C4925E467B}" (
	        set "DownloadShellFolder=%%V"
	        goto GetDownloadDirectory
	    )
	)

	:GetDownloadDirectory
	set "DownloadDirectory="
	for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer" /v "Download Directory" 2^>nul') do (
	    if /I "%%S" == "Download" (
	        if /I "%%T" == "Directory" (
	            set "DownloadDirectory=%%V"
	            goto GetSaveDirectory
	        )
	    )
	)

	:GetSaveDirectory
	set "SaveDirectory="
	for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Save Directory" 2^>nul') do (
	    if /I "%%S" == "Save" (
	        if /I "%%T" == "Directory" (
	            set "SaveDirectory=%%V"
	            if "%DownloadShellFolder:~-1%" == "\" set "DownloadShellFolder=%DownloadShellFolder:~0,-1%"
	            rem Directorio de descargas -> %DownloadShellFolder%
	            goto DeleteMods
	        )
	    )
	)


rem Obtener directorio .minecraft

	:DeleteMods
	if "%APPDATA%" == "" goto NOPATH
	   :YESPATH   
	   set "minecraftPath=%APPDATA%\.minecraft\mods"
	   goto END
	   :NOPATH
	   echo Error: APPDATA environment variable was not detected.
	   goto END
	   :END

rem Actualizar mods .minecraft

	rem Eliminar versiones anteriores
	del %DownloadShellFolder%\mods-actualization* /F /Q 2>NUL
	del %minecraftPath% /F /Q

	echo Updating mods ...

	rem Descargar nueva version
	start /B https://www.dropbox.com/sh/ar3mh1171g10ipx/AADT3Q2nC25bX7EqLAYpMCZsa?dl=1
	
	:while
	if exist "%DownloadShellFolder%\mods-actualization.zip" (
		Call :UnZipFile "%minecraftPath%" "%DownloadShellFolder%\mods-actualization.zip"
	) else (
		goto while
	)

rem Descomprimir 

	:UnZipFile <ExtractTo> <newzipfile> 
	set vbs="%temp%\_.vbs" 
	if exist %vbs% del /f /q %vbs% 
	>%vbs% echo Set fso = CreateObject("Scripting.FileSystemObject") 
	>>%vbs% echo If NOT fso.FolderExists(%1) Then 
	>>%vbs% echo fso.CreateFolder(%1) 
	>>%vbs% echo End If 
	>>%vbs% echo set objShell = CreateObject("Shell.Application") 
	>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items 
	>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip) 
	>>%vbs% echo Set fso = Nothing 
	>>%vbs% echo Set objShell = Nothing 
	cscript //nologo %vbs% 
	if exist %vbs% del /f /q %vbs%

exit