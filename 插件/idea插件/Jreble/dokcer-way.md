# 撸了个反代工具, 可用于激活JRebel



下载地址:
<https://github.com/ilanyu/ReverseProxy/releases/latest>

使用方法:

```
./ReverseProxy_[OS]_[ARCH] -h

Usage of ReverseProxy_[OS]_[ARCH]:
  -l string
        listen on ip:port (default "0.0.0.0:8888")
  -r string
        reverse proxy addr (default "http://idea.lanyus.com:80")
```

```
./ReverseProxy_windows_amd64.exe -l "0.0.0.0:8081" -r "https://www.baidu.com"

Listening on 0.0.0.0:8081, forwarding to https://www.baidu.com
```

默认反代idea.lanyus.com, 运行起来后, [http://127.0.0.1](http://127.0.0.1/):8888/JRebel用户名 就是激活地址了, 邮箱随意填写, 当然, 也可用于idea

也可以在Docker中使用

```
docker pull ilanyu/golang-reverseproxy

docker run -d -p 8888:8888 ilanyu/golang-reverseproxy
```