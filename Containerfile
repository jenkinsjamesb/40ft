FROM quay.io/centos-bootc/centos-bootc:c9s

ARG USER=user

# Add user from build arg as sudoer
RUN --mount=type=secret,id=40ft_password adduser ${USER} && usermod --append -G wheel ${USER} && passwd ${USER} --stdin < /run/secrets/40ft_password

RUN dnf config-manager --set-enabled crb && sudo dnf install -y epel-release

RUN dnf install -y tmux lightdm
