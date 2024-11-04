#!/bin/bash

################### STATUS VARIABLES ################### 
UPDATE_STATUS=1;
UPGRADE_STATUS=;
SDKMAN_STATUS=1;
NVM_STATUS=1;
POSTMAN_STATUS=1;
DOCKER_STATUS=1;
PORTAINER_STATUS=1;
TLDR_STATUS=1;
FLAMESHOT_STATUS=1;
TERMINATOR_STATUS=1;
BASHTOP_STATUS=1;


echo "======================================================================================================";
echo "############# Init - System #################";
echo "======================================================================================================";
echo -e "\n";

echo "############## Init - Linux Update ###############";
sudo apt-get update -y;
UPGRADE_STATUS=$?;
if [ $UPDATE_STATUS == 0 ]
then
   echo "apt-get update is fine!"
else
   echo "apt-get update failed!"
fi
echo "############## End - Linux Update ###############";
echo -e "\n";

echo "############## Init - Linux Upgrade ###############";
sudo apt-get upgrade -f -y;
UPGRADE_STATUS=$?;
if [ $UPGRADE_STATUS == 0 ]
then
   echo "apt-get upgrade is fine!"
else
   echo "apt-get upgrade failed!"
fi
echo "############## End - Linux Upgrade ###############";
echo -e "\n\n";

echo "======================================================================================================";
echo "############# End - System #################";
echo "======================================================================================================";
echo -e "\n";

echo "======================================================================================================";
echo "############# Init - Dev Tools #################";
echo "======================================================================================================";
echo -e "\n";

echo "############## Init - Install sdkman ###############";
curl -s "https://get.sdkman.io" | bash;
SDKMAN_STATUS=$?;
source "$HOME/.sdkman/bin/sdkman-init.sh";
SDKMAN_STATUS=$?;
echo "############## End - Install sdkman ###############";
echo -e "\n\n";

echo "############## Init - Install nvm ###############";
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash;
NVM_STATUS=$?;
echo "############## End - Install nvm ###############";
echo -e "\n\n";

echo "############## Init - Install Postman ###############";
curl -o- "https://dl-cli.pstmn.io/install/linux64.sh" | sh;
POSTMAN_STATUS=$?;
echo "############## End - Install Postman ###############";
echo -e "\n\n";

echo "############## Init - Install Docker ###############";
curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh;
DOCKER_STATUS=$?;
rm get-docker.sh;
echo "### Configure docker permission #######";
sudo usermod -aG docker $USER
su -l $USER
echo "############## End - Install Docker ###############";
echo -e "\n\n"

echo "############## Init - Install Portainer ###############";
docker volume create portainer_data;
docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest;
PORTAINER_STATUS=$?;
echo "############## End - Install Portainer ###############";
echo -e "\n\n"

echo "======================================================================================================";
echo "############# End - Dev Tools #################";
echo "======================================================================================================";
echo -e "\n\n";

echo "======================================================================================================";
echo "############# Init - Environment #################";
echo "======================================================================================================";
echo -e "\n";

echo "############## Init - Install tldr ###############";
sudo apt install tldr;
TLDR_STATUS=$?;
echo "############## End - Install tldr ###############";
echo -e "\n\n";

echo "############## Init - Install flameshot ###############";
sudo apt-get install flameshot;
FLAMESHOT_STATUS=$?;
echo "############## End - Install flameshot ###############";
echo -e "\n\n";

# echo "############## Init - Install bashtop ###############";
# sudo add-apt-repository ppa:bashtop-monitor/bashtop -y;
# BASHTOP_STATUS=$?;
# sudo apt update -y;
# BASHTOP_STATUS=$?;
# sudo apt install bashtop -y;
# BASHTOP_STATUS=$?;
# echo "############## End - Install bashtop ###############";
# echo -e "\n\n";

echo "############## Init - Install terminator ###############";
sudo add-apt-repository ppa:gnome-terminator -y;
sudo apt-get install terminator -y;
TERMINATOR_STATUS=$?;
echo "############## End - Install terminator ###############";
echo -e "\n\n";


echo "======================================================================================================";
echo "############# End - Environment #################";
echo "======================================================================================================";
echo -e "\n\n";


echo "======================================================================================================";
echo "############# CheckList #################";
echo "======================================================================================================";
OK_MARK=✅;
ERROR_MARK=❌;

print_status() {
   status=''
   if [ $2 -eq 0 ];
   then
      status=$OK_MARK; 
   else
      status=$ERROR_MARK;
   fi
   echo -e "Status $1: \t $status";
}


echo -e "\n---- System ---- "
print_status "update" $UPDATE_STATUS
print_status "upgrade" $UPGRADE_STATUS

echo -e "\n ---- Dev Tools ---- ";
print_status "sdkman" $SDKMAN_STATUS
print_status "nvm" $NVM_STATUS
print_status "postman" $POSTMAN_STATUS
print_status "docker" $DOCKER_STATUS
print_status "portainer" $PORTAINER_STATUS

echo -e "\n ---- Environment ---- ";
print_status "tldr" $TLDR_STATUS
print_status "flameshot" $FLAMESHOT_STATUS
print_status "bashtop" $BASHTOP_STATUS
print_status "terminator" $TERMINATOR_STATUS

