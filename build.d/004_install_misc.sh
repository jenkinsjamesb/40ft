# Stuff on dnf
dnf install -y \
tmux \
firefox \
stow \
mc

# Install dotfiles from repo
(cd /home/$(cat /run/secrets/user) && \
git clone https://github.com/jenkinsjamesb/.dotfiles.git && \
mv .bashrc .bashrc.old && mv .bash_profile .bash_profile.old && \
cd .dotfiles && stow .)

# Install Flatpak and flathub
dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Steam
flatpak install -y flathub com.valvesoftware.Steam

# Install FreeCAD
flatpak install -y flathub org.freecad.FreeCAD