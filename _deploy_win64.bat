set PATH=%PATH%;c:\Qt\5.5\msvc2013_64\bin
cls
windeployqt.exe --release --compiler-runtime --qmldir .. ..\build-bunnyandqloud_qq-5_5_desktop_64bit-Release\release\bunnyandqloud_qq.exe
pause
