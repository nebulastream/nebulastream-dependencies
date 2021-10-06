#!/bin/bash

# install prerequisites silently
apt install wget software-properties-common lsb-release -y -qq

# llvm official apt repo install process
# more on: https://apt.llvm.org/, run as sudo
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# install clang alternatives from clang-13
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 10
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 10

# install clang as cc/c++ alternatives
update-alternatives --install /usr/bin/cc cc /usr/bin/clang 20
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 20

# set clang as cc/c++
update-alternatives --set cc /usr/bin/clang
update-alternatives --set c++ /usr/bin/clang++

# vcpkg reminder
echo "Clang-13 is the default compiler, go bootstrap vcpkg!"