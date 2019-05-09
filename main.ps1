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

# プロキシを外す
if (EntryExists) {
    Remove-ItemProperty -Path $REGIST_PATH -Name $ENTRY_NAME -Force
}
# スタートアップに回復プログラムを登録
Copy-Item "launch-remover.lnk" "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
# 回復プログラムをコピー
New-Item $LaunchBase -ItemType Directory -Force
Copy-Item "launch-remover.cmd" $LaunchBase 
Copy-Item "remove-grider.ps1" $LaunchBase 

# カレントフォルダ（カレントディレクトリ）のパスを取得
$str_path = (Convert-Path .)

#######################
# IE起動と画面表示
#######################
$ie = New-Object -ComObject InternetExplorer.Application  # IE起動
$ie.Navigate("$str_path\complete.html")                            # URL指定
$ie.Visible = $true                                       # 表示

# 入出力のリダイレクト中止
Stop-Transcript
# ライセンス認証をするよう促すアナウンス
#$ws = New-Object -com Wscript.Shell
#$ws.Popup("30分以内にライセンス認証を行って下さい。",0,"ライセンス認証補助プログラム",0)
# Start-Sleep -Seconds $WaitTime

