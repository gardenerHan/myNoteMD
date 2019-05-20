#  获取请求参数解决java.io.IOException: Stream closed

现在开发的项目是基于SpringBoot的maven项目，拦截器的使用很多时候是必不可少的，当有需要需要你对body中的值进行校验，例如加密验签、防重复提交、内容校验等等。
当你开开心心的在拦截器中通过request.getInputStream();获取到body中的信息后，你会发现你在controller中使用了@RequestBody注解获取参数报如下错误：

```java
I/O error while reading input message; nested exception is java.io.IOException: Stream closed
org.springframework.http.converter.HttpMessageNotReadableException: I/O error while reading input message; nested exception is java.io.IOException: Stream closed
	at org.springframework.web.servlet.mvc.method.annotation.AbstractMessageConverterMethodArgumentResolver.readWithMessageConverters(AbstractMessageConverterMethodArgumentResolver.java:229)
	at org.springframework.web.servlet.mvc.method.annotation.RequestResponseBodyMethodProcessor.readWithMessageConverters(RequestResponseBodyMethodProcessor.java:150)
	at org.springframework.web.servlet.mvc.method.annotation.RequestResponseBodyMethodProcessor.resolveArgument(RequestResponseBodyMethodProcessor.java:128)
	at org.springframework.web.method.support.HandlerMethodArgumentResolverComposite.resolveArgument(HandlerMethodArgumentResolverComposite.java:121)
	at org.springframework.web.method.support.InvocableHandlerMethod.getMethodArgumentValues(InvocableHandlerMethod.java:158)
	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:128)
	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)
	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)
	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)
	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)
	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)
	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
	at org.springframework.boot.web.filter.ApplicationContextHeaderFilter.doFilterInternal(ApplicationContextHeaderFilter.java:55)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:96)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
	at org.springframework.boot.actuate.trace.WebRequestTraceFilter.doFilterInternal(WebRequestTraceFilter.java:110)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)

```

IO流关闭只能读取一次，接下来我们就开始解决这个BUG，有两种大的方向：

- 这个需求咱不做了，特么有本事就把东西都放在请求头里面传过来；
- 解决流只能读取一次的问题，让它可以被多次重复读取；(**最简单的方案就是 先读取流，然后在将流写进去就行了**)



## 1.HttpHelper （用于读取Body）

```java
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;

public class HttpHelper {
    public static String getBodyString(HttpServletRequest request) throws IOException {
        StringBuilder sb = new StringBuilder();
        InputStream inputStream = null;
        BufferedReader reader = null;
        try {
            inputStream = request.getInputStream();
            reader = new BufferedReader(new InputStreamReader(inputStream, Charset.forName("UTF-8")));
            String line = "";
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return sb.toString();
    }
}
```

## 2.RequestReaderHttpServletRequestWrapper（防止流丢失）

```java
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class RequestReaderHttpServletRequestWrapper extends HttpServletRequestWrapper{

    private final byte[] body;

    public RequestReaderHttpServletRequestWrapper(HttpServletRequest request) throws IOException {
        super(request);
        body = HttpHelper.getBodyString(request).getBytes(Charset.forName("UTF-8"));
    }

    @Override
    public BufferedReader getReader() throws IOException {
        return new BufferedReader(new InputStreamReader(getInputStream()));
    }

    @Override
    public ServletInputStream getInputStream() throws IOException {

        final ByteArrayInputStream bais = new ByteArrayInputStream(body);

        return new ServletInputStream() {

            @Override
            public int read() throws IOException {
                return bais.read();
            }

            @Override
            public boolean isFinished() {
                return false;
            }

            @Override
            public boolean isReady() {
                return false;
            }

            @Override
            public void setReadListener(ReadListener readListener) {

            }
        };
    }
}
```

## 3.HttpServletRequestReplacedFilter(过滤器)

```java
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


public class HttpServletRequestReplacedFilter implements Filter {
    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        ServletRequest requestWrapper = null;
        if(request instanceof HttpServletRequest) {
            requestWrapper = new RequestReaderHttpServletRequestWrapper((HttpServletRequest) request);
        }
        //获取请求中的流如何，将取出来的字符串，再次转换成流，然后把它放入到新request对象中。
        // 在chain.doFiler方法中传递新的request对象
        if(requestWrapper == null) {
            chain.doFilter(request, response);
        } else {
            chain.doFilter(requestWrapper, response);
        }
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {

    }
}
```

## 4.注入过滤器

```java
@Bean
public FilterRegistrationBean httpServletRequestReplacedRegistration() {
    FilterRegistrationBean registration = new FilterRegistrationBean();
    registration.setFilter(new HttpServletRequestReplacedFilter());
    registration.addUrlPatterns("/*");
    registration.addInitParameter("paramName", "paramValue");
    registration.setName("httpServletRequestReplacedFilter");
    registration.setOrder(1);
    return registration;
}
```

## 5.拦截器中获取body且保证了controller中依旧可以再次获取

```java
 HttpHelper.getBodyString(request);
```

