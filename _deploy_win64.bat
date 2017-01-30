set PATH=%PATH%;c:\Qt\5.8\msvc2015_64\bin
cls
windeployqt.exe --release --compiler-runtime --qmldir .. ..\build-bunnyandqloud_qq-Desktop_Qt_5_8_0_MSVC2015_64bit-Release\release\bunnyandqloud_qq.exe
pause
