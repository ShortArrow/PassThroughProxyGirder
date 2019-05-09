# ＜スタートアップに登録するプログラム＞

# コマンドの入出力を全てログファイルにリダイレクト
$LogFile = "\\192.168.0.170\supersub\Public Space\Installer【インストーラ】\CAD\CAD AutoDesk\$env:COMPUTERNAME.log"
Start-Transcript $LogFile
$LaunchBase = $env:HOMEDRIVE + "\ProxyGrider"
#レジストリキー
$REGIST_PATH = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
#エントリ名
$ENTRY_NAME = "ProxyEnable"

#レジストリを確認関数
function EntryExists{
    #指定されたキーが存在するか確認
    if(test-path $REGIST_PATH ){
        #キー内の値を取得
        $retReg = (Get-ItemProperty -Path $REGIST_PATH -Name $ENTRY_NAME -ErrorAction SilentlyContinue).$ENTRY_NAME
        if(($retReg -eq $true) -or ($retReg -eq $false)){
            Write-Host ("エントリが既にあります。")
            return $true

        }
        else{
            Write-Host ("エントリが存在しません。作成します。")
            return $false
        }
    }
    else{
        Write-Host "レジストリキーが存在しません。"
        return $false
    }
}

# プロキシ再設定
if (EntryExists) {
    Set-ItemProperty -Path $REGIST_PATH -Name $ENTRY_NAME -Value $true
}
else {
    New-ItemProperty -Path $REGIST_PATH -Name $ENTRY_NAME -Value $true -PropertyType DWord
}
# スタートアップの登録解除
$remove="$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\launch-remover.lnk"
if (Test-Path $remove) {
    Remove-Item $remove
}
# 回復プログラムを削除
if (Test-Path $LaunchBase) {
    Remove-Item -Path "$LaunchBase\*" -Force -Recurse
    # Remove-Item -Path $LaunchBase -Force -Recurse
}
# 時間差
# Start-Sleep -Seconds $WaitTime
# 入出力のリダイレクト中止
Stop-Transcript
# 設定完了アナウンス
$ws = New-Object -com Wscript.Shell
$ws.Popup("ライセンス認証待機状態から復帰しました。",0,"ライセンス認証補助プログラム",0)
