#!/bin/bash
#Criado por Gledson Luiz 
#Objetivo verificar se foi criado backup na unidade remota.

#CONST
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

main(){

mesAtual=$(date +%m)
diaAtual=$(date +%d)
STARTDATE=$(date +"%Y-%m-%d %H:%M:%S")

PATH=${PATH}:/Users/admin/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Server.app/Contents/ServerRoot/usr/bin:/Applications/Server.app/Contents/ServerRoot/usr/sbin:/Users/admin/.rbenv/bin
SMB_SERVER="//usuario:senha@10.243.124.23/GitLab"
DCBKPFILEPATH=/var/opt/gitlab/backups
BKPFILEPATH=/Users/admin/Desktop/docker/backups/gitlab/mobile
SMBSHAREPATH=/Users/admin/Desktop/docker/backups/share/BackupGIT
SMBBKPPATH=/Users/admin/Desktop/docker/backups/share/BackupGIT/mobile/gitlab

echo -e "\n ============================================================== \n"
echo -e "${GREEN} Verifica backup Gitlab $STARTDATE ${NC} \n"
echo -e "================================================================= \n"

echo -e "=================================================================\n"
echo -e "${GREEN} Montando unidade remota em 10.243.124.23/GitLab $NC \n"
echo -e "=================================================================\n"

sudo mount_smbfs ${SMB_SERVER} ${SMBSHAREPATH}

files_count=$(sudo find $SMBSHAREPATH/mobile/gitlab -name "*.tar" | wc -l)

if [ ${files_count} -ge ${diaAtual} ]; then
	echo -en "${GREEN} Numero de arquivos ${files_count} > = ${diaAtual} - OK  ${NC} \n\n"
else 
    echo -en "${RED} ${files_count} arquivos encontrados, o esperado eram: ${diaAtual} ${NC} \n\n "
fi

#Umounting
echo -e "=================================================================\n"
echo -e "${GREEN} Desmontando unidade remota ${SMBSHAREPATH} ${NC} \n"
echo -e "=================================================================\n"

sudo diskutil unmountdisk ${SMBSHAREPATH}

echo -e "=================================================================\n"
echo -en "${GREEN} Fim da Verificacao do backup Gitlab ${NC} \n"
echo -e "=================================================================\n"

}
main



