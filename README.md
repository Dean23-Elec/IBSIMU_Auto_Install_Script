# IBSIMU Install Script
***

This script will find and install the required depencies for IBSIMU to work automatically, to get this to run clone this repo and run the following commands:

cd IBSIMU_Auto_Install_Script
chmod +x install_ibsimu.sh
./install_ibsimu.sh

This will then automatically install everything required for IBSIMU to function.
After the install is completed the script will download the vlasov2d.cpp example from
SourceForge and the build and run the example. The output from this can be found in the
~/simulations/first_test directory. When completed in this directory should show plot1.png
with the simulation results showing all should now be working and configured correctly for
writing custom simulations.
