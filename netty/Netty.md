# Netty



<font color="green">*@Author:hanguixian*</font> 

<font color="green">*@Email:hn_hanguixian@163.com*</font>   



## 一 Netty简介

- Netty 是由 JBOSS 提供的一个 java 开源框架。Netty 提供异步的、事件驱动的网络应用 程序框架和工具，用以快速开发高性能、高可靠性的网络服务器和客户端程序。 
- 也就是说，Netty 是一个基于 NIO 的客户、服务器端编程框架，使用 Netty 可以确保你 快速和简单的开发出一个网络应用，例如实现了某种协议的客户，服务端应用。Netty 相当 简化和流线化了网络应用的编程开发过程，例如，TCP 和 UDP 的 socket 服务开发。 
- “快速”和“简单”并不用产生维护性或性能上的问题。Netty 是一个吸收了多种协议的实 现经验，这些协议包括 FTP,SMTP,HTTP，各种二进制，文本协议，并经过相当精心设计的项 目，最终，Netty 成功的找到了一种方式，在保证易于开发的同时还保证了其应用的性能， 稳定性和伸缩性。 
- Netty 从 4.x 版本开始，需要使用 JDK1.6 及以上版本提供基础支撑。 
- 在设计上：针对多种传输类型的统一接口 - 阻塞和非阻塞；简单但更强大的线程模型； 真正的无连接的数据报套接字支持；链接逻辑支持复用； 
- 在性能上：比核心 Java API 更好的吞吐量，较低的延时；资源消耗更少，这个得益于 共享池和重用；减少内存拷贝 
- 在健壮性上：消除由于慢，快，或重载连接产生的 OutOfMemoryError；消除经常发现在NIO 在高速网络中的应用中的不公平的读/写比 
- 在安全上：完整的 SSL / TLS 和 StartTLS 的支持 
- 且已得到大量商业应用的真实验证,如：Hadoop 项目的 Avro（RPC 框架）、Dubbo、Dubbox等 RPC 框架。 
- Netty 的官网是：http://netty.io 
- 有 三 方 提 供 的 中 文 翻 译 Netty 用 户 手 册 （ 官 网 提 供 源 信 息 ）： http://ifeve.com/netty5-user-guide/ 


##  二 Netty架构

![img](img/components.png) 

