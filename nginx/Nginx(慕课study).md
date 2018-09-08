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



## 三 Nginx特性_实现优点



## 四 Nginx快速安装

### 1.版本

- Mainline version  开发版本

- Stable version 稳定版本

- Legacy versions 历史版本

### 2.安装

- 官网 : http://nginx.org/en/download.html

- 稳定版本安装(centos)

  - 为RHEL / CentOS设置yum存储库，创建`/etc/yum.repos.d/nginx.repo` 文件中写入 ： 

    ```shell
    [nginx]
    name=nginx repo
    baseurl=http://nginx.org/packages/OS/OSRELEASE/$basearch/
    gpgcheck=0
    enabled=1
    ```

  - 替换 `OS` 为`rhel`或`cento`，根据系统，`OSRELEASE`修改为 `6`或 `7`，分别对应6 x或7.x的版本。 

    ```bash
    [nginx]
    name=nginx repo
    baseurl=http://nginx.org/packages/centos/7/$basearch/
    gpgcheck=0
    enabled=1
    ```

  - 查看Nginx

    ```bash
    yum list | grep nginx
    ```

  - 安装Nginx

    ```bash
     yum install nginx
    ```

  - 查看版本和信息

    ```bash
    [root@izuf64yofkbhp8tm0ackshz ~]# nginx -v
    nginx version: nginx/1.14.0
    [root@izuf64yofkbhp8tm0ackshz ~]# nginx -V
    nginx version: nginx/1.14.0
    built by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
    built with OpenSSL 1.0.2k-fips  26 Jan 2017
    TLS SNI support enabled
    configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie'
    ```

  - 到此证明安装成功



## 五 Nginx的目录和配置语法

### 1.Nginx的安装目录

#### 1.1查看Nginx目录

- 命令 : ` rpm -ql nginx`

```nginx
[root@izuf64yofkbhp8tm0ackshz ~]# rpm -ql nginx
/etc/logrotate.d/nginx
/etc/nginx
/etc/nginx/conf.d
/etc/nginx/conf.d/default.conf
/etc/nginx/fastcgi_params
/etc/nginx/koi-utf
/etc/nginx/koi-win
/etc/nginx/mime.types
/etc/nginx/modules
/etc/nginx/nginx.conf
/etc/nginx/scgi_params
/etc/nginx/uwsgi_params
/etc/nginx/win-utf
/etc/sysconfig/nginx
/etc/sysconfig/nginx-debug
/usr/lib/systemd/system/nginx-debug.service
/usr/lib/systemd/system/nginx.service
/usr/lib64/nginx
/usr/lib64/nginx/modules
/usr/libexec/initscripts/legacy-actions/nginx
/usr/libexec/initscripts/legacy-actions/nginx/check-reload
/usr/libexec/initscripts/legacy-actions/nginx/upgrade
/usr/sbin/nginx
/usr/sbin/nginx-debug
/usr/share/doc/nginx-1.14.0
/usr/share/doc/nginx-1.14.0/COPYRIGHT
/usr/share/man/man8/nginx.8.gz
/usr/share/nginx
/usr/share/nginx/html
/usr/share/nginx/html/50x.html
/usr/share/nginx/html/index.html
/var/cache/nginx
/var/log/nginx

```

#### 1.2 安装目录讲解 

| 路径                                                         | 类型          | 作用                                       |
| ------------------------------------------------------------ | ------------- | ------------------------------------------ |
| /etc/logrotate.d/nginx                                       | 配置文件      | Nginx日志轮转,用于logrotate服务的日志切割  |
| /etc/nginx,/etc/nginx/conf.d,/etc/nginx/conf.d/default.conf,/etc/nginx/nginx.conf | 目录,配置文件 | Nginx主配置文件                            |
| /etc/nginx/fastcgi_params,/etc/nginx/scgi_params,/etc/nginx/uwsgi_params | 配置文件      | cgi配置相关,fastcgi配置                    |
| /etc/nginx/koi-utf,/etc/nginx/koi-win,/etc/nginx/win-utf     | 配置文件      | 编码转换映射转化文件                       |
| /etc/nginx/mime.types                                        | 配置文件      | 设置Http协议的Content_Type与扩展名对应关系 |
| /usr/lib/systemd/system/nginx-debug.service,/usr/lib/systemd/system/nginx.service,/etc/sysconfig/nginx,/etc/sysconfig/nginx-debug | 配置          | 用于配置出系统守护进程管理器管理方式       |
| /etc/nginx/modules,/usr/lib64/nginx/modules                  | 目录          | Nginx模块目录                              |
| /usr/share/doc/nginx-1.14.0,usr/share/doc/nginx-1.14.0/COPYRIGHT,/usr/share/man/man8/nginx.8.gz | 文件,目录     | Nginx手册和目录文件                        |
| /var/cache/nginx                                             | 目录          | Nginx的缓存目录                            |
| /var/log/nginx                                               | 目录          | Nginx日志目录                              |



### 2. 编译配置参数



### 3. 默认配置语法

#### 3.1 步骤 

- cd /etc/nginx

- vim nginx.conf

  ```nginx
  user  nginx;
  worker_processes  1;
  
  error_log  /var/log/nginx/error.log warn;
  pid        /var/run/nginx.pid;
  
  
  events {
      worker_connections  1024;
  }
  
  
  http {
      include       /etc/nginx/mime.types;
      default_type  application/octet-stream;
  
      log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for"';
  
      access_log  /var/log/nginx/access.log  main;
  
      sendfile        on;
      #tcp_nopush     on;
  
      keepalive_timeout  65;
  
      #gzip  on;
  
      # 包含配置
      include /etc/nginx/conf.d/*.conf;
  }
  
  ```

- cd  /etc/nginx/conf.d/ 

  ```bash
  [root@izuf64yofkbhp8tm0ackshz nginx]# cd  /etc/nginx/conf.d/
  [root@izuf64yofkbhp8tm0ackshz conf.d]# ll
  total 4
  -rw-r--r-- 1 root root 1096 Sep  6 14:16 default.conf
  ```

- vim default.conf

  ```nginx
  server {
      listen       80;
      server_name  localhost;
  
      #charset koi8-r;
      #access_log  /var/log/nginx/host.access.log  main;
  
      location / {
          root   /usr/share/nginx/html;
          index  index.html index.htm;
      }
  
      #error_page  404              /404.html;
  
      # redirect server error pages to the static page /50x.html
      #
      error_page   500 502 503 504 404  /50x.html;
      location = /50x.html {
          root   /usr/share/nginx/html;
      }
  
      # proxy the PHP scripts to Apache listening on 127.0.0.1:80
      #
      #location ~ \.php$ {
      #    proxy_pass   http://127.0.0.1;
      #}
  
      # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
      #
      #location ~ \.php$ {
      #    root           html;
      #    fastcgi_pass   127.0.0.1:9000;
  ```

  





