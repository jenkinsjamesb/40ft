device="/dev/null"

all: pull build

install:
	podman run \
	--privileged \
	--pid=host \
	-v /dev:/dev \
	-v /var/lib/containers:/var/lib/containers \
	--security-opt label=type:unconfined_t \
	localhost/40ft \
	bootc install to-disk ${device}

# Stop and remove all images
clean:
	podman system prune -fa

# Image build and pull targets
build:
	bash build.sh

pull:
	podman pull quay.io/centos-bootc/centos-bootc:c9s
