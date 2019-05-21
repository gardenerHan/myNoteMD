# 解决swagger2导致的NumberFormatException

## 1.在使用swagger2时，可能导致数字转化异常

- 给API的Long、Integer型参数添加`@ApiParam()`或`@ApiImplicitParam()`时,控制台报错`java.lang.NumberFormatException: For input string: ""`，即当在数字类型参数上使用`@ApiParam()`或`@ApiImplicitParam()`注解时，可能导致NumberFormatException

```java
Illegal DefaultValue null for parameter type integer java.lang.NumberFormatException: For input string: ""
	at java.lang.NumberFormatException.forInputString(NumberFormatException.java:65) ~[na:1.8.0_191]
	at java.lang.Long.parseLong(Long.java:601) ~[na:1.8.0_191]
	at java.lang.Long.valueOf(Long.java:803) ~[na:1.8.0_191]
	at 
//这句信息很重要
io.swagger.models.parameters.AbstractSerializableParameter.getExample(AbstractSerializableParameter.java:412) ~[swagger-models-1.5.20.jar:1.5.20]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:1.8.0_191]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:1.8.0_191]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:1.8.0_191]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[na:1.8.0_191]
	at com.fasterxml.jackson.databind.ser.BeanPropertyWriter.serializeAsField(BeanPropertyWriter.java:688) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.std.BeanSerializerBase.serializeFields(BeanSerializerBase.java:719) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.BeanSerializer.serialize(BeanSerializer.java:155) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serializeContents(IndexedListSerializer.java:119) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serialize(IndexedListSerializer.java:79) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.impl.IndexedListSerializer.serialize(IndexedListSerializer.java:18) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.BeanPropertyWriter.serializeAsField(BeanPropertyWriter.java:727) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.std.BeanSerializerBase.serializeFields(BeanSerializerBase.java:719) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.BeanSerializer.serialize(BeanSerializer.java:155) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.BeanPropertyWriter.serializeAsField(BeanPropertyWriter.java:727) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.std.BeanSerializerBase.serializeFields(BeanSerializerBase.java:719) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.BeanSerializer.serialize(BeanSerializer.java:155) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serializeFields(MapSerializer.java:722) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serialize(MapSerializer.java:643) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.std.MapSerializer.serialize(MapSerializer.java:33) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.BeanPropertyWriter.serializeAsField(BeanPropertyWriter.java:727) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.std.BeanSerializerBase.serializeFields(BeanSerializerBase.java:719) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.BeanSerializer.serialize(BeanSerializer.java:155) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider._serialize(DefaultSerializerProvider.java:480) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ser.DefaultSerializerProvider.serializeValue(DefaultSerializerProvider.java:319) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ObjectMapper._configAndWriteValue(ObjectMapper.java:3905) [jackson-databind-2.9.8.jar:2.9.8]
	at com.fasterxml.jackson.databind.ObjectMapper.writeValueAsString(ObjectMapper.java:3219) [jackson-databind-2.9.8.jar:2.9.8]
	at springfox.documentation.spring.web.json.JsonSerializer.toJson(JsonSerializer.java:38) [springfox-spring-web-2.9.2.jar:null]
	at springfox.documentation.swagger2.web.Swagger2Controller.getDocumentation(Swagger2Controller.java:105) [springfox-swagger2-2.9.2.jar:null]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:1.8.0_191]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:1.8.0_191]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:1.8.0_191]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[na:1.8.0_191]
	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:892) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:797) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:897) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:634) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882) [spring-webmvc-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53) [tomcat-embed-websocket-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at com.hgx.common.filter.HttpServletRequestReplacedFilter.doFilter(HttpServletRequestReplacedFilter.java:36) [classes/:na]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:92) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) [spring-web-5.1.6.RELEASE.jar:5.1.6.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:200) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:834) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1415) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [na:1.8.0_191]
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [na:1.8.0_191]
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61) [tomcat-embed-core-9.0.17.jar:9.0.17]
	at java.lang.Thread.run(Thread.java:748) [na:1.8.0_191]
```

## 2.异常分析

### 2.1 导致NumberFormatException异常代码

```java
// 代码片段 1
@ApiModelProperty(value = "起始页")
private Integer startPage;

@ApiModelProperty(value = "结束页")
private Integer endPage;

//代码片段 2 此处直接导致了异常的抛出
 public List<String> list(@ApiParam(value = "UA个数") @RequestParam Integer number) {
```

- ApiModelProperty 代码片段

```java
public @interface ApiModelProperty {
    //example 默认值为""
    String example() default "";
}
```

### 2.2  原因

有个默认值是空字符串的变量转换成`Integer`类型时异常。

```java
Illegal DefaultValue null for parameter type integer java.lang.NumberFormatException: For input string: ""
```

根据上面这句报错信息，点进去`AbstractSerializableParameter.java:412`:


```java
io.swagger.models.parameters.AbstractSerializableParameter.getExample(AbstractSerializableParameter.java:412) ~[swagger-models-1.5.20.jar:1.5.20]
```

查看getExample方法：就是说如果实体属性类型是`Integer`，就把`example`转为`Long`类型，而`example`默认为"",导致转换错误。同时也要注意number，boolean类型。

```java
public Object getExample() {
    if (this.example == null) {
        return null;
    } else {
        try {
            if ("integer".equals(this.type)) {
                return Long.valueOf(this.example);
            }

            if ("number".equals(this.type)) {
                return Double.valueOf(this.example);
            }

            if ("boolean".equals(this.type) && ("true".equalsIgnoreCase(this.example) || "false".equalsIgnoreCase(this.defaultValue))) {
                return Boolean.valueOf(this.example);
            }
        } catch (NumberFormatException var2) {
            LOGGER.warn(String.format("Illegal DefaultValue %s for parameter type %s", this.defaultValue, this.type), var2);
        }

        return this.example;
    }
}
```

## 3.解决方案

 - 方案1 ：实体类中，`Integer`类型的属性加`@ApiModelProperty`时，必须要给`example`参数赋值，且值必须为数字类型。number，boolean类型也需要关注下。

```java
// 代码片段 1
@ApiModelProperty(value = "起始页",example = "1")
private Integer startPage;

@ApiModelProperty(value = "结束页",example = "1")
private Integer endPage;

//代码片段 2 
 public List<String> list(@ApiParam(value = "UA个数",example = "1") @RequestParam Integer number) {
```

- 方案2 ：将swagger的级别设置为error（不太推荐）

```properties
logging.level.io.swagger.models.parameters.AbstractSerializableParameter=ERROR
```

- 方案3：升级jar包，排除springfox-swagger2 引入的swagger-annotations、swagger-models 1.5.20版本，手动引入1.5.21版本的jar。

```xml
<dependency>      
	<groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.9.2</version>
    <exclusions>
        <exclusion>
            <groupId>io.swagger</groupId>
            <artifactId>swagger-annotations</artifactId>
        </exclusion>
        <exclusion>
            <groupId>io.swagger</groupId>
            <artifactId>swagger-models</artifactId>
        </exclusion>
    </exclusions>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.9.2</version>
</dependency>
<dependency>
    <groupId>io.swagger</groupId>
    <artifactId>swagger-annotations</artifactId>
    <version>1.5.21</version>
</dependency>
<dependency>
    <groupId>io.swagger</groupId>
    <artifactId>swagger-models</artifactId>
    <version>1.5.21</version>
</dependency>
```

- 在1.5.21中，AbstractSerializableParameter的getExample方法，修改了代码，避免了example=""抛出NumberFormatException异常。

```java
public Object getExample() {
    if (this.example != null && !this.example.isEmpty()) {
        try {
            if ("integer".equals(this.type)) {
                return Long.valueOf(this.example);
            }

            if ("number".equals(this.type)) {
                return Double.valueOf(this.example);
            }

            if ("boolean".equals(this.type) && ("true".equalsIgnoreCase(this.example) || "false".equalsIgnoreCase(this.defaultValue))) {
                return Boolean.valueOf(this.example);
            }
        } catch (NumberFormatException var2) {
            LOGGER.warn(String.format("Illegal DefaultValue %s for parameter type %s", this.defaultValue, this.type), var2);
        }

        return this.example;
    } else {
        return this.example;
    }
}
```




