@echo off

if "%A5_LIBCURL%" == "" goto nothing
set A53RDPARTYBUILD_LIBSSH2=%A5LIBSSH2%\
set A53RDPARTYBUILD_LIBCURL=%A5BLDROOT%\%A5COMPILERVERSION%\3rdParty\libcurl\
xcopy "%A5_LIBSSH%" "%A53RDPARTYBUILD_LIBSSH%" /s /y
xcopy "%A5_LIBCURL%" "%A53RDPARTYBUILD_LIBCURL%" /s /y
cd %A53RDPARTYBUILD_LIBCURL%
rem Hack the VCXPROJ files to point at our paths 
\dev\a5v12\src\BuildTools\fart -s "%A53RDPARTYBUILD_LIBCURL%*.vcxproj" "..\..\..\..\..\openssl\inc32" "$(A5OPENSSL)\include"
\dev\a5v12\src\BuildTools\fart -s "%A53RDPARTYBUILD_LIBCURL%*.vcxproj" "..\..\..\..\..\libssh2" "$(A5LIBSSH2)"
\dev\a5v12\src\BuildTools\fart -s "%A53RDPARTYBUILD_LIBCURL%*.vcxproj" ";libeay32.lib" ";$(A5OPENSSL)\out32dll\$(A5COMPILERVERSION)\libcrypto.lib"
\dev\a5v12\src\BuildTools\fart -s "%A53RDPARTYBUILD_LIBCURL%*.vcxproj" ";ssleay32.lib" ";$(A5OPENSSL)\out32dll\$(A5COMPILERVERSION)\libssl.lib"
\dev\a5v12\src\BuildTools\fart -s "%A53RDPARTYBUILD_LIBCURL%*.vcxproj" ";libssh2.lib" ";$(A5LIBSSH2)\dll\$(A5COMPILERVERSION)\$(A5BLDTYPE)\libssh2.lib"
\dev\a5v12\src\BuildTools\fart -s "%A53RDPARTYBUILD_LIBCURL%*.vcxproj" ";libssh2d.lib" ";$(A5LIBSSH2)\dll\$(A5COMPILERVERSION)\$(A5BLDTYPE)\libssh2.lib"
echo "%A5_LIBCURL% and require LIBSSH source files have been staged to build location" 
goto done
:nothing
echo "A5_LIBCURL needs to be defined"
:done