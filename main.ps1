# �R�}���h�̓��o�͂�S�ă��O�t�@�C���Ƀ��_�C���N�g
$LogFile = "\\192.168.0.170\supersub\Public Space\Installer�y�C���X�g�[���z\CAD\CAD AutoDesk\$env:COMPUTERNAME.log"
Start-Transcript $LogFile
$LaunchBase = $env:HOMEDRIVE + "\ProxyGrider"

#���W�X�g���L�[
$REGIST_PATH = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
#�G���g����
$ENTRY_NAME = "ProxyEnable"

#���W�X�g�����m�F�֐�
function EntryExists{
    #�w�肳�ꂽ�L�[�����݂��邩�m�F
    if(test-path $REGIST_PATH ){
        #�L�[���̒l���擾
        $retReg = (Get-ItemProperty -Path $REGIST_PATH -Name $ENTRY_NAME -ErrorAction SilentlyContinue).$ENTRY_NAME
        if(($retReg -eq $true) -or ($retReg -eq $false)){
            Write-Host ("�G���g�������ɂ���܂��B")
            return $true

        }
        else{
            Write-Host ("�G���g�������݂��܂���B�쐬���܂��B")
            return $false
        }
    }
    else{
        Write-Host "���W�X�g���L�[�����݂��܂���B"
        return $false
    }
}

# �v���L�V���O��
if (EntryExists) {
    Remove-ItemProperty -Path $REGIST_PATH -Name $ENTRY_NAME -Force
}
# �X�^�[�g�A�b�v�ɉ񕜃v���O������o�^
Copy-Item "launch-remover.lnk" "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
# �񕜃v���O�������R�s�[
New-Item $LaunchBase -ItemType Directory -Force
Copy-Item "launch-remover.cmd" $LaunchBase 
Copy-Item "remove-grider.ps1" $LaunchBase 

# �J�����g�t�H���_�i�J�����g�f�B���N�g���j�̃p�X���擾
$str_path = (Convert-Path .)

#######################
# IE�N���Ɖ�ʕ\��
#######################
$ie = New-Object -ComObject InternetExplorer.Application  # IE�N��
$ie.Navigate("$str_path\complete.html")                            # URL�w��
$ie.Visible = $true                                       # �\��

# ���o�͂̃��_�C���N�g���~
Stop-Transcript
# ���C�Z���X�F�؂�����悤�����A�i�E���X
#$ws = New-Object -com Wscript.Shell
#$ws.Popup("30���ȓ��Ƀ��C�Z���X�F�؂��s���ĉ������B",0,"���C�Z���X�F�ؕ⏕�v���O����",0)
# Start-Sleep -Seconds $WaitTime

