# Stuff on dnf
dnf install -y \
tmux \
firefox \
stow \
mc \
pulseaudio-utils \

# Install dotfiles from repo
(cd /home/$(cat /run/secrets/user) && \
git clone https://github.com/jenkinsjamesb/.dotfiles.git && \
mv .bashrc .bashrc.old && mv .bash_profile .bash_profile.old && \
cd .dotfiles && stow .)

# Run a dbus session for flatpaks 
dnf install -y dbus-daemon
mkdir /run/dbus
dbus-daemon --system

# Install flatpak/flathub
dnf install -y flatpak
echo 15385 > /proc/sys/user/max_user_namespaces
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

dnf install -y dnf-plugins-core

dnf4 -y copr enable ublue-os/flatpak-test
dnf4 -y copr disable ublue-os/flatpak-test
dnf4 -y --repo=copr:copr.fedorainfracloud.org:ublue-os:flatpak-test swap flatpak flatpak
dnf4 -y --repo=copr:copr.fedorainfracloud.org:ublue-os:flatpak-test swap flatpak-libs flatpak-libs
dnf4 -y --repo=copr:copr.fedorainfracloud.org:ublue-os:flatpak-test swap flatpak-session-helper flatpak-session-helper
dnf4 -y --repo=copr:copr.fedorainfracloud.org:ublue-os:flatpak-test install flatpak-debuginfo flatpak-libs-debuginfo flatpak-session-helper-debuginfo

# Install Steam
flatpak install -y flathub com.valvesoftware.Steam

# Install FreeCAD
flatpak install -y flathub org.freecad.FreeCAD