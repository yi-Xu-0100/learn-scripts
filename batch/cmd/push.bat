@echo off

set pan=.\public\
set repo=git@blog:yi-Xu-0100/www.yixuju.cn.git
set branch=master
set repogit=.\www.yixuju.cn\
set "pangitinfo=%repogit%.git"
set bakgitinfo=.\static\.git

:: Clean pubilc directory
if exist %pan% (
    echo "Clean public directory"
    rd /S /Q %pan%
) else (
    echo "Can not find public directory"
)

:: Backup gitinfo
if exist %repogit% (
    echo "Find %repogit% directory and clean it"
    rd /S /Q %repogit%
)
echo "Git pull lastest gitinfo"
git clone %repo% --depth=1
echo "Backup gitinfo"
call .\copyDirectory.bat %pangitinfo% %bakgitinfo%
if %Error%==true exit
echo "Clean %repogit% directory"
rd /S /Q %repogit%

:: Hugo for new site
echo "Hugo for new site"
hugo

if exist %pan% (
    cd %pan%
    echo "Git add all and commit"
    if exist .\.git (
    git add --all
    git commit -m "Update site at %time%"
    git push -f origin %branch%:%branch% -v
    ) else (
        echo "Can not find .git directory, git push fail!"
    )
) else (
    echo "Can not find public directory, hugo fail!"
)
pause