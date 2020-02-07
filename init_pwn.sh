#!/bin/bash
set -e

echo "**********************************************************"
echo "* Author        : carlstar"
echo "* Email         : CarlStar@protonmail.ch"
echo "* Last modified : 2020-02-06 21:00"
echo "* Description   : A script to quickly build a pwn environment"
echo "* ********************************************************"


echo "[+] if your pc run git at a low speed or get a time out, the script can't execute success, so you need a socks5 proxy."
echo "[+] type n or N to disable git proxy, type y or Y set a socks5 proxy"
read arg0
if [[ $arg0 = "n" ]] || [[ $arg0 = "N" ]]; then
    echo "Get that~"
else
    echo "[+] please input your socks5 uri, like socks5://ip:port"
    read arg1
fi

install_vim() {
    sudo apt-get -y install vim
}

change_source_for_pip() {
    cd ~ && mkdir .pip
    cd ~/.pip && touch pip.conf
    echo [global] >> pip.conf
    echo index-url = https://pypi.tuna.tsinghua.edu.cn/simple >> pip.conf
    echo [install] >> pip.conf
    echo trusted-host=mirrors.aliyun.com >> pip.conf
}

change_source_for_apt() {
    cd /etc/apt/
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
    sudo rm -rf  /etc/apt/sources.list
    sudo touch  /etc/apt/sources.list
    echo \# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释 | sudo tee -a sources.list
    echo deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse | sudo tee -a sources.list
    echo \# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse | sudo tee -a sources.list
    echo deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse | sudo tee -a  sources.list
    echo \# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse | sudo tee -a sources.list
    echo deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse | sudo tee -a sources.list
    echo \# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse | sudo tee -a sources.list
    echo deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse | sudo tee -a sources.list
    echo \# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse | sudo tee -a sources.list    
}
update_apt() {
    sudo apt-get update
}

install_pwntools() {
    sudo apt-get -y install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
    git config --global https.proxy $arg1
    git config --global http.proxy  $arg1
    #pip install --upgrade pip
    python3 -m pip install --upgrade pip
    python3 -m pip install --upgrade git+https://github.com/Gallopsled/pwntools.git@dev
}

install_pwndbg() {
    cd ~ && git clone https://github.com/pwndbg/pwndbg
    cd pwndbg
    ./setup.sh
}

install_one_gadgets() {
    sudo apt install ruby
    sudo gem install one_gadget
}

install_ssh() {
    sudo apt-get -y install ssh
}

install_pwngdb() {
    cd ~/ && git clone https://github.com/scwuaptx/Pwngdb.git
    cp ~/Pwngdb/.gdbinit ~/
    sed -i '1d' ~/.gdbinit
    sed -i '1i source ~/pwndbg/gdbinit.py' ~/.gdbinit
}


install_libc_database() {
   cd ~/ && git clone https://github.com/niklasb/libc-database.git
}


# supprot x86 program
install_libc6_dev_i386() {
    sudo apt-get -y install libc6-dev-i386
}

#pwndbg>  directory glibc-2.23/malloc/
install_libc_debug() {
    sudo apt install libc6-dbg
    sudo apt install libc6-dbg:i386
    sudo apt-get -y install libc6-dbg
    sudo apt-get -y install glibc-source  
    tar xf /usr/src/glibc/glibc-2.23.tar.xz
}

install_Ropper() {
    sudo python3 -m pip install setuptools --upgrade
    # sudo python3 -m pip install capstone
    # sudo python3 -m pip install filebytes
    # sudo python3 -m pip install keystone-engine
    # sudo python3 -m pip install pyvex
    # cd ~ && git clone https://github.com/sashs/Ropper.git
    sudo python3 -m pip install ropper
}

success_info() {
    echo "[+] vim install success!"
    echo "[+] change source for pip success!"
    echo "[+] change source for apt success!"
    echo "[+] apt-get update success!"
    echo "[+] pwntools install success!"
    echo "[+] pwndbg install success!"
    echo "[+] one_gadget install success!"
    echo "[+] ssh install success!"
    echo "[+] pwngdb install success!"
    echo "[+] libc-database install success!"
    echo "[+] support for x86 program success!"
    echo "[+] libc_debug install success!"
    echo "[+] Ropper install success!"
}




if ! change_source_for_apt; then
    echo 'fail to change source for apt'
    exit
fi

if ! change_source_for_pip; then
    echo 'fail to change source for pip'
    exit
fi

if ! update_apt; then
    echo 'fail to update apt'
    exit
fi

if ! install_vim; then
    echo 'Vim installation failed'
    exit
fi


if ! install_ssh; then
    echo 'ssh installation failed'
    exit
fi



if ! install_pwntools; then
    echo 'pwntools installation failed'
    exit
fi

if ! install_pwndbg; then
    echo 'pwndbg installation failed'
    exit
fi

if ! install_pwngdb; then
    echo 'pwngdb installation failed'
    exit
fi

if ! install_libc6_dev_i386; then
    echo 'libc6_dev_i386 installation failed'
    exit
fi


if ! install_one_gadgets; then
    echo 'one_gadget installation failed'
    exit
fi

if ! install_Ropper; then
    echo 'Ropper installation failed'
    exit
fi

if ! install_libc_debug; then
    echo 'libc debug installation failed'
    exit
fi


if ! install_libc_database; then
    echo 'libc-database installation failed'
    exit
fi


echo "It will last 20 mins for downloading libc-database, input n or N to download later."

read input

if [[ $input = "n" ]] || [[ $input = "N" ]]; then
    echo "Get that~"
else
    cd ~/libc-database && ./get
fi

success_info

echo "[+]  all done, enjoy!"