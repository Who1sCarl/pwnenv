# Pwnenv - PWN environment toolkit

CTF PWN 环境搭建脚本

## Introduction

### Test environment 

Vm: 

```parallels desktop 版本 15.1.2 (47123)```

Os:

```shell
carlstar@pwn:~$ uname -a
Linux pwn 4.13.0-36-generic #40~16.04.1-Ubuntu SMP Fri Feb 16 23:25:58 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
```

### Tools for pwn

### pwntools

由于 python2 即将不再维护，pwntools 官方也推荐使用 python3 来安装，所以安装的是 python3 版本。

![](https://carlstar.club/images/github/img2.png)

### vim

系统自带的 vim 不支持编辑文档，只能查看文本。

### ropper

比较大的文件或者做 kernel pwn 找 gadgets 的时候还是 ropper 好用

![](https://carlstar.club/images/github/img3.png)



### ROPgadget

一般找 gadgets 用它就好了。

![](https://carlstar.club/images/github/img4.png)



### libc-database

线下没互联网的情况下可以用一下，常规性的 libc 就 2.23||2.27。

推荐两个在线找 libc 的网站 [https://libc.blukat.me/](https://libc.blukat.me/)    ||    [https://libc.nullbyte.cat/](https://libc.nullbyte.cat/)



### pwndbg + pwngdb

这两个插件加起来非常好用，谁用谁知道。介绍的话就直接看官方的吧，已经很详细了。更多好的功能可以自己挖掘一下～



![](https://carlstar.club/images/github/img5.png)



### libc-debug

如果有时候想深入了解一下，或者什么地方做不明白，那就只能跟源码了，源码在用户的根目录下 glibc-2.23 这个文件夹中，直接在 gdb 里面

```shell
pwndbg> directory /home/carlstar/glibc-2.23/malloc/
pwndbg> b _int_malloc
```

### ssh

这个没啥好说的

### one_gadget

做题神器，一般的话至少有一个 gadget 肯定可以用，不行的话那只能 realloc 调栈或者试试 free_hook。

![](https://carlstar.club/images/github/img6.png)

## Installation

```shell
git clone https://github.com/Who1sCarl/pwnenv.git
cd pwnenv
chmod +x init_pwn.sh
./init_pwn.sh
```

如果虚拟机或者本地无法直接访问 git，那么脚本不会执行成功，需要设置 socks5 代理。

![](https://carlstar.club/images/github/img0.png)

在拉取 lic-database 时时间比较久，可以后续自己手动下载。

![](https://carlstar.club/images/github/img1.png)



## Contact

有任何问题或者 bug，欢迎提 issue 或者联系我，CarlStar#protonmail.ch。