#!/bin/bash
sudo apt update
sudo apt install net-tools
sudo apt install git
sudo apt install chromium
sudo apt install build-essential
sudo apt install cmake
sudo apt install ninja-build
sudo apt install libusb-1.0-0-dev
sudo apt install gcc-arm-none-eabi

git clone https://github.com/micropython/micropython.git
git clone https://github.com/v923z/micropython-ulab.git ulab

cd micropython
git submodule update --init lib/tinyusb
git submodule update --init lib/pico-sdk
cd lib/pico-sdk
git submodule update --init lib/tinyusb

cd ../..
make -C mpy-cross
cd ports/rp2
make BOARD=RPI_PICO2 submodules
make BOARD=RPI_PICO2 clean
make BOARD=RPI_PICO2 USER_C_MODULES=../../../ulab/code/micropython.cmake
