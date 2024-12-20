REM @echo off

Echo Initializing environment for Alpha Anywhere Builds
Echo ==================================================

cd \dev\3rdparty\libcurl


if '%1' == '' goto usage
if '%2' == '' goto usage

SET CMAKECMD=c:\dev\3rdparty\cmake\3.21.4\bin\cmake.exe
SET LIBCURLVERSION=%1
SET COMPILERVERSIONNUMBER=%2
SET COMPILERVERSION=VS%2

SET LIBCURLPLATFORM=v141
if '%COMPILERVERSIONNUMBER%' == '15' SET COMPILERYEAR=2017
if '%COMPILERVERSIONNUMBER%' == '15' SET LIBCURLPLATFORM=v141
if '%COMPILERVERSIONNUMBER%' == '16' SET COMPILERYEAR=2019
if '%COMPILERVERSIONNUMBER%' == '16' SET LIBCURLPLATFORM=v142
if '%COMPILERVERSIONNUMBER%' == '17' SET COMPILERYEAR=2022
if '%COMPILERVERSIONNUMBER%' == '17' SET LIBCURLPLATFORM=v143

SET VCToolsVersion=

cd \dev\a5v12\src
call SetBuildEnvironment.bat
call SetCompilerEnvironment.bat %COMPILERVERSION%
cd c:\dev\3rdParty\libcurl\%LIBCURLVERSION%

SET PARM=-DCURL_USE_OPENSSL=Y  -DOPENSSL_ROOT_DIR=%A5OPENSSL:\=/% -DOPENSSL_LIBRARIES=%A5OPENSSLLIBS:\=/% -DOPENSSL_INCLUDE_DIR=%A5OPENSSLINCLUDE:\=/%
SET PARM=%PARM% -DCURL_USE_LIBSSH2=Y -DLIBSSH2_LIBRARY=%A5LIBSSH2LIBS:\=/% -DLIBSSH2_INCLUDE_DIR=%A5LIBSSH2:\=/%/include 
SET PARM=%PARM% -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF
SET GPARM=Visual Studio %COMPILERVERSIONNUMBER% %COMPILERYEAR%

cd c:\dev\3rdParty\libcurl\%LIBCURLVERSION%

Echo Cleaning up prior builds
Echo ---------------------------------------------------------------

del CMakeCache.txt

echo y | rd build /s
mkdir build
SET A5CURLBUILDPATH=c:\dev\3rdParty\libcurl\%LIBCURLVERSION%\build
cd %A5CURLBUILDPATH%

Echo Running CMake
Echo ---------------------------------------------------------------
%CMAKECMD% %CRYPTOPARM% %PARM% -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=./dll -G "%GPARM%" -A Win32 ..
ECHO CMake done.  

ECHO Starting Release build
Echo ---------------------------------------------------------------
MSbuild.exe /m /p:UseEnv=true;PlatformToolset=%LIBCURLPLATFORM%;Platform=Win32;buildProjectReferences=false;Configuration="Release";ProcessorArchitecture=x86 lib\libcurl.vcxproj
MSbuild.exe /m /p:UseEnv=true;PlatformToolset=%LIBCURLPLATFORM%;Platform=Win32;buildProjectReferences=false;Configuration="Release";ProcessorArchitecture=x86 src\curl.vcxproj
MSbuild.exe /m /p:UseEnv=true;PlatformToolset=%LIBCURLPLATFORM%;Platform=Win32;buildProjectReferences=false;Configuration="Debug";ProcessorArchitecture=x86 lib\libcurl.vcxproj
MSbuild.exe /m /p:UseEnv=true;PlatformToolset=%LIBCURLPLATFORM%;Platform=Win32;buildProjectReferences=false;Configuration="Debug";ProcessorArchitecture=x86 src\curl.vcxproj

SET A5CURLBINROOT=c:\dev\3rdParty\libcurl\%LIBCURLVERSION%\bin\%A5OPENSSLVER%\%A5COMPILERVERSION%
Echo Copying Files to %A5CURLBINROOT%
Echo ==================================================

xcopy /y "%A5CURLBUILDPATH%\lib\Debug\libcurl-d.dll" 		"%A5CURLBINROOT%\Debug\*.*"
xcopy /y "%A5CURLBUILDPATH%\lib\Debug\libcurl-d.pdb" 		"%A5CURLBINROOT%\Debug\*.*"
xcopy /y "%A5CURLBUILDPATH%\lib\Debug\libcurl-d_imp.lib" 	"%A5CURLBINROOT%\Debug\*.*"
xcopy /y "%A5CURLBUILDPATH%\src\Debug\curl*.exe" 		"%A5CURLBINROOT%\Debug\*.*"
xcopy /y "%A5CURLBUILDPATH%\src\Debug\curl*.pdb" 		"%A5CURLBINROOT%\Debug\*.*"

xcopy /y "%A5CURLBUILDPATH%\lib\Release\libcurl.dll" 		"%A5CURLBINROOT%\Release\*.*"
xcopy /y "%A5CURLBUILDPATH%\lib\Release\libcurl_imp.lib" 	"%A5CURLBINROOT%\Release\*.*"
xcopy /y "%A5CURLBUILDPATH%\src\Release\curl.exe" 		"%A5CURLBINROOT%\Release\*.*"
echo F | xcopy /y "%A5CURLBUILDPATH%\lib\*.h" 			"%A5CURLBINROOT%\include\*.*"

goto done

:done

cd c:\dev\3rdParty\libcurl
