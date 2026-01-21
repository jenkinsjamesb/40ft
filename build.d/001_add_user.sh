set -x
ls /run/secrets
cat /run/secrets/pass
adduser $(cat /run/secrets/user)
usermod --append -G wheel $(cat /run/secrets/user)
passwd $(cat /run/secrets/user) --stdin < /run/secrets/pass