#!/bin/bash
#Version = 0.5
#Autor = flutterbrony
#date = 19/08/2015

####################
#                  #
# LISCENCE : GPLV2 #
#                  #
####################

########
# Help #
########

function usage(){
printf "How to use the Backup script :\n"
printf "\t-u    --username               : Your username for Mega.\n"
printf "\t-p    --password               : Your password for your Mega account.\n"
printf "\t-i    --include                : include the specified directory.\n"
printf "\t-e    --exclude                : exclude the specified directory.\n"
printf "\t-h    --help                   : Display this message.\n"
printf "\tA little exemple of the use :\n"
printf "\tBackup -u Mega@mail.com -p 'my very secret password' --include /home/me --include /home/mybrother --exclude /var/cache\n"
}

###########
# Options #
###########

OPTS=$( getopt -o h,u:,p:,i:,e: -l help,username:,password:,include:,exclude: -- "$@" )

if [ $? != 0 ]
then
    exit 1
fi

eval set -- "$OPTS"

while true ; do
    case "$1" in
        -h) usage;
            exit 0;;
        -u) username=$2;
                shift ;;
        -p) password=$4;
                shift;;
        -i) include_dir=$6;
                shift;;
        -e) exclude_dir=` --exclude $8`;
                shift;;
        --help) usage;
            exit 0;;
        --username) username=$2;
                 shift;;
        --password) password=$4;
                 shift;;
        --include) include_dir=$6;
                shift;;
        --exclude) exclude_dir=`--exclude $8`;
                shift;;
        --) shift; break;;
    esac
        break;
done

##########
# Script #
##########

format_date=`date +'%d-%m-%Y'`;
printf "\tBackuping\n";
tar cvz /var /etc $include_dir $exclude_dir > Backup-$format_date.tar;
printf "\tsending Backup to your  Mega Account\n";
megaput -u $username -p $password Backup-$format_date.tar;
printf "\tcleaning cache\n";
rm Backup$format_date.tar;
echo 'success !';
exit 0;
