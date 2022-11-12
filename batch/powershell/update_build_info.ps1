$logPath = $(Split-Path -Parent $MyInvocation.MyCommand.Definition) + "\log.txt"
echo "`$logPath=$logPath"
$CurrentBuildNumber = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | select-object CurrentBuildNumber).CurrentBuildNumber
echo "`$CurrentBuildNumber=$CurrentBuildNumber" >> $logPath
$InstalledOn = ((get-wmiobject -class win32_quickfixengineering).InstalledOn | sort | select -last 1 | get-date -format "yyMMdd")
echo "`$InstalledOn=$InstalledOn" >> $logPath
$UBR = ((Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | select-object UBR).UBR).toString()
echo "`$UBR=$UBR" >> $logPath
$OldBuildLab = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | select-object OldBuildLab).OldBuildLab
echo "`$OldBuildLab=$OldBuildLab" > $logPath
if($OldBuildLab -and $($OldBuildLab -match '\.(?<OldInstalledOn>\d+)-\d+\((?<OldCount>\d+)\)')) {
  $OldInstalledOn = $Matches.OldInstalledOn
  echo "`$OldInstalledOn=$OldInstalledOn" >> $logPath
  if($OldInstalledOn -ne $InstalledOn) {
    $OldCount = "0"
  } else {
    $OldCount = $Matches.OldCount
  }
  echo "`$OldCount=$OldCount" >> $logPath
}
$Count = "($(1+$oldCount))"
echo "`$Count=$Count" >> $logPath
$newBuildLab = $CurrentBuildNumber + ".self_upgrade." + $InstalledOn + "-" + $UBR + $Count
echo "`$newBuildLab=$newBuildLab" >> $logPath
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  /v BaseBuildRevisionNumber /t reg_dword /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  /v BuildLab /t reg_sz /d $newBuildLab /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  /v OldBuildLab /t reg_sz /d $newBuildLab /f

exit 0