# 构建自己的mycentos日志

```bash
[root@izuf64yofkbhpt8m0ackshz mydocker]# docker build -f hgxDockerFile -t hgxtomcat8 .
Sending build context to Docker daemon  195.3MB
Step 1/15 : FROM centos
 ---> 5182e96772bf
Step 2/15 : MAINTAINER  hanguixian<hn_hanguixian@163.com>
 ---> Running in b2c8a11bd81f
Removing intermediate container b2c8a11bd81f
 ---> ad5f24973616
Step 3/15 : COPY c.txt /usr/local/cincontainer.txt
 ---> 8ce780821ffa
Step 4/15 : ADD jdk-8u181-linux-x64.tar.gz /usr/local/
 ---> 3d9d6b2790b0
Step 5/15 : ADD apache-tomcat-8.5.33.tar.gz /usr/local/
 ---> ff9b49311126
Step 6/15 : RUN yum -y install vim
 ---> Running in 6a1282975a9d
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: ftp.sjtu.edu.cn
 * extras: mirrors.shu.edu.cn
 * updates: ftp.sjtu.edu.cn
http://mirrors.shu.edu.cn/centos/7.5.1804/extras/x86_64/repodata/6dac3e8bffae57ecf1a7806e6b490f9c7691f5031cf66fb48d5746ea71e4c4d1-primary.sqlite.bz2: [Errno 14] curl#7 - "Failed connect to mirrors.shu.edu.cn:80; Connection refused"
Trying other mirror.
Resolving Dependencies
--> Running transaction check
---> Package vim-enhanced.x86_64 2:7.4.160-4.el7 will be installed
--> Processing Dependency: vim-common = 2:7.4.160-4.el7 for package: 2:vim-enhanced-7.4.160-4.el7.x86_64
--> Processing Dependency: which for package: 2:vim-enhanced-7.4.160-4.el7.x86_64
--> Processing Dependency: perl(:MODULE_COMPAT_5.16.3) for package: 2:vim-enhanced-7.4.160-4.el7.x86_64
--> Processing Dependency: libperl.so()(64bit) for package: 2:vim-enhanced-7.4.160-4.el7.x86_64
--> Processing Dependency: libgpm.so.2()(64bit) for package: 2:vim-enhanced-7.4.160-4.el7.x86_64
--> Running transaction check
---> Package gpm-libs.x86_64 0:1.20.7-5.el7 will be installed
---> Package perl.x86_64 4:5.16.3-292.el7 will be installed
--> Processing Dependency: perl(Socket) >= 1.3 for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Scalar::Util) >= 1.10 for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl-macros for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(threads::shared) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(threads) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(constant) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Time::Local) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Time::HiRes) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Storable) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Socket) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Scalar::Util) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Pod::Simple::XHTML) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Pod::Simple::Search) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Getopt::Long) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Filter::Util::Call) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(File::Temp) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(File::Spec::Unix) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(File::Spec::Functions) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(File::Spec) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(File::Path) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Exporter) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Cwd) for package: 4:perl-5.16.3-292.el7.x86_64
--> Processing Dependency: perl(Carp) for package: 4:perl-5.16.3-292.el7.x86_64
---> Package perl-libs.x86_64 4:5.16.3-292.el7 will be installed
---> Package vim-common.x86_64 2:7.4.160-4.el7 will be installed
--> Processing Dependency: vim-filesystem for package: 2:vim-common-7.4.160-4.el7.x86_64
---> Package which.x86_64 0:2.20-7.el7 will be installed
--> Running transaction check
---> Package perl-Carp.noarch 0:1.26-244.el7 will be installed
---> Package perl-Exporter.noarch 0:5.68-3.el7 will be installed
---> Package perl-File-Path.noarch 0:2.09-2.el7 will be installed
---> Package perl-File-Temp.noarch 0:0.23.01-3.el7 will be installed
---> Package perl-Filter.x86_64 0:1.49-3.el7 will be installed
---> Package perl-Getopt-Long.noarch 0:2.40-3.el7 will be installed
--> Processing Dependency: perl(Pod::Usage) >= 1.14 for package: perl-Getopt-Long-2.40-3.el7.noarch
--> Processing Dependency: perl(Text::ParseWords) for package: perl-Getopt-Long-2.40-3.el7.noarch
---> Package perl-PathTools.x86_64 0:3.40-5.el7 will be installed
---> Package perl-Pod-Simple.noarch 1:3.28-4.el7 will be installed
--> Processing Dependency: perl(Pod::Escapes) >= 1.04 for package: 1:perl-Pod-Simple-3.28-4.el7.noarch
--> Processing Dependency: perl(Encode) for package: 1:perl-Pod-Simple-3.28-4.el7.noarch
---> Package perl-Scalar-List-Utils.x86_64 0:1.27-248.el7 will be installed
---> Package perl-Socket.x86_64 0:2.010-4.el7 will be installed
---> Package perl-Storable.x86_64 0:2.45-3.el7 will be installed
---> Package perl-Time-HiRes.x86_64 4:1.9725-3.el7 will be installed
---> Package perl-Time-Local.noarch 0:1.2300-2.el7 will be installed
---> Package perl-constant.noarch 0:1.27-2.el7 will be installed
---> Package perl-macros.x86_64 4:5.16.3-292.el7 will be installed
---> Package perl-threads.x86_64 0:1.87-4.el7 will be installed
---> Package perl-threads-shared.x86_64 0:1.43-6.el7 will be installed
---> Package vim-filesystem.x86_64 2:7.4.160-4.el7 will be installed
--> Running transaction check
---> Package perl-Encode.x86_64 0:2.51-7.el7 will be installed
---> Package perl-Pod-Escapes.noarch 1:1.04-292.el7 will be installed
---> Package perl-Pod-Usage.noarch 0:1.63-3.el7 will be installed
--> Processing Dependency: perl(Pod::Text) >= 3.15 for package: perl-Pod-Usage-1.63-3.el7.noarch
--> Processing Dependency: perl-Pod-Perldoc for package: perl-Pod-Usage-1.63-3.el7.noarch
---> Package perl-Text-ParseWords.noarch 0:3.29-4.el7 will be installed
--> Running transaction check
---> Package perl-Pod-Perldoc.noarch 0:3.20-4.el7 will be installed
--> Processing Dependency: perl(parent) for package: perl-Pod-Perldoc-3.20-4.el7.noarch
--> Processing Dependency: perl(HTTP::Tiny) for package: perl-Pod-Perldoc-3.20-4.el7.noarch
--> Processing Dependency: groff-base for package: perl-Pod-Perldoc-3.20-4.el7.noarch
---> Package perl-podlators.noarch 0:2.5.1-3.el7 will be installed
--> Running transaction check
---> Package groff-base.x86_64 0:1.22.2-8.el7 will be installed
---> Package perl-HTTP-Tiny.noarch 0:0.033-3.el7 will be installed
---> Package perl-parent.noarch 1:0.225-244.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package                     Arch        Version                Repository
                                                                           Size
================================================================================
Installing:
 vim-enhanced                x86_64      2:7.4.160-4.el7        base      1.0 M
Installing for dependencies:
 gpm-libs                    x86_64      1.20.7-5.el7           base       32 k
 groff-base                  x86_64      1.22.2-8.el7           base      942 k
 perl                        x86_64      4:5.16.3-292.el7       base      8.0 M
 perl-Carp                   noarch      1.26-244.el7           base       19 k
 perl-Encode                 x86_64      2.51-7.el7             base      1.5 M
 perl-Exporter               noarch      5.68-3.el7             base       28 k
 perl-File-Path              noarch      2.09-2.el7             base       26 k
 perl-File-Temp              noarch      0.23.01-3.el7          base       56 k
 perl-Filter                 x86_64      1.49-3.el7             base       76 k
 perl-Getopt-Long            noarch      2.40-3.el7             base       56 k
 perl-HTTP-Tiny              noarch      0.033-3.el7            base       38 k
 perl-PathTools              x86_64      3.40-5.el7             base       82 k
 perl-Pod-Escapes            noarch      1:1.04-292.el7         base       51 k
 perl-Pod-Perldoc            noarch      3.20-4.el7             base       87 k
 perl-Pod-Simple             noarch      1:3.28-4.el7           base      216 k
 perl-Pod-Usage              noarch      1.63-3.el7             base       27 k
 perl-Scalar-List-Utils      x86_64      1.27-248.el7           base       36 k
 perl-Socket                 x86_64      2.010-4.el7            base       49 k
 perl-Storable               x86_64      2.45-3.el7             base       77 k
 perl-Text-ParseWords        noarch      3.29-4.el7             base       14 k
 perl-Time-HiRes             x86_64      4:1.9725-3.el7         base       45 k
 perl-Time-Local             noarch      1.2300-2.el7           base       24 k
 perl-constant               noarch      1.27-2.el7             base       19 k
 perl-libs                   x86_64      4:5.16.3-292.el7       base      688 k
 perl-macros                 x86_64      4:5.16.3-292.el7       base       43 k
 perl-parent                 noarch      1:0.225-244.el7        base       12 k
 perl-podlators              noarch      2.5.1-3.el7            base      112 k
 perl-threads                x86_64      1.87-4.el7             base       49 k
 perl-threads-shared         x86_64      1.43-6.el7             base       39 k
 vim-common                  x86_64      2:7.4.160-4.el7        base      5.9 M
 vim-filesystem              x86_64      2:7.4.160-4.el7        base       10 k
 which                       x86_64      2.20-7.el7             base       41 k

Transaction Summary
================================================================================
Install  1 Package (+32 Dependent packages)

Total download size: 19 M
Installed size: 63 M
Downloading packages:
warning: /var/cache/yum/x86_64/7/base/packages/gpm-libs-1.20.7-5.el7.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
Public key for gpm-libs-1.20.7-5.el7.x86_64.rpm is not installed
--------------------------------------------------------------------------------
Total                                               31 MB/s |  19 MB  00:00     
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Importing GPG key 0xF4A80EB5:
 Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
 Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
 Package    : centos-release-7-5.1804.1.el7.centos.x86_64 (@Updates)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : 2:vim-filesystem-7.4.160-4.el7.x86_64                       1/33 
  Installing : 2:vim-common-7.4.160-4.el7.x86_64                           2/33 
  Installing : gpm-libs-1.20.7-5.el7.x86_64                                3/33 
  Installing : groff-base-1.22.2-8.el7.x86_64                              4/33 
  Installing : 1:perl-parent-0.225-244.el7.noarch                          5/33 
  Installing : perl-HTTP-Tiny-0.033-3.el7.noarch                           6/33 
  Installing : perl-podlators-2.5.1-3.el7.noarch                           7/33 
  Installing : perl-Pod-Perldoc-3.20-4.el7.noarch                          8/33 
  Installing : 1:perl-Pod-Escapes-1.04-292.el7.noarch                      9/33 
  Installing : perl-Text-ParseWords-3.29-4.el7.noarch                     10/33 
  Installing : perl-Encode-2.51-7.el7.x86_64                              11/33 
  Installing : perl-Pod-Usage-1.63-3.el7.noarch                           12/33 
  Installing : 4:perl-macros-5.16.3-292.el7.x86_64                        13/33 
  Installing : 4:perl-libs-5.16.3-292.el7.x86_64                          14/33 
  Installing : perl-Storable-2.45-3.el7.x86_64                            15/33 
  Installing : perl-Exporter-5.68-3.el7.noarch                            16/33 
  Installing : perl-constant-1.27-2.el7.noarch                            17/33 
  Installing : perl-Time-Local-1.2300-2.el7.noarch                        18/33 
  Installing : perl-Socket-2.010-4.el7.x86_64                             19/33 
  Installing : perl-Carp-1.26-244.el7.noarch                              20/33 
  Installing : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                      21/33 
  Installing : perl-PathTools-3.40-5.el7.x86_64                           22/33 
  Installing : perl-Scalar-List-Utils-1.27-248.el7.x86_64                 23/33 
  Installing : perl-File-Temp-0.23.01-3.el7.noarch                        24/33 
  Installing : perl-File-Path-2.09-2.el7.noarch                           25/33 
  Installing : perl-threads-shared-1.43-6.el7.x86_64                      26/33 
  Installing : perl-threads-1.87-4.el7.x86_64                             27/33 
  Installing : perl-Filter-1.49-3.el7.x86_64                              28/33 
  Installing : 1:perl-Pod-Simple-3.28-4.el7.noarch                        29/33 
  Installing : perl-Getopt-Long-2.40-3.el7.noarch                         30/33 
  Installing : 4:perl-5.16.3-292.el7.x86_64                               31/33 
  Installing : which-2.20-7.el7.x86_64                                    32/33 
install-info: No such file or directory for /usr/share/info/which.info.gz
  Installing : 2:vim-enhanced-7.4.160-4.el7.x86_64                        33/33 
  Verifying  : perl-HTTP-Tiny-0.033-3.el7.noarch                           1/33 
  Verifying  : perl-threads-shared-1.43-6.el7.x86_64                       2/33 
  Verifying  : perl-Storable-2.45-3.el7.x86_64                             3/33 
  Verifying  : perl-Exporter-5.68-3.el7.noarch                             4/33 
  Verifying  : perl-constant-1.27-2.el7.noarch                             5/33 
  Verifying  : perl-PathTools-3.40-5.el7.x86_64                            6/33 
  Verifying  : 4:perl-macros-5.16.3-292.el7.x86_64                         7/33 
  Verifying  : 1:perl-parent-0.225-244.el7.noarch                          8/33 
  Verifying  : 4:perl-5.16.3-292.el7.x86_64                                9/33 
  Verifying  : which-2.20-7.el7.x86_64                                    10/33 
  Verifying  : groff-base-1.22.2-8.el7.x86_64                             11/33 
  Verifying  : perl-File-Temp-0.23.01-3.el7.noarch                        12/33 
  Verifying  : 1:perl-Pod-Simple-3.28-4.el7.noarch                        13/33 
  Verifying  : perl-Time-Local-1.2300-2.el7.noarch                        14/33 
  Verifying  : gpm-libs-1.20.7-5.el7.x86_64                               15/33 
  Verifying  : 4:perl-libs-5.16.3-292.el7.x86_64                          16/33 
  Verifying  : perl-Socket-2.010-4.el7.x86_64                             17/33 
  Verifying  : perl-Carp-1.26-244.el7.noarch                              18/33 
  Verifying  : 2:vim-enhanced-7.4.160-4.el7.x86_64                        19/33 
  Verifying  : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                      20/33 
  Verifying  : perl-Scalar-List-Utils-1.27-248.el7.x86_64                 21/33 
  Verifying  : 1:perl-Pod-Escapes-1.04-292.el7.noarch                     22/33 
  Verifying  : 2:vim-filesystem-7.4.160-4.el7.x86_64                      23/33 
  Verifying  : perl-Pod-Usage-1.63-3.el7.noarch                           24/33 
  Verifying  : perl-Encode-2.51-7.el7.x86_64                              25/33 
  Verifying  : perl-Pod-Perldoc-3.20-4.el7.noarch                         26/33 
  Verifying  : perl-podlators-2.5.1-3.el7.noarch                          27/33 
  Verifying  : perl-File-Path-2.09-2.el7.noarch                           28/33 
  Verifying  : perl-threads-1.87-4.el7.x86_64                             29/33 
  Verifying  : perl-Filter-1.49-3.el7.x86_64                              30/33 
  Verifying  : perl-Getopt-Long-2.40-3.el7.noarch                         31/33 
  Verifying  : perl-Text-ParseWords-3.29-4.el7.noarch                     32/33 
  Verifying  : 2:vim-common-7.4.160-4.el7.x86_64                          33/33 

Installed:
  vim-enhanced.x86_64 2:7.4.160-4.el7                                           

Dependency Installed:
  gpm-libs.x86_64 0:1.20.7-5.el7                                                
  groff-base.x86_64 0:1.22.2-8.el7                                              
  perl.x86_64 4:5.16.3-292.el7                                                  
  perl-Carp.noarch 0:1.26-244.el7                                               
  perl-Encode.x86_64 0:2.51-7.el7                                               
  perl-Exporter.noarch 0:5.68-3.el7                                             
  perl-File-Path.noarch 0:2.09-2.el7                                            
  perl-File-Temp.noarch 0:0.23.01-3.el7                                         
  perl-Filter.x86_64 0:1.49-3.el7                                               
  perl-Getopt-Long.noarch 0:2.40-3.el7                                          
  perl-HTTP-Tiny.noarch 0:0.033-3.el7                                           
  perl-PathTools.x86_64 0:3.40-5.el7                                            
  perl-Pod-Escapes.noarch 1:1.04-292.el7                                        
  perl-Pod-Perldoc.noarch 0:3.20-4.el7                                          
  perl-Pod-Simple.noarch 1:3.28-4.el7                                           
  perl-Pod-Usage.noarch 0:1.63-3.el7                                            
  perl-Scalar-List-Utils.x86_64 0:1.27-248.el7                                  
  perl-Socket.x86_64 0:2.010-4.el7                                              
  perl-Storable.x86_64 0:2.45-3.el7                                             
  perl-Text-ParseWords.noarch 0:3.29-4.el7                                      
  perl-Time-HiRes.x86_64 4:1.9725-3.el7                                         
  perl-Time-Local.noarch 0:1.2300-2.el7                                         
  perl-constant.noarch 0:1.27-2.el7                                             
  perl-libs.x86_64 4:5.16.3-292.el7                                             
  perl-macros.x86_64 4:5.16.3-292.el7                                           
  perl-parent.noarch 1:0.225-244.el7                                            
  perl-podlators.noarch 0:2.5.1-3.el7                                           
  perl-threads.x86_64 0:1.87-4.el7                                              
  perl-threads-shared.x86_64 0:1.43-6.el7                                       
  vim-common.x86_64 2:7.4.160-4.el7                                             
  vim-filesystem.x86_64 2:7.4.160-4.el7                                         
  which.x86_64 0:2.20-7.el7                                                     

Complete!
Removing intermediate container 6a1282975a9d
 ---> b3babd80eaba
Step 7/15 : ENV MYPATH /usr/local
 ---> Running in 343bcdb934c0
Removing intermediate container 343bcdb934c0
 ---> cd864dd9dce3
Step 8/15 : WORKDIR $MYPATH
 ---> Running in 5825548901c4
Removing intermediate container 5825548901c4
 ---> 755cb4860975
Step 9/15 : ENV JAVA_HOME /usr/local/jdk1.8.0_181
 ---> Running in 5cc940e29081
Removing intermediate container 5cc940e29081
 ---> 46332edabe4b
Step 10/15 : ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
 ---> Running in d9dfa42e2adc
Removing intermediate container d9dfa42e2adc
 ---> 4af8a0fe0bfb
Step 11/15 : ENV CATALINA_HOME /usr/local/apache-tomcat-8.5.33
 ---> Running in fe02b1a8b8b7
Removing intermediate container fe02b1a8b8b7
 ---> cfe82ec0751a
Step 12/15 : ENV CATALINA_BASE /usr/local/apache-tomcat-8.5.33
 ---> Running in 03b648a2c4e2
Removing intermediate container 03b648a2c4e2
 ---> c65ba5f36476
Step 13/15 : ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin
 ---> Running in 593a5ce551f2
Removing intermediate container 593a5ce551f2
 ---> f626f4777c88
Step 14/15 : EXPOSE 8080
 ---> Running in 84ffa45620b9
Removing intermediate container 84ffa45620b9
 ---> d6a56e36d202
Step 15/15 : CMD /usr/local/apache-tomcat-8.5.33/bin/startup.sh && tail -F /usr/local/apache-tomcat-8.5.33/logs/catalina.out
 ---> Running in 785dbda301fc
Removing intermediate container 785dbda301fc
 ---> 9907de7f3eee
Successfully built 9907de7f3eee
Successfully tagged hgxtomcat8:latest

```

