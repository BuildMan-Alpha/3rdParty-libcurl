REM @echo off
REM 
REM Invoke A5BuildlibcURL.bat for all compilers
REM 
REM Note:  The OpenSSL version must be updated in c:\dev\a5v12\srsc\SetBuildEnvironment.bat before each run to build multiple versions of OpenSSL and the respective libSSH2 versions.
REM

if '%1' == '' goto usage

cd c:\dev\3rdParty\libcURL
call A5BuildlibcURL.bat %1 15

cd c:\dev\3rdParty\libcURL
call A5BuildlibcURL.bat %1 16

cd c:\dev\3rdParty\libcURL
call A5BuildlibcURL.bat %1 17

cd c:\dev\3rdParty\libcURL

goto done 

:usage

echo Usage: %0 Version
echo For example:  %0 7.81.0

:done

