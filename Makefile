all: secrets pull build
	
# Dumps contents of .secrets into podman secrets, overwriting if needed
secrets:
	for secret in $$(find ./.secrets -mindepth 1); do \
		podman secret create --replace=true $$(basename $$secret) $$secret ; done

# Install the quadlet files to the user directory
install:
	podman quadlet rm -fa
	podman quadlet install */*.container t200-backend.network

# Start the generated systemd services
start:
	for service in $$(find . -mindepth 1 | sed -En 's/^.*\/(.*).container$$/\1 /p'); do \
		systemctl --user start $${service}.service ; done

# Stop all services
stop: 
	for service in $$(find . | sed -En 's/^.*\/(.*).container$$/\1 /p'); do \
		systemctl --user stop $${service}.service ; done

# Stop and remove all images
clean: stop
	podman quadlet rm -fa
	podman system prune -fa

# Image build and pull targets
build:
	for containerfile in $$(find . -mindepth 1 -maxdepth 3 | sed -En '/^.*\/Containerfile$$/p'); do \
		build_dir=$$(dirname $$containerfile) && echo $$build_dir && \
		podman build $${build_dir} -t "t200-$$(basename $${build_dir}):latest"; done

pull: 
	podman pull \
	docker.io/grafana/grafana \
	docker.io/library/eclipse-mosquitto:latest \
	docker.io/timescale/timescaledb:latest-pg18 \
	docker.io/library/nginx:latest
