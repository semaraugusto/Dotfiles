#!/usr/bin/env bash


# Semar's modifications on dtos instalation script. Own dotfiles are used

#  ____ _____ ___  ____
# |  _ \_   _/ _ \/ ___|   Derek Taylor (DistroTube)
# | | | || || | | \___ \   http://www.youtube.com/c/DistroTube
# | |_| || || |_| |___) |  http://www.gitlab.com/dwt1/dtos
# |____/ |_| \___/|____/
#
# NAME: DTOS

if [ "$(id -u)" = 0 ]; then
    echo "##################################################################"
    echo "This script MUST NOT be run as root user since it makes changes"
    echo "to the \$HOME directory of the \$USER executing this script."
    echo "The \$HOME directory of the root user is, of course, '/root'."
    echo "We don't want to mess around in there. So run this script as a"
    echo "normal user. You will be asked for a sudo password when necessary."
    echo "##################################################################"
    exit 1
fi

error() { \
    clear; printf "ERROR:\\n%s\\n" "$1" >&2; exit 1;
}

echo "################################################################"
echo "## Syncing the repos and installing 'dialog' if not installed ##"
echo "################################################################"
sudo pacman --noconfirm --needed -Syu dialog || error "Error syncing the repos."

welcome() { \
    dialog --colors --title "\Z7\ZbInstalling DTOS!" --msgbox "\Z4This is a script that will install what I sarcastically call DTOS (DT's operating system).  It's really just an installation script for those that want to try out my XMonad desktop.  We will add DTOS repos to Pacman and install the XMonad tiling window manager, the Xmobar panel, the Alacritty terminal, the Fish shell, Doom Emacs and many other essential programs needed to make my dotfiles work correctly.\\n\\n-DT (Derek Taylor, aka DistroTube)" 16 60

    dialog --colors --title "\Z7\ZbStay near your computer!" --yes-label "Continue" --no-label "Exit" --yesno "\Z4This script is not allowed to be run as root, but you will be asked to enter your sudo password at various points during this installation. This is to give PACMAN the necessary permissions to install the software.  So stay near the computer." 8 60
}

welcome || error "User choose to exit."

lastchance() { \
    dialog --colors --title "\Z7\ZbInstalling DTOS!" --msgbox "\Z4WARNING! The DTOS installation script is currently in public beta testing. There are almost certainly errors in it; therefore, it is strongly recommended that you not install this on production machines. It is recommended that you try this out in either a virtual machine or on a test machine." 16 60

    dialog --colors --title "\Z7\ZbAre You Sure You Want To Do This?" --yes-label "Begin Installation" --no-label "Exit" --yesno "\Z4Shall we begin installing DTOS?" 8 60 || { clear; exit 1; }
}

lastchance || error "User choose to exit."

addrepo() { \
    echo "#########################################################"
    echo "## Adding the DTOS core repository to /etc/pacman.conf ##"
    echo "#########################################################"
    grep -qxF "[dtos-core-repo]" /etc/pacman.conf ||
        (echo "[dtos-core-repo]"; echo "SigLevel = Required DatabaseOptional"; \
        echo "Server = https://gitlab.com/dwt1/\$repo/-/raw/main/\$arch") | sudo tee -a /etc/pacman.conf
}

addrepo || error "Error adding DTOS repo to /etc/pacman.conf."

addkeyserver() { \
    echo "#######################################################"
    echo "## Adding keyservers to /etc/pacman.d/gnupg/gpg.conf ##"
    echo "#######################################################"
    grep -qxF "keyserver.ubuntu.com:80" /etc/pacman.d/gnupg/gpg.conf || echo "keyserver hkp://keyserver.ubuntu.com:80" | sudo tee -a /etc/pacman.d/gnupg/gpg.conf
    grep -qxF "keyserver.ubuntu.com:443" /etc/pacman.d/gnupg/gpg.conf || echo "keyserver hkps://keyserver.ubuntu.com:443" | sudo tee -a /etc/pacman.d/gnupg/gpg.conf
}

addkeyserver || error "Error adding keyservers to /etc/pacman.d/gnupg/gpg.conf"

receive_key() { \
    local _pgpkey="C71486C31555B12E"
    echo "#####################################"
    echo "## Adding PGP key $_pgpkey ##"
    echo "#####################################"
    sudo pacman-key --recv-key $_pgpkey
    sudo pacman-key --lsign-key $_pgpkey
}

receive_key || error "Error receiving PGP key $_pgpkey"

# Let's install each package listed in the pkglist.txt file.
sudo pacman --needed --ask 4 -Sy - < pkglist.txt

echo "################################################################"
echo "## Copying DTOS configuration files from /etc/dtos into \$HOME ##"
echo "################################################################"
[ ! -d /etc/dtos ] && sudo mkdir /etc/dtos
[ -d /etc/dtos ] && mkdir ~/dtos-backup-$(date +%Y.%m.%d-%H%M) && cp -Rf /etc/dtos ~/dtos-backup-$(date +%Y.%m.%d-%H%M)
[ ! -d ~/.config ] && mkdir ~/.config
[ -d ~/.config ] && mkdir ~/.config-backup-$(date +%Y.%m.%d-%H%M) && cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H%M)
cd /etc/dtos && cp -Rf . ~ && cd -

# Change all scripts in .local/bin to be executable.
find $HOME/.local/bin -type f -print0 | xargs -0 chmod 775

[ ! -d /etc/pacman.d/hooks ] && sudo mkdir /etc/pacman.d/hooks
sudo cp /etc/dtos/.xmonad/pacman-hooks/recompile-xmonad.hook /etc/pacman.d/hooks/
sudo cp /etc/dtos/.xmonad/pacman-hooks/recompile-xmonadh.hook /etc/pacman.d/hooks/

[ ! -d $HOME/.config/dmscripts ] && mkdir $HOME/.config/dmscripts
cp /etc/dmscripts/config $HOME/.config/dmscripts/config
sed -i 's/DMBROWSER=\"brave\"/DMBROWSER=\"qutebrowser\"/g' $HOME/.config/dmscripts/config
sed -i 's/DMTERM=\"st -e\"/DMTERM=\"alacritty -e\"/g' $HOME/.config/dmscripts/config
sed -i 's/setbg_dir=\"${HOME}\/Pictures\/Wallpapers\"/setbg_dir=\"\/usr\/share\/backgrounds\/dtos-backgrounds\"/g' $HOME/.config/dmscripts/config

xmonad_recompile() { \
    echo "########################"
    echo "## Recompiling XMonad ##"
    echo "########################"
    xmonad --recompile
}

xmonad_recompile || error "Error recompiling Xmonad!"

xmonadctl_compile() { \
    echo "####################################"
    echo "## Compiling the xmonadctl script ##"
    echo "####################################"
    ghc -dynamic "$HOME"/.xmonad/xmonadctl.hs
}

xmonadctl_compile || error "Error compiling the xmonadctl script!"

PS3='Set default user shell (enter number): '
shells=("fish" "bash" "zsh" "quit")
select choice in "${shells[@]}"; do
    case $choice in
         fish | bash | zsh)
            sudo chsh $USER -s "/bin/$choice" && \
            echo -e "$choice has been set as your default USER shell. \
                    \nLogging out is required for this take effect."
            break
            ;;
         quit)
            echo "User quit without changing shell."
            break
            ;;
         *)
            echo "invalid option $REPLY"
            ;;
    esac
done

# Disable the current login manager
sudo systemctl disable $(grep '/usr/s\?bin' /etc/systemd/system/display-manager.service | awk -F / '{print $NF}') || echo "Cannot disable current display manager."
# Enable sddm as login manager
sudo systemctl enable sddm
echo "###################################"
echo "## Enable sddm as login manager. ##"
echo "###################################"

## Make multicolor-sddm-theme the default sddm theme ##
# This is the sddm system configuration file.
[ -f "/usr/lib/sddm/sddm.conf.d/default.conf" ] && \
    sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /usr/lib/sddm/sddm.conf.d/default.conf.backup && \
    sudo sed -i 's/^Current=*.*/Current=multicolor-sddm-theme/g' /usr/lib/sddm/sddm.conf.d/default.conf

# This is the sddm local configuration file.
[ -f "/etc/sddm.conf" ] && \
    sudo cp /etc/sddm.conf /etc/sddm.conf.backup && \
    sudo sed -i 's/^Current=*.*/Current=multicolor-sddm-theme/g' /etc/sddm.conf

# Create a local configuration file if it doesn't exist.
# Standard Arch Linux does not create this file by default.
[ ! -f "/etc/sddm.conf" ] && \
    sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf || echo "Default sddm system config file is not found."

# ArcoLinux B Awesome uses this config location.
[ -f "/etc/sddm.conf.d/kde_settings.conf" ] && \
    sudo cp /etc/sddm.conf.d/kde_settings.conf /etc/sddm.conf.d/kde_settings.backup && \
    sudo sed -i 's/^Current=*.*/Current=multicolor-sddm-theme/g' /etc/sddm.conf.d/kde_settings.conf

echo "##############################"
echo "## SemarOS has been installed! ##"
echo "##############################"

cd ~/Dotfiles
stow bin
stow nvim
stow st
stow sxiv
stow tmux
stow x11
stow xmobar
stow xmonad
stow zathura
stow zsh

while true; do
    read -p "Do you want to reboot to get your SemarOS? [Y/n] " yn
    case $yn in
        [Yy]* ) reboot;;
        [Nn]* ) break;;
        "" ) reboot;;
        * ) echo "Please answer yes or no.";;
    esac
done
