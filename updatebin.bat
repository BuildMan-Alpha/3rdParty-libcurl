@echo off
if "%A5_LIBCURL%" == "" goto nothing
set A53RDPARTYBUILD_LIBCURL=%A5BLDROOT%\%A5COMPILERVERSION%\3rdParty\libcurl\
md %A5_LIBCURL%\bin\%A5COMPILERVERSION%
md %A5_LIBCURL%\bin\%A5COMPILERVERSION%\debug
md %A5_LIBCURL%\bin\%A5COMPILERVERSION%\release
for /F "delims=" %%I IN ('dir "%A53RDPARTYBUILD_LIBCURL%build\libcurld.dll" /s /b') DO ( COPY "%%I" %A5_LIBCURL%\bin\%A5COMPILERVERSION%\debug )
for /F "delims=" %%I IN ('dir "%A53RDPARTYBUILD_LIBCURL%build\libcurld.pdb" /s /b') DO ( COPY "%%I" %A5_LIBCURL%\bin\%A5COMPILERVERSION%\debug )
for /F "delims=" %%I IN ('dir "%A53RDPARTYBUILD_LIBCURL%build\libcurld.lib" /s /b') DO ( COPY "%%I" %A5_LIBCURL%\bin\%A5COMPILERVERSION%\debug )
for /F "delims=" %%I IN ('dir "%A53RDPARTYBUILD_LIBCURL%build\curld.exe" /s /b') DO ( COPY "%%I" %A5_LIBCURL%\bin\%A5COMPILERVERSION%\debug )
for /F "delims=" %%I IN ('dir "%A53RDPARTYBUILD_LIBCURL%build\curld.pdb" /s /b') DO ( COPY "%%I" %A5_LIBCURL%\bin\%A5COMPILERVERSION%\debug )
for /F "delims=" %%I IN ('dir "%A53RDPARTYBUILD_LIBCURL%build\libcurl.dll" /s /b') DO ( COPY "%%I" %A5_LIBCURL%\bin\%A5COMPILERVERSION%\release )
for /F "delims=" %%I IN ('dir "%A53RDPARTYBUILD_LIBCURL%build\libcurl.lib" /s /b') DO ( COPY "%%I" %A5_LIBCURL%\bin\%A5COMPILERVERSION%\release )
for /F "delims=" %%I IN ('dir "%A53RDPARTYBUILD_LIBCURL%build\curl.exe" /s /b') DO ( COPY "%%I" %A5_LIBCURL%\bin\%A5COMPILERVERSION%\release )
goto done
:nothing
echo "A5_LIBCURL needs to be defined"
:done