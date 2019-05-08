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
    $WaitTime = 10
}
# コマンドの入出力を全てログファイルにリダイレクト
Start-Transcript $LogFile
# プロキシを外す
$path = "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
New-ItemProperty -Path $path -Name "ProxyEnable" -Value $true -Propertytype DWord 
# スタートアップに回復プログラムを登録
Copy-Item "launch-remover.lnk" "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
# 回復プログラムをコピー
New-Item $LaunchBase -ItemType Directory -Force
Copy-Item "launch-remover.cmd" $LaunchBase 
Copy-Item "remove-grider.ps1" $LaunchBase 
# ライセンス認証をするよう促すアナウンス
$ws = New-Object -com Wscript.Shell
$ws.Popup("30分以内にライセンス認証を行って下さい。")
Start-Sleep -Seconds $WaitTime
# 入出力のリダイレクト中止
Stop-Transcript

# ＜スタートアップに登録するプログラム＞
# プロキシ再設定
# スタートアップの登録解除
# 回復プログラムを削除

function fff {
    Start-Process .\test.html
}
