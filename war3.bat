@echo off
echo ------------------------------------------------------------
echo ------      运行程序之前，请查看你电脑此时分辨率       -----
echo ------           程序运行中需要您手动输入              -----
echo ************************************************************
@pause
echo 请输入分辨率比例宽(width)按回车确认：
set /p width=
echo -----------------------------
echo 请输入分辨率比例高(height)按回车确认：
set /p height=
echo -----------------------------
echo 您输入的分辨率为：%width%*%height%
echo -----------------------------
echo 如果没有错误，
@pause
echo 修改第1项
for /f %%i in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers  /s') do (
REG QUERY %%i /s|find "Scaling"
IF ERRORLEVEL 1 (
  echo 正在查询。。。
) ELSE (
  reg add %%i /v Scaling /t reg_dword /d 3 /f
  echo ---------修改成功！
  goto A
)
)
:A
echo -----------------------------
echo 修改第2项
reg add "HKEY_CURRENT_USER\SOFTWARE\Blizzard Entertainment\Warcraft III\Video" /v "reswidth" /d %width% /t reg_dword /f
echo -----------------------------
goto B
:B
echo 修改第3项
reg add "HKEY_CURRENT_USER\SOFTWARE\Blizzard Entertainment\Warcraft III\Video" /v "resheight" /d %height% /t reg_dword /f
echo -----------------------------
echo 操作完成
echo 按任意键退出
@pause
