@echo off

set source=%1
set destination=%2
set "oldDestination=%destination%.old"
set noOld=true

::Determine if the source directory and destination directory exist

if exist %source% (
    echo "Find %source% directory"
) else (
    echo "Error: Can not find %source% directory"
    pause
    set Error=true
)

if exist %destination% (
    echo "Find %destination% directory"
    if exist %oldDestination% (
        echo "Find %oldDestination% directory"
        rd /S /Q %oldDestination%
        echo "clean %oldDestination% directory"
    )
) else (
    echo "Can not find %destination% directory"
    md %destination%
    echo "Create %destination% directory"
)

:: Full copy directory
xcopy /e/y/i/f %source% %destination%

:: noOld
if %noOld%==true (
    if exist %oldDestination% (
        echo "Find %oldDestination% directory"
        rd /S /Q %oldDestination%
        echo "clean %oldDestination% directory"
    )
) else (
    xcopy /e/y/i/f %destination% %oldDestination%
)

set Error=false