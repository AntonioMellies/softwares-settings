#!/bin/bash
echo "======================================================================================================";
echo "############# Init - Dev Tools #################";
echo "======================================================================================================";

echo -e "\n";
echo "############## Init - Linux Update ###############";
if `sudo apt-get update -y`
then
   echo "apt-get update is fine!"
else
   echo "apt-get update failed!"
   # exit 1
fi
echo "############## End - Linux Update ###############";

echo -e "\n";
echo "############## Init - Linux Upgrade ###############";
if `sudo apt-get upgrade -y`
then
   echo "apt-get upgrade is fine!"
else
   echo "apt-get upgrade failed!"
   # exit 1
fi
echo "############## End - Linux Upgrade ###############";

echo -e "\n\n";
echo "############## Init - Install sdkman ###############";
curl -s "https://get.sdkman.io" | bash;
source "$HOME/.sdkman/bin/sdkman-init.sh";
echo "sdkman Version";
sdk version;
echo "############## End - Install sdkman ###############";
echo -e "\n\n";


echo "======================================================================================================";
echo "############# End - Dev Tools #################";
echo "======================================================================================================";