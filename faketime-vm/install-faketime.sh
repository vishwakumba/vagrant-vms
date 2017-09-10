#!/bin/bash

WORK_DIR="$HOME/fake-work"

echo "Step 1: Installing Git.."
sudo yum install -y git
echo

echo "Step 2: Installing Make, GCC.."
sudo yum install -y gcc make 
echo

echo "Step 3: Downloading libfaketime Github project.."
rm -rf $WORK_DIR
mkdir -p $WORK_DIR
cd $WORK_DIR

git clone https://github.com/wolfcw/libfaketime.git
cd libfaketime
make

if [ -f $WORK_DIR/libfaketime/src/libfaketime.so.1 ]; then
   echo "Compilation of libfaketime github project is successful. libfaketime.so.1 has been produced.."
else
   echo "Error: Something wrong happened during the compilation of libfaketime github project. Manual intervention required."
   exit 1
fi
echo

echo "Step 4: Copying libfaketime.so.1 to /usr/local/lib directory.."
sudo rm -f /usr/local/lib/libfaketime.so.1
sudo cp $WORK_DIR/libfaketime/src/libfaketime.so.1 /usr/local/lib

echo "You seem to have installed libfaketime successfully. To use future or past dates, set the LD_PRELOAD and FAKETIME environment variables for your shell or component"
echo "   For example: to go to 15 days in the future.."
echo "       export LD_PRELOAD=\"/usr/local/lib/libfaketime.so.1\""
echo "       export FAKETIME=\"+15d\""

echo Done
