


"Step 1: Make a backup"

"Step 2: Upgrade all installed packages & reboot"

sudo apt update
sudo apt list --upgradable
sudo apt upgrade
sudo reboot 

"Step 3: Remove unused old kernel modules"

sudo apt --purge autoremove

"Step 4: Make sure update-manager-core package is installed"

sudo apt install update-manager-core

"Step 5: Upgrade Ubuntu & reboot"

sudo do-release-upgrade # to latest LTS version

sudo do-release-upgrade -d # to latest supported release

sudo reboot


