@echo off

set scss=.\style.css

if exist %scss% (
    del %scss%
)

@echo on
stylus .\style.styl -c -o .\style.css