#!/bin/bash
set -x

# Source the configuration vars
source ./config.sh

BUILD_CMD="podman build"
RUN_PREFIX="RUN"
for var_name in $(cat config.sh | sed -En 's/^export (\S*)=.*$/\1 /p'); do 
        BUILD_CMD="$BUILD_CMD --secret=id=$var_name,env=$var_name"
        RUN_PREFIX="$RUN_PREFIX --mount=type=secret,id=$var_name"
done

rm -f ./buildfile

for build_file in $(find ./build.d -type f | sort); do
        echo "$RUN_PREFIX --mount=type=bind,src=./build.d,dst=./build.d bash $build_file" >> buildfile
done

sh -c "$BUILD_CMD . -f Containerfile.in -t localhost/40ft:latest"