#!/bin/bash
# Set Helper Timestamp Variables
DD=`date +%Y-%m-%d`
DW=`date +%Y%m%d-%H%M%S`

#FTP Login Information
HOST="hostip port"
USER="ftp-username"
PASSWD="ftp-password"

#Backup Source Path
SOURCEFOLDER="/var/www/"
#Temporary Backup Path
FOLDER="/home/backup/$DD"
#Remote Backup Path
REMOTEDIR="/backup/subfolder"

#DO NOT EDIT BELOW
##############################################
# Make Folder Name Using Current Timestamp 
mkdir -p ${FOLDER}
# Change folder to Source Folder
cd $SOURCEFOLDER

# Loop Start
for file in *;
do
FINAMEIND="$file-$DW.tar.gz"
FINAME="$FOLDER/$FINAMEIND"
tar -czvf $FINAME $file
ftp -n -v $HOST << EOT
passive
user $USER $PASSWD
prompt
lcd $FOLDER
cd $REMOTEDIR
pwd
put $FINAMEIND
bye
EOT
# Remove Uploaded Backup File Individually
rm $FINAME 
done
# Loop End

# Remove Temporary Backup Folder
rm -rf $FOLDER
############################################## 
#DO NOT EDIT ABOVE
