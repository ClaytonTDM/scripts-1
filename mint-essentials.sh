#!/bin/bash

sudo echo "sudo"
(
# =================================================================
echo "# Installing Brave Browser..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg;
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list;
sudo apt-get update > /dev/null;
sudo apt-get install brave-browser -y > /dev/null;

# =================================================================
echo "# Installing GrapeJuice..."
curl -s https://gitlab.com/brinkervii/grapejuice/-/raw/master/ci_scripts/signing_keys/public_key.gpg | sudo tee /usr/share/keyrings/grapejuice-archive-keyring.gpg  > /dev/null;
sudo tee /etc/apt/sources.list.d/grapejuice.list <<< 'deb [signed-by=/usr/share/keyrings/grapejuice-archive-keyring.gpg] https://brinkervii.gitlab.io/grapejuice/repositories/debian/ universal main';
sudo apt-get update > /dev/null;
sudo apt-get install grapejuice -y > /dev/null;

# =================================================================
echo "# Installing Wine..."
sudo mkdir -pm755 /etc/apt/keyrings > /dev/null;
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key > /dev/null;
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources > /dev/null;
sudo apt-get update > /dev/null;
sudo apt-get install --install-recommends winehq-stable -y > /dev/null;

# =================================================================
echo "# Installing QEMU..."
sudo apt install qemu-kvm virt-manager virtinst libvirt-clients bridge-utils libvirt-daemon-system -y > /dev/null;
sudo systemctl enable --now libvirtd > /dev/null;
sudo systemctl start libvirtd > /dev/null;
sudo usermod -aG kvm $USER > /dev/null;
sudo usermod -aG libvirt $USER > /dev/null;

# =================================================================
echo "# Installing Git..."
sudo apt-get install git -y > /dev/null;

# =================================================================
echo "# Installing Spotify..."
sudo apt-get install spotify-client -y > /dev/null;

# =================================================================
echo "# Installing OBS Studio..."
sudo add-apt-repository ppa:obsproject/obs-studio -y > /dev/null;
sudo apt update > /dev/null;
sudo apt install ffmpeg obs-studio -y > /dev/null;

# =================================================================
echo "# Installing VSCodium..."
wget https://github.com/VSCodium/vscodium/releases/download/1.77.3.23102/codium_1.77.3.23102_arm64.deb > /dev/null;
sudo apt-get install ./codium_1.77.2.23101_amd64.deb -y > /dev/null;

# =================================================================
echo "# Installing Discord..."
wget https://dl.discordapp.net/apps/linux/0.0.26/discord-0.0.26.deb > /dev/null;
sudo apt-get install ./discord-0.0.26.deb -y > /dev/null;

# =================================================================
echo "# Installing Steam..."
sudo apt-get install steam -y > /dev/null;

# =================================================================
echo "# Installing BalenaEtcher"
curl -1sLf \
   'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
   | sudo -E bash
sudo apt-get update
sudo apt-get install balena-etcher-electron
# =================================================================
echo "# Cleaning Up..."
sudo apt-get install -f > /dev/null;
sudo apt-get autoremove -y > /dev/null;
sudo rm -rf ./discord-0.0.26.deb > /dev/null;

# =================================================================
echo "Done! Please wait..."


) |
zenity --progress \
  --title="Mint Essentials" \
  --text="Preparing..." \
  --percentage=0 \
  --auto-close \
  --auto-kill

(( $? != 0 )) && zenity --error --text="An error has occurred."
zenity --info --text="All programs supported by your system have been installed. Thank you for using Mint Essentials." --title="Mint Essentials"
