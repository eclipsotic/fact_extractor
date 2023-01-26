#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )" || exit

echo "------------------------------------"
echo "        install uefi parser         "
echo "------------------------------------"


IS_VENV=$(python3 -c 'import sys; print(sys.exec_prefix!=sys.base_prefix)')
if [[ $IS_VENV == "False" ]]
then
  SUDO="sudo -E"
else
  SUDO=""
fi


cd ../../../install || exit
git clone https://github.com/theopolis/uefi-firmware-parser.git
cd uefi-firmware-parser || exit
git checkout 4262dbbaab12c964242545e4f59a74c8f1b2f871 # known stable commit
wget https://patch-diff.githubusercontent.com/raw/theopolis/uefi-firmware-parser/pull/83.patch # patch for python3 compatibility
git apply 83.patch
$SUDO python3 setup.py install --force
cp bin/uefi-firmware-parser ../../bin
cd ..
sudo rm -rf uefi-firmware-parser

exit 0
