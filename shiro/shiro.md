# shiro

## 一 Shiro 简介

-  Apache Shiro 是 Java  的一个安全（权限）框架。 •
- Shiro 可以非常容易的开发出足够好的应用，其不仅可以用在 JavaSE 环境，也可以用在 JavaEE 环境。 
- Shiro 可以完成：认证、授权、加密、会话管理、与Web 集成、缓存 等。 •
- 下载：http://shiro.apache.org/

### 1.1  [什么是Apache Shiro？](http://shiro.apache.org/introduction.html#what-is-apache-shiro-)

Apache Shiro是一个功能强大且灵活的开源安全框架，可以清晰地处理身份验证，授权，企业会话管理和加密。

Apache Shiro的首要目标是易于使用和理解。安全有时可能非常复杂，甚至是痛苦的，但并非必须如此。框架应尽可能掩盖复杂性，并提供简洁直观的API，以简化开发人员确保其应用程序安全的工作。

以下是Apache Shiro可以做的一些事情：

- 验证用户以验证其身份
- 为用户执行访问控制，例如：
  - 确定是否为用户分配了某个安全角色
  - 确定是否允许用户执行某些操作
- 在任何环境中使用Session API，即使没有Web容器或EJB容器也是如此。
- 在身份验证，访问控制或会话生命周期内对事件做出反应。
- 聚合用户安全数据的1个或多个数据源，并将其全部显示为单个复合用户“视图”。
- 启用单点登录（SSO）功能
- 无需登录即可为用户关联启用“记住我”服务
  ...... 
  以及更多 - 全部集成到一个易于使用的内聚API中。

Shiro尝试为所有应用程序环境实现这些目标 - 从最简单的命令行应用程序到最大的企业应用程序，而不强制依赖其他第三方框架，容器或应用程序服务器。当然，该项目旨在尽可能地融入这些环境，但它可以在任何环境中开箱即用。

### 1.2  [Apache Shiro功能](http://shiro.apache.org/introduction.html#apache-shiro-features)

Apache Shiro是一个具有许多功能的综合应用程序安全框架。

![ShiroFeatures.png](img/ShiroFeatures.png)

-  Authentication：身份认证/登录，验证用户是不是拥有相应的身份； •
- Authorization：授权，即权限验证，验证某个已认证的用户是否拥有某个权限；即判断用 户是否能进行什么操作，如：验证某个用户是否拥有某个角色。或者细粒度的验证某个用户 对某个资源是否具有某个权限； •
- Session Manager：会话管理，即用户登录后就是一次会话，在没有退出之前，它的所有 信息都在会话中；会话可以是普通 JavaSE 环境，也可以是 Web 环境的； 
- Cryptography：加密，保护数据的安全性，如密码加密存储到数据库，而不是明文存储； 
- Web Support：Web 支持，可以非常容易的集成到Web 环境； 
- Caching：缓存，比如用户登录后，其用户信息、拥有的角色/权限不必每次去查，这样可 以提高效率
- Concurrency：Shiro 支持多线程应用的并发验证，即如在一个线程中开启另一个线程，能把权限自动传播过去； 
- Testing：提供测试支持； • Run As：允许一个用户假装为另一个用户（如果他们允许）的身份进行访问
- Remember Me：记住我，这个是非常常见的功能，即一次登录后，下次再来的话不用登 录了

## 二 Shiro 架构

### 2.1 简单概述

**从外部来看Shiro ，即从应用程序角度的来观察如何使用 Shiro完成工作，Shiro的架构有3个主要概念：`Subject`，`SecurityManager`和`Realms`。**

![ShiroBasicArchitecture](img/ShiroBasicArchitecture.png)

-  Subject：应用代码直接交互的对象是 Subject，也就是说 Shiro 的对外 API 核心就是 Subject。Subject 代表了当前“用户”， 这个用户不一定 是一个具体的人，与当前应用交互的任何东西都是 Subject，如网络爬虫， 机器人等；与 Subject  的所有交互都会委托给 SecurityManager； Subject 其实是一个门面，SecurityManager 才是实际的执行者；
- SecurityManager：安全管理器；即所有与安全有关的操作都会与 SecurityManager 交互；且其管理着所有 Subject；可以看出它是 Shiro 的核心，它负责与 Shiro 的其他组件进行交互，它相当于 SpringMVC 中 DispatcherServlet 的角色
- Realm：Shiro 从 Realm 获取安全数据（如用户、角色、权限），就是说 SecurityManager 要验证用户身份，那么它需要从 Realm 获取相应的用户 进行比较以确定用户身份是否合法；也需要从 Realm 得到用户相应的角色/ 权限进行验证用户是否能进行操作；可以把 Realm 看成 DataSource

### 2.2 [详细的架构](http://shiro.apache.org/architecture.html#detailed-architecture)

![ShiroArchitecture.png](img/ShiroArchitecture.png)

- Subject：任何可以与应用交互的“用户”； 
- SecurityManager ：相当于SpringMVC 中的 DispatcherServlet；是 Shiro 的心脏； 所有具体的交互都通过 SecurityManager 进行控制；它管理着所有 Subject、且负责进 行认证、授权、会话及缓存的管理。 
- Authenticator：认证器，负责 Subject 认证，是一个扩展点，可以自定义实现；可以使用认证 策略（Authentication Strategy），即什么情况下算用户认证通过了； 
- Authorizer：授权器、即访问控制器，用来决定主体是否有权限进行相应的操作；即控 制着用户能访问应用中的哪些功能； 
- Realm：可以有 1 个或多个 Realm，可以认为是安全实体数据源，即用于获取安全实体 的；可以是JDBC 实现，也可以是内存实现等等；由用户提供；所以一般在应用中都需要 实现自己的 Realm； 
- SessionManager：管理 Session 生命周期的组件；而 Shiro 并不仅仅可以用在 Web 环境，也可以用在如普通的 JavaSE 环境 
- CacheManager：缓存控制器，来管理如用户、角色、权限等的缓存的；因为这些数据 基本上很少改变，放到缓存中后可以提高访问的性能 
- Cryptography：密码模块，Shiro 提高了一些常见的加密组件用于如密码加密/解密。

## 三 开始Shiro:Hello World

- 该代码来自官网下载的压缩zip

- 项目结构图

![helloWorld项目结构.png](img/helloWorld项目结构.png)

- maven：pom.xml

```xml
<dependencies>
    <!-- https://mvnrepository.com/artifact/org.apache.shiro/shiro-core -->
    <dependency>
        <groupId>org.apache.shiro</groupId>
        <artifactId>shiro-core</artifactId>
        <version>1.4.0</version>
    </dependency>

    <!-- configure logging -->
    <!-- https://mvnrepository.com/artifact/org.slf4j/jcl-over-slf4j -->
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>jcl-over-slf4j</artifactId>
        <version>1.7.25</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-log4j12 -->
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-log4j12</artifactId>
        <version>1.7.25</version>
        <!--<scope>test</scope>-->
    </dependency>

    <!-- https://mvnrepository.com/artifact/log4j/log4j -->
    <dependency>
        <groupId>log4j</groupId>
        <artifactId>log4j</artifactId>
        <version>1.2.17</version>
    </dependency>

    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.11</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

- Quickstart.java

```java
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.Factory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * Simple Quickstart application showing how to use Shiro's API.
 *
 * @since 0.9 RC2
 */
public class Quickstart {

    private static final transient Logger log = LoggerFactory.getLogger(Quickstart.class);

    public static void main(String[] args) {

        // The easiest way to create a Shiro SecurityManager with configured
        // realms, users, roles and permissions is to use the simple INI config.
        // We'll do that by using a factory that can ingest a .ini file and
        // return a SecurityManager instance:

        // Use the shiro.ini file at the root of the classpath
        // (file: and url: prefixes load from files and urls respectively):
        Factory<SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro.ini");
        SecurityManager securityManager = factory.getInstance();

        // for this simple example quickstart, make the SecurityManager
        // accessible as a JVM singleton.  Most applications wouldn't do this
        // and instead rely on their container configuration or web.xml for
        // webapps.  That is outside the scope of this simple quickstart, so
        // we'll just do the bare minimum so you can continue to get a feel
        // for things.
        SecurityUtils.setSecurityManager(securityManager);

        // Now that a simple Shiro environment is set up, let's see what you can do:

        // get the currently executing user:
        // 获取当前的 Subject. 调用 SecurityUtils.getSubject();
        Subject currentUser = SecurityUtils.getSubject();

        // Do some stuff with a Session (no need for a web or EJB container!!!)
        // 测试使用 Session
        // 获取 Session: Subject#getSession()
        Session session = currentUser.getSession();
        session.setAttribute("someKey", "aValue");
        String value = (String) session.getAttribute("someKey");
        if (value.equals("aValue")) {
            log.info("---> Retrieved the correct value! [" + value + "]");
        }

        // let's login the current user so we can check against roles and permissions:
        // 测试当前的用户是否已经被认证. 即是否已经登录.
        // 调动 Subject 的 isAuthenticated()
        if (!currentUser.isAuthenticated()) {
            // 把用户名和密码封装为 UsernamePasswordToken 对象
            UsernamePasswordToken token = new UsernamePasswordToken("lonestarr", "vespa");
            // rememberme
            token.setRememberMe(true);
            try {
                // 执行登录.
                currentUser.login(token);
            }
            // 若没有指定的账户, 则 shiro 将会抛出 UnknownAccountException 异常.
            catch (UnknownAccountException uae) {
                log.info("----> There is no user with username of " + token.getPrincipal());
                return;
            }
            // 若账户存在, 但密码不匹配, 则 shiro 会抛出 IncorrectCredentialsException 异常。
            catch (IncorrectCredentialsException ice) {
                log.info("----> Password for account " + token.getPrincipal() + " was incorrect!");
                return;
            }
            // 用户被锁定的异常 LockedAccountException
            catch (LockedAccountException lae) {
                log.info("The account for username " + token.getPrincipal() + " is locked.  " +
                        "Please contact your administrator to unlock it.");
            }
            // ... catch more exceptions here (maybe custom ones specific to your application?
            // 所有认证时异常的父类.
            catch (AuthenticationException ae) {
                //unexpected condition?  error?
            }
        }

        //say who they are:
        //print their identifying principal (in this case, a username):
        log.info("----> User [" + currentUser.getPrincipal() + "] logged in successfully.");

        //test a role:
        // 测试是否有某一个角色. 调用 Subject 的 hasRole 方法.
        if (currentUser.hasRole("schwartz")) {
            log.info("----> May the Schwartz be with you!");
        } else {
            log.info("----> Hello, mere mortal.");
            return;
        }

        //test a typed permission (not instance-level)
        // 测试用户是否具备某一个行为. 调用 Subject 的 isPermitted() 方法。
        if (currentUser.isPermitted("lightsaber:weild")) {
            log.info("----> You may use a lightsaber ring.  Use it wisely.");
        } else {
            log.info("Sorry, lightsaber rings are for schwartz masters only.");
        }

        //a (very powerful) Instance Level permission:
        // 测试用户是否具备某一个行为.
        if (currentUser.isPermitted("user:delete:zhangsan")) {
            log.info("----> You are permitted to 'drive' the winnebago with license plate (id) 'eagle5'.  " +
                    "Here are the keys - have fun!");
        } else {
            log.info("Sorry, you aren't allowed to drive the 'eagle5' winnebago!");
        }

        //all done - log out!
        // 执行登出. 调用 Subject 的 Logout() 方法.
        System.out.println("---->" + currentUser.isAuthenticated());

        currentUser.logout();

        System.out.println("---->" + currentUser.isAuthenticated());

        System.exit(0);
    }
}
```

- log4j.properties

```properties
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
log4j.rootLogger=INFO, stdout

log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d %p [%c] - %m %n

# General Apache libraries
log4j.logger.org.apache=WARN

# Spring
log4j.logger.org.springframework=WARN

# Default Shiro logging
log4j.logger.org.apache.shiro=TRACE

# Disable verbose logging
log4j.logger.org.apache.shiro.util.ThreadContext=WARN
log4j.logger.org.apache.shiro.cache.ehcache.EhCache=WARN
```

- shiro.ini

```ini
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# =============================================================================
# Quickstart INI Realm configuration
#
# For those that might not understand the references in this file, the
# definitions are all based on the classic Mel Brooks' film "Spaceballs". ;)
# =============================================================================

# -----------------------------------------------------------------------------
# Users and their assigned roles
#
# Each line conforms to the format defined in the
# org.apache.shiro.realm.text.TextConfigurationRealm#setUserDefinitions JavaDoc
# -----------------------------------------------------------------------------
[users]
# user 'root' with password 'secret' and the 'admin' role
root = secret, admin
# user 'guest' with the password 'guest' and the 'guest' role
guest = guest, guest
# user 'presidentskroob' with password '12345' ("That's the same combination on
# my luggage!!!" ;)), and role 'president'
presidentskroob = 12345, president
# user 'darkhelmet' with password 'ludicrousspeed' and roles 'darklord' and 'schwartz'
darkhelmet = ludicrousspeed, darklord, schwartz
# user 'lonestarr' with password 'vespa' and roles 'goodguy' and 'schwartz'
lonestarr = vespa, goodguy, schwartz

# -----------------------------------------------------------------------------
# Roles with assigned permissions
# 
# Each line conforms to the format defined in the
# org.apache.shiro.realm.text.TextConfigurationRealm#setRoleDefinitions JavaDoc
# -----------------------------------------------------------------------------
[roles]
# 'admin' role has all permissions, indicated by the wildcard '*'
admin = *
# The 'schwartz' role can do anything (*) with any lightsaber:
schwartz = lightsaber:*
# The 'goodguy' role is allowed to 'drive' (action) the winnebago (type) with
# license plate 'eagle5' (instance specific id)
goodguy = winnebago:drive:eagle5
```



## 四 集成 Spring

### 4.1 框架基本整合

- maven依赖：pom.xml

```xml
<!-- 依赖的jar包 -->
<dependencies>
    <!-- https://mvnrepository.com/artifact/org.apache.shiro/shiro-spring -->
    <dependency>
        <groupId>org.apache.shiro</groupId>
        <artifactId>shiro-spring</artifactId>
        <version>1.4.0</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/org.apache.shiro/shiro-ehcache -->
    <dependency>
        <groupId>org.apache.shiro</groupId>
        <artifactId>shiro-ehcache</artifactId>
        <version>1.4.0</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/net.sf.ehcache/ehcache-core -->
    <dependency>
        <groupId>net.sf.ehcache</groupId>
        <artifactId>ehcache-core</artifactId>
        <version>2.6.11</version>
    </dependency>

    <!-- configure logging -->
    <!-- https://mvnrepository.com/artifact/org.slf4j/jcl-over-slf4j -->
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>jcl-over-slf4j</artifactId>
        <version>1.7.25</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-log4j12 -->
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-log4j12</artifactId>
        <version>1.7.25</version>
        <!--<scope>test</scope>-->
    </dependency>

    <!-- https://mvnrepository.com/artifact/log4j/log4j -->
    <dependency>
        <groupId>log4j</groupId>
        <artifactId>log4j</artifactId>
        <version>1.2.17</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/org.springframework/spring-context -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
        <version>5.1.4.RELEASE</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-web -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-web</artifactId>
        <version>5.1.4.RELEASE</version>
    </dependency>
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>5.1.4.RELEASE</version>
    </dependency>

    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.11</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

- web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">

    <!-- 配置 Spring 配置文件的名称和位置 -->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext.xml</param-value>
    </context-param>

    <!-- Bootstraps the root web application context before servlet initialization -->
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>


    <!-- 启动 IOC 容器的 ServletContextListener -->
    <servlet>
        <servlet-name>springMVC</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:spring-servlet.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>

    <!-- Map all requests to the DispatcherServlet for handling -->
    <servlet-mapping>
        <servlet-name>springMVC</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>


    <!-- ==================================================================
         Filters
         ================================================================== -->
    <!-- Shiro Filter is defined in the spring application context: -->

    <!-- Shiro Filter is defined in the spring application context: -->
    <!--
    1. 配置  Shiro 的 shiroFilter.
    2. DelegatingFilterProxy 实际上是 Filter 的一个代理对象. 默认情况下, Spring 会到 IOC 容器中查找和
    <filter-name> 对应的 filter bean. 也可以通过 targetBeanName 的初始化参数来配置 filter bean 的 id.
    -->
    <filter>
        <filter-name>shiroFilter</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
        <init-param>
            <param-name>targetFilterLifecycle</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>

    <filter-mapping>
        <filter-name>shiroFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

</web-app>
```

- spring配置文件：applicationContext.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <!-- =========================================================
         Shiro Core Components - Not Spring Specific
         ========================================================= -->
    <!-- Shiro's main business-tier object for web-enabled applications
         (use DefaultSecurityManager instead when there is no web environment)-->
    <!--
    1. 配置 SecurityManager!
    -->
    <bean id="securityManager" class="org.apache.shiro.web.mgt.DefaultWebSecurityManager">
        <property name="cacheManager" ref="cacheManager"/>
        <property name="realm" ref="jdbcRealm"></property>
    </bean>

    <!-- Let's use some enterprise caching support for better performance.  You can replace this with any enterprise
         caching framework implementation that you like (Terracotta+Ehcache, Coherence, GigaSpaces, etc -->
    <!--
    2. 配置 CacheManager.
    2.1 需要加入 ehcache 的 jar 包及配置文件.
    -->
    <bean id="cacheManager" class="org.apache.shiro.cache.ehcache.EhCacheManager">
        <!-- Set a net.sf.ehcache.CacheManager instance here if you already have one.  If not, a new one
             will be creaed with a default config:
             <property name="cacheManager" ref="ehCacheManager"/> -->
        <!-- If you don't have a pre-built net.sf.ehcache.CacheManager instance to inject, but you want
             a specific Ehcache configuration to be used, specify that here.  If you don't, a default
             will be used.: -->
        <property name="cacheManagerConfigFile" value="classpath:ehcache.xml"/>
    </bean>

    <bean id="authenticator"
          class="org.apache.shiro.authc.pam.ModularRealmAuthenticator">
        <property name="authenticationStrategy">
            <bean class="org.apache.shiro.authc.pam.AtLeastOneSuccessfulStrategy"></bean>
        </property>
    </bean>

    <!-- Used by the SecurityManager to access security data (users, roles, etc).
         Many other realm implementations can be used too (PropertiesRealm,
         LdapRealm, etc. -->
    <!--
    	3. 配置 Realm
    	3.1 直接配置实现了 org.apache.shiro.realm.Realm 接口的 bean
    -->
    <bean id="jdbcRealm" class="com.hgx.shiro.spring.ShiroRealm"></bean>

    <!-- =========================================================
         Shiro Spring-specific integration
         ========================================================= -->
    <!-- Post processor that automatically invokes init() and destroy() methods
         for Spring-configured Shiro objects so you don't have to
         1) specify an init-method and destroy-method attributes for every bean
            definition and
         2) even know which Shiro objects require these methods to be
            called. -->
    <!--
    4. 配置 LifecycleBeanPostProcessor. 可以自定的来调用配置在 Spring IOC 容器中 shiro bean 的生命周期方法.
    -->
    <bean id="lifecycleBeanPostProcessor" class="org.apache.shiro.spring.LifecycleBeanPostProcessor"/>

    <!-- Enable Shiro Annotations for Spring-configured beans.  Only run after
         the lifecycleBeanProcessor has run: -->
    <!--
    5. 启用 IOC 容器中使用 shiro 的注解. 但必须在配置了 LifecycleBeanPostProcessor 之后才可以使用.
    -->
    <bean class="org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator"
          depends-on="lifecycleBeanPostProcessor"/>
    <bean class="org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor">
        <property name="securityManager" ref="securityManager"/>
    </bean>

    <!-- Define the Shiro Filter here (as a FactoryBean) instead of directly in web.xml -
         web.xml uses the DelegatingFilterProxy to access this bean.  This allows us
         to wire things with more control as well utilize nice Spring things such as
         PropertiesPlaceholderConfigurer and abstract beans or anything else we might need: -->
    <!--
    6. 配置 ShiroFilter.
    6.1 id 必须和 web.xml 文件中配置的 DelegatingFilterProxy 的 <filter-name> 一致.若不一致, 则会抛出: NoSuchBeanDefinitionException. 因为 Shiro 会来 IOC 容器中查找和 <filter-name> 名字对应的 filter bean.
    -->
    <bean id="shiroFilter" class="org.apache.shiro.spring.web.ShiroFilterFactoryBean">
        <property name="securityManager" ref="securityManager"/>
        <property name="loginUrl" value="/login.jsp"/>
        <property name="successUrl" value="/list.jsp"/>
        <property name="unauthorizedUrl" value="/unauthorized.jsp"/>
        <!--
        	配置哪些页面需要受保护.
        	以及访问这些页面需要的权限.
        	1). anon 可以被匿名访问
        	2). authc 必须认证(即登录)后才可能访问的页面.
        	3). logout 登出.
        	4). roles 角色过滤器
        -->
        <property name="filterChainDefinitions">
            <value>
                /login.jsp = anon
                # everything else requires authentication:
                /** = authc
            </value>
        </property>
    </bean>
</beans>
```

- 缓存配置：ehcache.xml

```xml
<!--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~     http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  -->

<!-- EhCache XML configuration file used for Shiro spring sample application -->
<ehcache>

    <!-- Sets the path to the directory where cache .data files are created.

If the path is a Java System Property it is replaced by
its value in the running VM.

The following properties are translated:
user.home - User's home directory
user.dir - User's current working directory
java.io.tmpdir - Default temp file path -->
    <diskStore path="java.io.tmpdir/shiro-spring-sample"/>


    <!--Default Cache configuration. These will applied to caches programmatically created through
    the CacheManager.

    The following attributes are required:

    maxElementsInMemory            - Sets the maximum number of objects that will be created in memory
    eternal                        - Sets whether elements are eternal. If eternal,  timeouts are ignored and the
                                     element is never expired.
    overflowToDisk                 - Sets whether elements can overflow to disk when the in-memory cache
                                     has reached the maxInMemory limit.

    The following attributes are optional:
    timeToIdleSeconds              - Sets the time to idle for an element before it expires.
                                     i.e. The maximum amount of time between accesses before an element expires
                                     Is only used if the element is not eternal.
                                     Optional attribute. A value of 0 means that an Element can idle for infinity.
                                     The default value is 0.
    timeToLiveSeconds              - Sets the time to live for an element before it expires.
                                     i.e. The maximum time between creation time and when an element expires.
                                     Is only used if the element is not eternal.
                                     Optional attribute. A value of 0 means that and Element can live for infinity.
                                     The default value is 0.
    diskPersistent                 - Whether the disk store persists between restarts of the Virtual Machine.
                                     The default value is false.
    diskExpiryThreadIntervalSeconds- The number of seconds between runs of the disk expiry thread. The default value
                                     is 120 seconds.
    memoryStoreEvictionPolicy      - Policy would be enforced upon reaching the maxElementsInMemory limit. Default
                                     policy is Least Recently Used (specified as LRU). Other policies available -
                                     First In First Out (specified as FIFO) and Less Frequently Used
                                     (specified as LFU)
    -->

    <defaultCache
            maxElementsInMemory="10000"
            eternal="false"
            timeToIdleSeconds="120"
            timeToLiveSeconds="120"
            overflowToDisk="false"
            diskPersistent="false"
            diskExpiryThreadIntervalSeconds="120"
            />

    <!-- We want eternal="true" (with no timeToIdle or timeToLive settings) because Shiro manages session
expirations explicitly.  If we set it to false and then set corresponding timeToIdle and timeToLive properties,
ehcache would evict sessions without Shiro's knowledge, which would cause many problems
(e.g. "My Shiro session timeout is 30 minutes - why isn't a session available after 2 minutes?"
Answer - ehcache expired it due to the timeToIdle property set to 120 seconds.)

diskPersistent=true since we want an enterprise session management feature - ability to use sessions after
even after a JVM restart.  -->
    <cache name="shiro-activeSessionCache"
           maxElementsInMemory="10000"
           eternal="true"
           overflowToDisk="true"
           diskPersistent="true"
           diskExpiryThreadIntervalSeconds="600"/>

    <cache name="org.apache.shiro.realm.SimpleAccountRealm.authorization"
           maxElementsInMemory="100"
           eternal="false"
           timeToLiveSeconds="600"
           overflowToDisk="false"/>

</ehcache>
```

- 日志log4j配置：log4j.properties

```properties
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
log4j.rootLogger=INFO, stdout

log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d %p [%c] - %m %n

# General Apache libraries
log4j.logger.org.apache=WARN

# Spring
log4j.logger.org.springframework=WARN

# Default Shiro logging
log4j.logger.org.apache.shiro=TRACE

# Disable verbose logging
log4j.logger.org.apache.shiro.util.ThreadContext=WARN
log4j.logger.org.apache.shiro.cache.ehcache.EhCache=WARN
```

- spring-servlet.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <context:component-scan base-package="com.hgx.shiro.spring"></context:component-scan>

    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/"></property>
        <property name="suffix" value=".jsp"></property>
    </bean>
    
    <mvc:annotation-driven></mvc:annotation-driven>
    <mvc:default-servlet-handler/>
    
</beans>
```

- ShiroRealm.java

```java
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.realm.Realm;

public class ShiroRealm implements Realm {
    @Override
    public String getName() {
        return null;
    }

    @Override
    public boolean supports(AuthenticationToken authenticationToken) {
        return false;
    }

    @Override
    public AuthenticationInfo getAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        return null;
    }
}

```

- xxx.jsp 页面: 对应上面的配置需要写三个jsp页面(list.jsp,login.jsp,unauthorized.jsp)

```jsp
<html>
<body>
<h2>Unauthorized page</h2>
</body>
</html>
```



**到此项目已经跑起来了，哒哒哒**



### 4.2  ShiroFilter

#### 4.2.1 与Web 集成 

- Shiro 提供了与 Web 集成的支持，其通过一个 ShiroFilter 入口来拦截需要安全控制的URL，然后 进行相应的控制
- ShiroFilter 类似于如 Strut2/SpringMVC 这种 web 框架的前端控制器，是安全控制的入口点，其 负责读取配置（如ini 配置文件），然后判断URL 是否需要登录/权限等工作。

#### 4.2.2 ShiroFilter 的工作原理

![ShiroFilter 的工作原理](img/ShiroFilter的工作原理.png)

#### 4.2.3 web.xml 中shiroFilter的DelegatingFilterProxy  

- DelegatingFilterProxy 作用是自动到 Spring 容器查找名 字为 shiroFilter（filter-name）的 bean 并把所有 Filter 的操作委托给它。

```xml
<!--
    1. 配置  Shiro 的 shiroFilter.
    2. DelegatingFilterProxy 实际上是 Filter 的一个代理对象. 默认情况下, Spring 会到 IOC 容器中查找和
    <filter-name> 对应的 filter bean. 也可以通过 targetBeanName 的初始化参数来配置 filter bean 的 id.
-->
<filter>
    <filter-name>shiroFilter</filter-name>
    <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
    <init-param>
        <param-name>targetFilterLifecycle</param-name>
        <param-value>true</param-value>
    </init-param>
</filter>

<filter-mapping>
    <filter-name>shiroFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

#### 4.2.4 spring配置中shiroFilter的filterChainDefinitions

```xml
<property name="filterChainDefinitions">
    <value>
        /login.jsp = anon
        # everything else requires authentication:
        /** = authc
    </value>
</property>
```

##### 4.2.4.1 细节 

-  [urls] 部分的配置，其格式是： “url=拦截器[参数]，拦截 器[参数]”
- 如果当前请求的 url 匹配 [urls] 部分的某个 url 模式，将会 执行其配置的拦截器。 
- anon（anonymous） 拦截器表示匿名访问（即不需要登 录即可访问） 
- authc （authentication）拦截器表示需要身份认证通过后 才能访问

### 4.3 shiro中默认的过滤器

|    过滤器名称     |                           过滤器类                           | 描述                                                         | 例子                                                         |
| :---------------: | :----------------------------------------------------------: | :----------------------------------------------------------- | :----------------------------------------------------------- |
|       anon        |      org.apache.shiro.web.filter.authc.AnonymousFilter       | 没有参数，表示可以匿名访问                                   | /admins/**=anon                                              |
|       authc       |  org.apache.shiro.web.filter.authc.FormAuthenticationFilter  | 没有参数，表示需要认证(登录)才能使用                         | /user/**=authc                                               |
|    authcBasic     | org.apache.shiro.web.filter.authc.BasicHttpAuthenticationFilter | 没有参数，表示需要通过httpBasic验证，如果不通过，跳转到登陆页面 | /user/**=authcBasic                                          |
|      logout       |        org.apache.shiro.web.filter.authc.LogoutFilter        | 注销登陆的时候，完成一定的功能：任何现有的Session都将失效，而且任何身份都将回失去关联（在web应用程序中，RememberMe cookie 也将被删除） |                                                              |
| noSessionCreation | org.apache.shiro.web.filter.session.NoSessionCreationFilter  | 阻止在请求期间创建新的会话。以保证无状态的体验               |                                                              |
|       perms       | org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter | 参数可以写多个，多个时必须加上引号，并且在参数之间用逗号分隔。当有多个参数时必须每个参数都通过才能通过，相当于isPermitedAll() | `/admins/**=perms[user:*]`,`/admins/**=perms["user:add:*,user:modify:*"]` |
|       port        |         org.apache.shiro.web.filter.authz.PortFilter         | 指定请求访问端口。如果不匹配则跳转到登录页面                 | /admins/**=port[8081]                                        |
|       rest        | org.apache.shiro.web.filter.authz.HttpMethodPermissionFilter | 根据请求的方法                                               | admins/user/**=perms[user.method]，其中method为post，get，delete等 |
|       roles       |  org.apache.shiro.web.filter.authz.RolesAuthorizationFilter  | 角色过滤器,判断当前用户是否指定角色。参数可以写多个，多个时必须加上引号，并且参数之间用逗号分隔，当有多个参数,每个参数通过才算通过，相当于hasAllRoles() | admins/**=roles["admin,guest"]                               |
|        ssl        |         org.apache.shiro.web.filter.authz.SslFilter          | 没有参数，表示安全的url请求，协议为https                     |                                                              |
|       user        |         org.apache.shiro.web.filter.authc.UserFilter         | 没有参数表示必须存在用户                                     |                                                              |

### 4.4 URL 匹配

#### 4.4.1 URL 匹配模式

- url 模式使用 Ant 风格模式 
- Ant 路径通配符支持 ?、*、**，注意通配符匹配不 包括目录分隔符“/” 
  - `?`：匹配一个字符，如 /admin? 将匹配 /admin1，但不 匹配 /admin 或 /admin/； 
  - `*`：匹配零个或多个字符串，如 /admin 将匹配 /admin、 /admin123，但不匹配 /admin/1； 
  - `**`：匹配路径中的零个或多个路径，如 /admin/** 将匹 配 /admin/a 或 /admin/a/b

#### 4.4.2 URL 匹配顺序

**URL 权限采取第一次匹配优先的方式，即从头开始 使用第一个匹配的 url 模式对应的拦截器链。** 

- 如：

```json
/bb/**=filter1 
/bb/aa=filter2 
/**=filter3
```

- 如果请求的url是“/bb/aa”，因为按照声明顺序进行匹 配，那么将使用 filter1 进行拦截。

