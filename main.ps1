$LogFile = "\\192.168.0.170\supersub\Public Space\Installer【インストーラ】\CAD\CAD AutoDesk\$env:COMPUTERNAME.log"
$LaunchBase = $env:HOMEDRIVE + "\ProxyGrider"
param (
    [switch]$Debug # オプション
)
Get-Date | Out-File -LiteralPath $LogFile -Append -Force
if ($Debug) {
    $WaitTime = 5
}
else {
    $WaitTime = 900
}

# プロキシを外す
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f /v ProxyEnable /t reg_dword /d 1
# スタートアップに回復プログラムを登録
Copy-Item "launch.lnk" "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
# 回復プログラムをコピー
New-Item $LaunchBase  -ItemType Directory -Force
Copy-Item "launch.cmd" $LaunchBase 
Copy-Item "reverse-proxy.ps1" $LaunchBase 
Copy-Item "set-proxy.ps1" $LaunchBase 
# ライセンス認証をするよう促すアナウンス
$ws = New-Object -com Wscript.Shell
$ws.Popup("30分以内にライセンス認証を行って下さい。")

# ＜スタートアップに登録するプログラム＞
# プロキシ再設定
# スタートアップの登録解除
# 回復プログラムを削除

Start-Sleep -Seconds ($WaitTime / $Split)

function fff {
    Start-Process .\test.html
}
