all: secret pull build

# Dumps contents of .secrets into podman secrets, overwriting if needed
secret:
	for secret in $$(find ./.secrets -mindepth 1); do \
		podman secret create --replace=true $$(basename $$secret) $$secret ; done

install:
	podman run \
	--privileged \
	--pid=host \
	-v /dev:/dev \
	-v /var/lib/containers:/var/lib/containers \
	--security-opt label=type:unconfined_t \
	localhost/40ft \
	bootc install to-disk /path/to/disk

# Stop and remove all images
clean:
	podman system prune -fa

# Image build and pull targets
build:
	./build.sh
	podman build . --secret src=.secrets/40ft_password -t localhost/40ft:latest

pull:
	podman pull quay.io/centos-bootc/centos-bootc:c9s
