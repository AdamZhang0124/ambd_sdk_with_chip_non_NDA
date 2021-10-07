#!/usr/bin/env bash

#   ./build.sh ninja

BUILD_FILE_DIR=`test -d ${0%/*} && cd ${0%/*}; pwd`
CMAKE_ROOT=$BUILD_FILE_DIR/project_hp
LP_IMAGE=$BUILD_FILE_DIR/project_lp/asdk/image
HP_IMAGE=$BUILD_FILE_DIR/project_hp/asdk/image

## Unzip toolchain
cd $CMAKE_ROOT/toolchain
mkdir linux
if [ -z "$(ls -A $CMAKE_ROOT/toolchain/linux)" ]; then
   cat asdk/asdk-9.3.0-linux-newlib-build-3483-x86_64.tar.bz2.part* > asdk/asdk-9.3.0-linux-newlib-build-3483-x86_64.tar.bz2
    tar -jxvf asdk/asdk-9.3.0-linux-newlib-build-3483-x86_64.tar.bz2 -C linux/
    rm asdk/asdk-9.3.0-linux-newlib-build-3483-x86_64.tar.bz2
else
   echo "Toolchain $(ls -A $CMAKE_ROOT/toolchain/linux) is found at $CMAKE_ROOT/toolchain/linux."
fi

##AMEBA_MATTER to be defined in MATTER SDK
if [ ! -z ${AMEBA_MATTER} ]; then
    echo "AMEBA_MATTER is located at: ${AMEBA_MATTER}"
else
    echo "Error: AMEBA_MATTER does not defined."
    exit
fi
export MATTER_CONFIG_PATH=${AMEBA_MATTER}/config/ameba
export MATTER_EXAMPLE_PATH=${AMEBA_MATTER}/examples/all-clusters-app/ameba

cd $AMEBA_MATTER
if [ ! -d "out" ]; then
    mkdir out
fi
cd out

if [ ! -z "$2" ]; then
    mkdir "$2"
    cd "$2"
fi

function exe_cmake()
{
	cmake $CMAKE_ROOT -G"$BUILD_METHOD" -DCMAKE_TOOLCHAIN_FILE=$CMAKE_ROOT/toolchain.cmake
}

if [[ "$1" == "ninja" || "$1" == "Ninja" ]]; then
	BUILD_METHOD="Ninja"
	exe_cmake
	#ninja
else
	BUILD_METHOD="Unix Makefiles"
    exe_cmake
	#make
fi

#if [ -a "$LP_IMAGE/km0_boot_all.bin" ]; then
#    cp $LP_IMAGE/km0_boot_all.bin $AMEBA_MATTER/out/asdk/image/km0_boot_all.bin
#else
#    echo "Error: km0_boot_all.bin can not be found."
#fi

#if [ -a "$HP_IMAGE/km4_boot_all.bin" ]; then
#    cp $HP_IMAGE/km4_boot_all.bin $AMEBA_MATTER/out/asdk/image/km4_boot_all.bin
#else
#    echo "Error: km4_boot_all.bin can not be found."
#fi

