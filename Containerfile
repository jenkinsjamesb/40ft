FROM quay.io/centos-bootc/centos-bootc:c10s

ARG USER=user

# Add 
RUN --mount=type=secret,id=password,target=/tmp/password sh -c "passwd ${USER} --stdin < /tmp/passwd && rm /tmp/passwd"



RUN adduser user && 