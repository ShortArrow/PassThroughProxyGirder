# ���X�^�[�g�A�b�v�ɓo�^����v���O������

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

# �v���L�V�Đݒ�
if (EntryExists) {
    Set-ItemProperty -Path $REGIST_PATH -Name $ENTRY_NAME -Value $true
}
else {
    New-ItemProperty -Path $REGIST_PATH -Name $ENTRY_NAME -Value $true -PropertyType DWord
}
# �X�^�[�g�A�b�v�̓o�^����
$remove="$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\launch-remover.lnk"
if (Test-Path $remove) {
    Remove-Item $remove
}
# �񕜃v���O�������폜
if (Test-Path $LaunchBase) {
    Remove-Item -Path "$LaunchBase\*" -Force -Recurse
    # Remove-Item -Path $LaunchBase -Force -Recurse
}
# ���ԍ�
# Start-Sleep -Seconds $WaitTime
# ���o�͂̃��_�C���N�g���~
Stop-Transcript
# �ݒ芮���A�i�E���X
$ws = New-Object -com Wscript.Shell
$ws.Popup("���C�Z���X�F�ؑҋ@��Ԃ��畜�A���܂����B",0,"���C�Z���X�F�ؕ⏕�v���O����",0)
