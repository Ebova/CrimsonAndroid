#! /bin/bash

BRANCH=android-6.0.1_r11

echo Performing obvious updates...
sudo apt-get update
sudo apt-get -y upgrade

mkdir -p Crimson
cd Crimson

echo Installing required packages...
sudo apt-get -y install git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
  libgl1-mesa-dev libxml2-utils xsltproc unzip openjdk-7-jre-headless \
  openjdk-7-jre openjdk-7-jdk

echo Making OS sane...
sudo update-alternatives --config java
sudo update-alternatives --config javac

echo Optimizing build environment...
export USE_CCACHE=1
mkdir -p CCACHE
export CCACHE_DIR=$(pwd)/CCACHE

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
