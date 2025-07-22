#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

# -----------------------------
# 1. Install and Configure ibsimu
# -----------------------------

echo "Updating package list and installing dependencies..."
sudo apt update && sudo apt install -y \
    libfontconfig1-dev \
    libfreetype6-dev \
    libcairo2-dev \
    libpng-dev \
    zlib1g-dev \
    libgsl-dev \
    libgtk-3-dev \
    libgtkglext1-dev \
    libsuitesparse-dev

echo "Cloning the ibsimu repository..."
git clone git://ibsimu.git.sourceforge.net/gitroot/ibsimu/ibsimu
cd ibsimu

echo "Updating repository and compiling ibsimu..."
git pull
./reconf
./configure
make clean
make
sudo make install

# -----------------------------
# 1a. Ensure the pkg‑config File Is Correct
# -----------------------------
# Note: This script assumes the pkg-config file is installed at /usr/local/lib/pkgconfig/ibsimu-1.0.6dev.pc.
# If it needs manual updating, please edit that file accordingly.
echo "Setting PKG_CONFIG_PATH for this session..."
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

cd ..

# -----------------------------
# 2. Build A Test Program
# -----------------------------
echo "Creating test program directory structure..."
mkdir -p ~/simulations/first_test
cd ~/simulations/first_test

echo "Downloading test source files..."
# Download the test C++ source file and the Makefile from ibsimu SourceForge site.
wget -O vlasov2d.cpp https://ibsimu.sourceforge.net/vlasov2d/vlasov2d.cpp
wget -O Makefile https://ibsimu.sourceforge.net/vlasov2d/Makefile

echo "Building the test program..."
make clean
make

# -----------------------------
# 3. Configure the Runtime Linker
# -----------------------------
echo "Adding /usr/local/lib to the system library path..."
echo "/usr/local/lib" | sudo tee /etc/ld.so.conf.d/usrlocal.conf >/dev/null

echo "Updating the linker cache..."
sudo ldconfig

# -----------------------------
# 4. Test the Executable
# -----------------------------
echo "Unsetting any temporary LD_LIBRARY_PATH (if set)..."
unset LD_LIBRARY_PATH

echo "Running the test executable..."
./vlasov2d

echo "Installation and test completed successfully."
