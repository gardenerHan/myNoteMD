# Nginx

*@Author:hanguixian*

*@Email:hn_hanguixian@163.com*

## 安装nginx

- nginx的安装方式可能不同，具体取决于操作系统。 

### 在Linux上安装

- 对于Linux， 可以使用nginx.org中的nginx [包](http://nginx.org/en/linux_packages.html)。 

### 在FreeBSD上安装

- 在FreeBSD上，可以从[软件包](http://www.freebsd.org/doc/handbook/pkgng-intro.html) 或通过 [ports](http://www.freebsd.org/doc/handbook/ports-using.html) 系统安装nginx 。ports系统提供了更大的灵活性，允许在众多选项中进行选择。该端口将使用指定的选项编译nginx并安装它。 

### 从源头构建

- 如果需要一些特殊功能，包和端口不可用，也可以从源文件编译nginx。虽然更灵活，但这种方法对初学者来说可能很复杂。有关更多信息，请参阅[从源构建nginx](http://nginx.org/en/docs/configure.html)。

## 初学者指南

- nginx有一个主进程和几个工作进程。主进程的主要目的是读取和评估配置，并维护工作进程。工作进程会对请求进行实际处理。nginx使用基于事件的模型和依赖于操作系统的机制来有效地在工作进程之间分发请求。工作进程数在配置文件中定义，可以针对给定配置进行修复，也可以自动调整为可用CPU内核数（请参阅[worker_processes](http://nginx.org/en/docs/ngx_core_module.html#worker_processes)）。

  

- nginx及其模块的工作方式在配置文件中确定。默认情况下，配置文件被命名`nginx.conf` 并放在目录`/usr/local/nginx/conf`中 `/etc/nginx`，或 `/usr/local/etc/nginx`。

### 启动，停止和重新加载配置

- 要启动nginx，请运行可执行文件。启动nginx后，可以通过使用`-s`参数调用可执行文件来控制它。使用以下语法：

> ```
> nginx -s signal
> ```

- 当`signal`可以是下列之一：
  - `stop` - 快速关机

  - `quit` - 优雅的关机

  - `reload` - 重新加载配置文件

  - `reopen` - 重新打开日志文件

    

- 例如，要在等待工作进程完成当前请求的服务时停止nginx进程，可以执行以下命令：

> ```
> nginx -s quit
> ```

> 此命令应在启动nginx的同一用户下执行。

在将重新加载配置的命令发送到nginx或重新启动之前，将不会应用配置文件中所做的更改。要重新加载配置，请执行：

> ```
> nginx -s reload
> ```

一旦主进程收到重新加载配置的信号，它将检查新配置文件的语法有效性并尝试应用其中提供的配置。如果成功，主进程将启动新的工作进程并向旧工作进程发送消息，请求它们关闭。否则，主进程将回滚更改并继续使用旧配置。旧工作进程，接收命令关闭，停止接受新连接并继续为当前请求提供服务，直到所有此类请求都得到服务。之后，旧工作进程退出。

也可以借助Unix工具（如`kill`实用程序）将信号发送到nginx进程。在这种情况下，信号直接发送到具有给定进程ID的进程。默认情况下，nginx主进程的进程ID写入 `nginx.pid`目录 `/usr/local/nginx/logs`或 `/var/run`。例如，如果主进程ID是1628，要发送导致nginx正常关闭的QUIT信号，请执行：

> ```
> kill -s QUIT 1628
> ```

要获取所有正在运行的nginx进程的列表，`ps` 可以使用该实用程序，例如，通过以下方式：

> ```
> ps -ax | grep nginx
> ```

有关向nginx发送信号的更多信息，请参阅 [控制nginx](http://nginx.org/en/docs/control.html)。