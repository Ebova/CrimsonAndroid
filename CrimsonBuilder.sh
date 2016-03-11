#! /bin/bash

BRANCH=android-6.0.1_r17
VERSION="Crimson Codename Martian"

mkdir -p Crimson
cd Crimson

echo Optimizing build environment...
export USE_CCACHE=1
mkdir -p CCACHE
export CCACHE_DIR=$(pwd)/CCACHE
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre"
#export PLATFORM_VERSION_CODENAME=$VERSION

echo Creating basic structures...
mkdir -p build/bin
export PATH=$(pwd)/build/bin:$PATH
wget https://storage.googleapis.com/git-repo-downloads/repo -O build/bin/repo
chmod +x build/bin/repo
mkdir -p build/WORKING_DIRECTORY

echo ----------------------------
echo Environment setup complete.
echo ----------------------------
echo Entering working directory...
cd build/WORKING_DIRECTORY

echo Checking out...
repo init -u https://android.googlesource.com/platform/manifest -b $BRANCH
repo sync

echo Setting up ccache...
prebuilts/misc/linux-x86/ccache/ccache -M 50G

echo --------------------------
echo Source download completed.
echo --------------------------

echo Setting target device specific data...
source build/envsetup.sh
source ../../../DevSetup
#export PLATFORM_VERSION_CODENAME=$VERSION

echo Patching Crimson mods...

source ../../../Patches

echo -------------------------------------
echo Patching complete. Starting to build.
echo -------------------------------------

make -j4

echo -----------------------------------------------
echo Done compiling. Executing post compile scripts.
echo -----------------------------------------------

source ../../../POST_COMPILE
