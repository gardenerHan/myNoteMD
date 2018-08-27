# Docker 基础(基于javaEE)



<font color="green">*@Author:hanguixian*</font> 

<font color="green">*@Email:hn_hanguixian@163.com*<font>   

**Docker文档:https://docs.docker.com/**

**Dcker中文文档:https://docs.docker-cn.com/**


##  一.docker简介

### 1.docker是什么?

#### 1.1docker发展方向

| 方向   | 语言 | 框架等                                                 |
| ------ | ---- | ------------------------------------------------------ |
| JavaEE | java | SpringMVC/SpringBoot/Mybatis                           |
| Docker | Go   | Swarm/Compose/Machine/mesos/k8s/----CI/CD jenkinds整合 |

#### 1.2docker出现的原因

- 开发和运维之间相爱相杀:开发(打包的代码) -> 运维(部署)
  - 从产品到上线,从操作系统到运行系统,再到应用配置,需要关注很多东西.
  - 在各个版本迭代之后,不同版本环境的兼容对运维都是考验
- 运维部署多台
- 解决方案:
  - 环境配置很麻烦,换台机器就需要重来一次,能否软件带环境安装

  - 将开发环境(ok的,包含代码,配置,系统,数据) ----->打包------> 运维(部署):将原始环境一模一样复制

    ```mermaid
    graph TD
    classDef de fill:#f30,stroke:#333,stroke-width:4px;
    classDef de2 fill:#9f6,stroke:#333,stroke-width:4px;
    a[程序hello 代码 == 应用 ?] --编译-->b[hello.exe 执行文档 == 应用?]
    b --> c[windows ok]
    b --> d[Linux erro]
    b --> e[Solaris erro]
    b --> f[平台... 耦合性]
    
    class d,e,f de
    class c de2
    
    
    ```

    

- 镜像技术:
  - 打破"程序即应用"的观念

  - 从系统环境开始,自底至上打包应用,达到应用程序无缝接轨运作.

    ```mermaid
    graph TB
    classDef de fill:#f30,stroke:#333,stroke-width:4px;
    classDef de2 fill:#f92,stroke:#333,stroke-width:4px;
    
    subgraph docker 镜像即文档
    	a[运行文档] 
    	b[环境变量]
    	c[运行环境]
    	d[运行依赖包]
    	e[操作系统发行版本]
    	f[内核]
    end
    
    class a,b,c,d,e,f de2
    
    ```

    

####  1.3docker理念


- Docker是基于Go语言实现的云开源项目。 
- Docker是一个开源的容器引擎，它可以帮助我们更快地交付应用。Docker可将应用程序和基础设施层隔离，并且能将基础设施当作程序一样进行管理。使用Docker，可更快地打包、测试以及部署应用程序，并可减少从编写到部署运行代码的周期。
- Docker的主要月标是“Build, Ship and Run Any App,Anywhere",也就是通过对应用组件的封装、分发、部署、运行等生命周期的管 理，使用户的APP (可以是一个WEB应用或数据库应用等等)及其运行环境能够做到“一次封装，到处运行”。  
- Linux容器技术的出现就解决了这样一个问题，而Docker就是在它的基础上发展过来的。将应用运行在Docker容器上面，而Docker容器在任何操作系统上都是一致的，这就实现了跨平台、跨服务器。只需要一次配置好环境，换到别的机子上就可以一键部署好，大大简化了操作.

#### 1.4 logo解读
![logo](./img/logo.jpg)

- 鲸鱼背上有集装箱

  ​	蓝色海洋 --- 宿主机系统

  ​	鲸鱼 ----- docker

  ​	集装箱 ----- 容器实例

#### 1.5总结
 - 解决了运行环境和配置问题软件容器,方便做持续集成并有助于整体发布的容器虚拟化技术.



### 2.docker能做什么?

- 之前的虚拟机技术:

  - 虚拟机(virtual machine)就是带环境安装的一种解决方案。 它可以在一种操作系统里面运行另一种操作系统，比如在Windows系统里面运行Linux系统。应用程序对此亳无感知，因为虚拟机看上去跟真实系统一模一样，而对于底层系统来说，虚拟机就是一个普通文件，不需要了就删掉，对其他部分毫无影响。这类虚拟机完美的运行了另一套系统，能够使应用程序，操作系统和硬件三者之间的逻辑不变。  

    ```mermaid
    graph TB
    classDef de fill:#f30,stroke:#333,stroke-width:4px;
    classDef de1 fill:#9f6,stroke:#333,stroke-width:4px;
    classDef de2 fill:#f90,stroke:#333,stroke-width:4px;
    
    subgraph docker 虚拟机
    	a[app]
    	b[app]
    	c[app ...]
    	d[Libraries]
    	e[Kernel]
    end
    
    class a,b,c de2
    class d de
    class e de1
    
    ```

    - 缺点:
      - 资源占用多
      - 冗余步骤多
      - 启动慢

- 容器虚拟化技术:

  - 由于前面虚拟机存在这些缺点，Linux发展出了另一种虚拟化技术: Linux容器(Linux Containers, 缩写为LXC)。

  - Linux容器不是模拟一个完整的操作系统，而是对进程进行隔离。有了容器，就可以将软件运行所需的所有资源打包到一个隔离的容器中。容器与虚拟机不同，不需要捆绑一整套操作系统，只需要软件工作所需的库资源和设置。系统因此而变得高效轻量并保证部署在任何环境中的软件都能始终如一地运行。

    ```mermaid
    graph TB
    classDef de fill:#f30,stroke:#333,stroke-width:4px;
    classDef de1 fill:#9f6,stroke:#333,stroke-width:4px;
    classDef de2 fill:#f90,stroke:#333,stroke-width:4px;
    
    subgraph docker 容器虚拟化技术
    	subgraph 
    	 A1[app]
    	 B1[libraries]
    	end
    	C[kernel]
    	subgraph 
    	A2[app]
    	B2[libriraes]
    	end
    end
    
    class A1,A2 de2
    class B1,B2 de
    class C de1
    
    ```

  - Docker 和传统虚拟化方式的不同之处: 
     - 传统虚拟机技术是虚拟出一套硬件后，在其上运行一个完整操作系统，在该系统上再运行所需应用进程.
     - 容器内的应用进程直接运行于宿主的内核，容器内没有自己的内核，而且也没有进行硬件虚拟。因此容器要比传统虚拟机更为轻便。
     - 每个容器之间互相隔离，每个容器有自己的文件系统，容器之间进程不会相互影响，能区分计算资源。

-------------

- 开发/运维(DevOps):一次构建,随处运行
   - 更具啊的应用交付和部署
    - 更便捷的升级和扩缩性
    - 更简单的系统运维
    - 更高效的技算资源利用

--------------
- 企业级运用:

  - 微博

    ![微博1](img/weibo1.png)
    ![微博2](img/weibo2.png)

- 美团

  ​    ![美团](F:\myNoteMD\docker\img\meituan1.png)



### 3.去哪儿下载

- 官网:
  - docker官网:https://www.docker.com/
  - docker中文网站:https://www.docker-cn.com/
- 仓库:
  - docker hub:https://hub.docker.com/








## 二.Docker安装

### 1.前提条件

- Docker.支持以下的CentOS版本:CentOS 7 (64-bit)

- CentOS 6.5 (64-bit) 或更高的版本

- 前提条件

  - 目前，CentOS仅发行版本中的内核支持Docker。
  - Docker运行在CentOS 7上，要求系统为64位、系统内核版本为3.10以上。
  - Docker运行在CentOS-6.5或更高的版本的CentOS上，要求系统为64位、系统内核版本为2.6.32-431或者更高版本。

- 查看自己的内核

  - uname命令用于打印当前系统相关信息(内核版本号、硬件架构、主机名称和操作系统类型等)。

    ```shell
     uname -r
     cat /etc/redhat-release
    ```

    

### 2.docker的基本组成

- docker的架构图

![docker架构图](img/docker_jagou.png)


  - 镜像

    - Docker镜像(lmage) 就是一个只读的模板。镜像可以用来创建Docker容器,一个镜像可以创建很多容器

    - 镜像和容器的关系类似类与对象的关系:

        | Docker | 面向对象 |
        | ------ | -------- |
        | 容器   | 对象     |
        | 镜像   | 类       |

​      

  - 容器

       - Docker利用容器(Container) 独立运行的一个或一组应用。容器是用镜像创建的运行实例。

       - 它可以被启动、开始、停止、删除。每个容器都是相互隔离的、保证安全的平台。 

       - 可以把容器看做是一个简易版的Linux环境(包括root用户权限、进程空间、用户空间和网络空间等)和运行在其中的应用程序。

       - 容器的定义和镜像几乎一模一样，也是一堆层的统一视角， 唯一区别在于容器的最上面那一层是可读可写的。

      - 仓库

           - 仓库(Repository) 是集中存放镜像文件的场所。  
                 -  仓库(Repository)和仓库注册服务器(Registry) 是有区别的。仓库注册服务器上往往存放着多个仓库，每个仓库中又包含了多个镜像，每个镜像有不同的标签(tag)。  
                    -  仓库分为公开仓库(Public) 和私有仓库(Private) 两种形式。最大的公开仓库是Docker Hub(https://hub.docker.com),   存放了数量庞大的镜像供用户下载。国内的公开仓库包括阿里云、网易云等  

     - 总结

        -   仓储/镜像/容器的概念:
            -  Docker本身是一个容器运行载体或称之为管理引擎。我们把应用程序和配置依赖打包好形成一个可交付的运行环境，这个打包好的运行环境就似乎image镜像文件。只有通过这个镜像文件才能生成Docker容器。image文件可以看作是容器的模板。Docker根据image文件生成容器的实例。同一个image文件，可以生成多个同时运行的容器实例。
            - image文件生成的容器实例，本身也是一个文件，称为镜像文件。
            - 一个容器运行一种服务，当我们需要的时候，就可以通过docker客户端创建一个对应的运行实例，也就是我们的容器
            - 至于仓储，就是放了一堆镜像的地方，我们可以把镜像发布到仓储中，需要的时候从仓储中拉下来就可以了。

### 3.安装步骤

- CentOS6

  - `yum install -y epel-release`   (Docker使用EPEL发布, RHEL系的OS首先要确保持有EPEL仓库,否則先检査〇S的版本,然后安装相应的EPEL包。)  
  - `yum install -y docker-io` (安装)
  - 安装后的配置文件: `/etc/sysconfig/docker`
  - 启动Docker后台服务: `service docker start`
  - `docker version` 验证

- CentOS7

  - 参考官方文档:https://docs.docker.com/install/linux/docker-ce/centos/

  - 1.安装所需的包。`yum-utils`提供了`yum-config-manager` 效用，并`device-mapper-persistent-data`和`lvm2`由需要`devicemapper`存储驱动程序。 

    ```shell
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    ```

  - 2.使用以下命令设置**稳定**存储库。即使您还想从**边缘**或**测试**存储库安装构建，您始终需要**稳定的**存储 库。(<font color="red">大坑:改成阿里云或网易云</font>)

    ```shell
     sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo 
    ```

  - 3.安装*最新版本*的Docker CE 

    ```shell
    sudo yum install docker-ce
    ```

  - 启动 docker

    ```shell
     systemctl start docker
    ```

  - `docker`通过运行`hello-world` 镜像验证是否已正确安装。 

    ```shell
    sudo docker run hello-world
    ```



### 4.使用和优化

- 使用
  - run:  docker run xxx
- 优化
  - 阿里云加速:
  - 网易云加速:

### 5.底层原理

- Docker如何运行 

  - Docker是一个Client-Server结构的系统，Docker守护 进程运行在主机上，然后通过Socket连接从客户端访问，守护进程从客户端接受命令并管理运行在主机上的容器。容器，是一个运行时环境，就是我们前面说到的集装箱。 

    ```mermaid
    graph TD
    classDef de fill:#f30,stroke:#333,stroke-width:4px;
    classDef de1 fill:#9f2,stroke:#333,stroke-width:4px;
    classDef de2 fill:#f92,stroke:#333,stroke-width:4px;
    a1[client]
    a2[clinet]
    a3[....]
    subgraph 运行主机
    	b[后台守护进程]
    	subgraph Docker容器
            c1[tomcat]
            c2[spark]
            c3[mysql]
    	end
    end
    
    a1 --> b
    a2 --> b
    a3 --> b
    
    b --> c1
    b --> c2
    b --> c3
    
    
    class a1,a2,a3 de2
    class b de1
    class c1,c2,c3 de
    
    ```

    

- Docker比VM块

  - (1)docker有着比虚拟机更少的抽象层。由亍docker不需要Hypervisor实现硬件资源虚拟化,运行在docker容器上的程序直接使用的都是实际物理机的硬件资源。因此在CPU、内存利用率上docker将会在效率上有明显优势。

  - ​(2)docker利用的是宿主机的内核,而不需要Guest OS。因此，当新建一个容器时,docker不需要和虚拟机一样重新加载一个操作系统内核。仍而避免引寻、加载操作系统内核返个比较费时费资源的过程，当新建一个虚拟机时,虚拟机软件需要加载GuestOS,返个新建过程是分钟级别的。而docker由于直接利用宿主机的操作系统，则省略了返个过程，因此新建一个docker容器只需要几秒钟。     

      | #          | Docker容器              | 虚拟机(VM)                  |
      | ---------- | ----------------------- | --------------------------- |
      | 操作系统   | 与宿主机共享0S          | 宿主机OS上运行虚拟机OS      |
      | 存储大小   | 镜像小，便于存储与传输  | 镜像庞大(vmdk、vdi等)       |
      | 运行性能   | 几乎无额外性能损失      | 操作系统额外的CPU、内存消耗 |
      | 移植性     | 轻便、灵活，适应于Linux | 笨重，与虚拟化技术耦合度高  |
      | 硬件亲和性 | 面向软件开发者          | 面向硬件运维者              |

- dokcer容器

  ![docker容器](img/docker_ronqi.png)

- 虚拟机

  ![虚拟机](/img/xuniji.png)