# 持续集成工具Jenkins



<font color="green">*@Author:hanguixian*</font> 

<font color="green">*@Email:hn_hanguixian@163.com*<font>    



jenkins官网：https://jenkins.io/zh/

Jenkins文档：https://jenkins.io/zh/doc/



## 一  Jenkins及自动化介绍

### 1 Jenkins 和 Hudson 

- 目前最流行的一款持续集成及自动化部署工具。 

- Jenkins 和 Hundson 之间的关系：2009 年，甲骨文收购了 Sun 并继承了 Hudson 代 码库。在 2011 年年初，甲骨文和开源社区之间的关系破裂，该项目被分成两个独立的 项目： 

  - Jenkins：由大部分原始开发人员组成 
  - Hudson：由甲骨文公司继续管理 所以 Jenkins 和 Hudson 是两款非常相似的产品。

### 2 技术组合 

  - Jenkins 可以整合 GitHub 或 Subversion 
  - Husband 也可以整合 GitHub 或 Subversion 
  - 二者既然是同源的工具软件，操作和指导思想是接近的

### 3 JavaEE 项目部署方式对比

#### 3.1  手动部署

![手动部署](img/手动部署.png)

#### 3.2 自动化部署  

 “自动化”的具体体现：向版本库提交新的代码后，应用服务器上自动部署，用户或测试人员使用的马上就是最新的应用程序。

![自动化部署](img/自动化部署.png)

- 持续集成环境可以把整个构建、部署过程自动化，很大程度上减轻工作量。 对于程序员的日常开发来说不会造成任何额外负担——自己把代码提交上去之后，服务器上运行的马上就是最新版本——一切都发生在无形中。 
- 持续集成环境需要具备以下知识
  - Linux 基本操作命令和 VIM 编辑器使用
  - Maven 的项目构建管理 
  -  GitHub 或 SVN 使用

