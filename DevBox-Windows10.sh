printf '\nFree up space ... \n'
rm -rf "VirtualBox VMs"
echo Done.
rm -rf "applications"
echo Done.
rm -rf "coding"
echo Done.
rm -rf "Downloads"
echo Done.
rm -rf "pycharm"
echo Done.
rm -rf "vagrant"
echo Done.
clear
printf '\nVisit https://dashboard.ngrok.com/get-started/setup and Copy the authtoken \n'
read -p "Paste authtoken here (Copy and Right-click to paste): " CRP
printf '\nDownloading NGROK... \n'
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && unzip *.zip
wget https://raw.githubusercontent.com/Fiate/WINDOWSRDP/main/ngrok-choice-linux.sh
./ngrok authtoken $CRP
clear
chmod +x ngrok-choice-linux.sh
./ngrok-choice-linux.sh
mkdir W10
cd W10
wget -O W10.vhd https://app.vagrantup.com/thuonghai2711/boxes/W2012DevBox/versions/1.0.0/providers/virtualboxw10.box
clear
VBoxManage createvm --name W10 --ostype Windows10_64 --register --basefolder `pwd` 
VBoxManage modifyvm W10 --ioapic on 
VBoxManage modifyvm W10 --memory 12288 --vram 256 --cpus 8
VBoxManage modifyvm W10 --nic1 nat 
VBoxManage modifyvm W10 --natpf1 "rdp,tcp,,33899,,3389"
vboxmanage storagectl W10 --name "SATA Controller" --add sata --controller IntelAHCI --portcount 1 --bootable on
vboxmanage storageattach W10 --storagectl "SATA Controller" --device 0 --port 0 --type hdd --medium /home/developer/W10/W10.vhd
VBoxManage startvm "W10" --type headless
clear
echo All done! Connect your VM using RDP.
echo IP:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo User: Administrator
echo Pass: S@ad.m02
echo Finished! You can Close PUTTY now.






