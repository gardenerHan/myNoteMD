# Nginx

*@Author:hanguixian*

*@Email:hn_hanguixian@163.com*

## 一 环境准备

### 1 环境确认

- 确认系统网络

  ```bash
  [root@izuf64yofkbhp8tm0ackshz opt]# ping www.baid.com
  PING www.baid.com (184.154.126.180) 56(84) bytes of data.
  64 bytes from server2.homelike.com (184.154.126.180): icmp_seq=1 ttl=47 time=199 ms
  64 bytes from server2.homelike.com (184.154.126.180): icmp_seq=2 ttl=47 time=199 ms
  64 bytes from server2.homelike.com (184.154.126.180): icmp_seq=3 ttl=47 time=199 ms
  64 bytes from server2.homelike.com (184.154.126.180): icmp_seq=4 ttl=47 time=199 ms
  ```

- 确认yum可用

  ```bash
  [root@izuf64yofkbhpt8m0ackshz opt]# yum list|grep gcc
  gcc.x86_64                               4.8.5-28.el7_5.1              @updates 
  gcc-c++.x86_64                           4.8.5-28.el7_5.1              @updates 
  libgcc.x86_64                            4.8.5-28.el7_5.1              @updates 
  avr-gcc.x86_64                           4.9.2-1.el7                   epel     
  avr-gcc-c++.x86_64                       4.9.2-1.el7                   epel     
  //省略......
  ```

- 确认关闭iptables规则

  ```bash
  # 命令
  iptables -L
  iptables -F
  iptables -t nat -L
  iptables -t nat -F
  ```

- 确认停用selinux

  ```bash
  [root@izuf64yofkbhp8tm0ackshz opt]# getenforce
  Disabled
  [root@izuf64yofkbhpt8m0ackshz opt]# setenforce 0
  setenforce: SELinux is disabled
  ```

### 2 安装基本依赖

- 命令

  ```bash
  yum -y install gcc gcc-c++ autoconf pcre pcre-devel make  antomake
  ```

### 3 初始化目录

```bash
 cd /opt/
 mkdir app backup  download logs work
 # 应用 备份 下载 日志 工作
```



## 二 什么是Nginx



