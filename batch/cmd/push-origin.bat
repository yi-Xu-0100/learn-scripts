@echo off

set commitMessage=%1

echo "git commit and push"
git add --all
if defined commitMessage (
    git commit -m %commitMessage%
) else (
    git commit -m "backup site at %time%"
)
git push origin master -v
pause