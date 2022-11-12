@echo off

set pan=.\public\
set repo=git@blog:yi-Xu-0100/www.yixuju.cn.git
set branch=master
set repogit=.\www.yixuju.cn\
set "repogitinfo=%repogit%.git"
set "pangitinfo=%pan%.git"

:: Clean pubilc directory
if exist %pan% (
    echo "Clean public directory"
    rd /S /Q %pan%
) else (
    echo "Can not find public directory"
)

:: Hugo for new site
echo "Hugo for new site"
hugo

:: Clean pangitinfo
if exist %pangitinfo% (
    echo "Find %pangitinfo% directory and clean it"
    rd /S /Q %pangitinfo%
) else (
    echo "Create empty %pangitinfo%"
    md %pangitinfo%
)

:: Set gitinfo
if exist %repogit% (
    echo "Find %repogit% directory and clean it"
    rd /S /Q %repogit%
)
echo "Git pull lastest gitinfo"
git clone %repo% --depth=1
echo "Move gitinfo to Public"
xcopy /e/y/i/f %repogitinfo% %pangitinfo%
echo "Clean %repogit% directory"
rd /S /Q %repogit%

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