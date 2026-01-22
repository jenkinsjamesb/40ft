dnf install -y libXft-devel libXinerama-devel fontpackages-devel # dwm prerequisites
dnf install -y git gcc gdb vim # dev tools

dnf groupinstall -y "X Window System"
dnf install -y lightdm open-vm-tools gnome-terminal epel-release


if [ -d dwm ]
then
   rm -rf dwm
fi

git clone https://git.suckless.org/dwm

cd dwm

make
make install
systemctl enable lightdm
