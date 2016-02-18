#! /bin/bash

echo Performing obvious updates...
sudo apt-get update
sudo apt-get -y upgrade

echo Installing required packages...
sudo apt-get -y install git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
  libgl1-mesa-dev libxml2-utils xsltproc unzip openjdk-7-jre-headless \
  openjdk-7-jre openjdk-7-jdk

echo Making OS sane...
sudo update-alternatives --config java
sudo update-alternatives --config javac

echo Everything done!
