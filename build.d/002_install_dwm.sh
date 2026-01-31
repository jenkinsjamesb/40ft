dnf install -y git gcc libX11-devel libX11 libXft-devel libXinerama-devel libXrandr libXrandr-devel fontpackages-devel # dwm prerequisites

dnf groupinstall -y "X Window System"
dnf install -y xorg-x11-server-Xorg xorg-x11-xinit

# Build dwm
rm -rf /tmp/dwm
git clone https://git.suckless.org/dwm /tmp/dwm
(cp /tmp/import/config.h /tmp/dwm) # Copy in config.h
(cd /tmp/dwm && make clean install)

# Build dmenu
rm -rf /tmp/dmenu
git clone https://git.suckless.org/dmenu /tmp/dmenu
(cd /tmp/dmenu && make clean install)

# Build slock
rm -rf /tmp/slock
git clone https://git.suckless.org/slock /tmp/slock
(cd /tmp/slock && make clean install)

# Build st
rm -rf /tmp/st
git clone https://git.suckless.org/st /tmp/st
(cd /tmp/st && make clean install)

# Set profile to start X on login
echo "[[ -z \"\$DISPLAY\" && \$(tty) = /dev/tty1 ]] && startx" > /etc/profile

# Start dwm on startx
echo "exec dwm" > /home/$(cat /run/secrets/user)/.xinitrc # TODO add date to status bar (https://dwm.suckless.org/status_monitor/)
