@echo off

cd \dev\a5v12\src
call SetBuildEnvironment.bat
cd \dev\3rdparty\libcurl
call stage.bat


SET LIBSSHSOLUTION=%A53RDPARTYBUILD_LIBSSH%win32\libssh2.sln
SET LIBSSHPROJECT=%A53RDPARTYBUILD_LIBSSH%win32\libssh2.vcxproj
start /B /WAIT devenv %LIBSSHSOLUTION% /upgrade
start /B /WAIT MSbuild.exe /m /p:UseEnv=true;Configuration="LIB Release";Platform=Win32 %LIBSSHPROJECT%
start /B /WAIT MSbuild.exe /m /p:UseEnv=true;Configuration="LIB Debug";Platform=Win32 %LIBSSHPROJECT%

SET LIBCURLSOLUTION=%A53RDPARTYBUILD_LIBCURL%projects\Windows\VC15\lib\libcurl.sln
start /B /WAIT devenv %LIBCURLSOLUTION% /upgrade
start /B /WAIT MSbuild.exe /m /p:UseEnv=true;Configuration="DLL Release - DLL OpenSSL - DLL LibSSH2";Platform=Win32 %LIBCURLSOLUTION%
start /B /WAIT MSbuild.exe /m /p:UseEnv=true;Configuration="DLL Debug - DLL OpenSSL - DLL LibSSH2";Platform=Win32 %LIBCURLSOLUTION%


SET CURLSOLUTION=%A53RDPARTYBUILD_LIBCURL%projects\Windows\VC15\src\curl.sln
start /B /WAIT devenv %LIBCURLSOLUTION% /upgrade
start /B /WAIT MSbuild.exe /m /p:UseEnv=true;Configuration="DLL Release - DLL OpenSSL - DLL LibSSH2";Platform=Win32 %CURLSOLUTION%
start /B /WAIT MSbuild.exe /m /p:UseEnv=true;Configuration="DLL Debug - DLL OpenSSL - DLL LibSSH2";Platform=Win32 %CURLSOLUTION%
cd \dev\3rdParty\libcurl
call updatebin.bat
