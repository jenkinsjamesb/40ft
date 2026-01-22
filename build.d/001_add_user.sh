useradd --create-home --shell /bin/bash $(cat /run/secrets/user)
usermod --append -G wheel $(cat /run/secrets/user)
echo "$(cat /run/secrets/user):$(cat /run/secrets/pass)" | chpasswd
