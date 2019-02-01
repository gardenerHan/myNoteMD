# Spring注解驱动开发

## 一 组件注册

### 1.1 @Configuration、@Bean给容器中注册组件

- @Configuration:告诉Sring这是一个配置类，标注该注解的类就相当于spring的配置文件
- @Bean:给容器中注册一个Bean;类型为返回值的类型，id默认是用方法名作为id



- Person.java

```java
import java.util.Date;

public class Person {
    private Integer id;
    private String name;
    private String phoneNumber;
    private Date birth;


    public Person() {
    }

    public Person(String name, String phoneNumber) {
        this.name = name;
        this.phoneNumber = phoneNumber;
    }

    public Person(Integer id, String name, String phoneNumber, Date birth) {
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.birth = birth;
    }

    //省略 getter、setter、toString
}

```

- MainConfig.java

```java
import com.ifox.hgx.spring.annotation.bean.Person;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MainConfig {

    @Bean(value = "personValue")
    public Person person(){
        return new Person("张三","12111234545") ;
    }
}
```

- MainPerson.java

```java
import com.ifox.hgx.spring.annotation.bean.Person;
import com.ifox.hgx.spring.annotation.config.MainConfig;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class MainPerson {

    public static void main(String[] args) {
        ApplicationContext context = new AnnotationConfigApplicationContext(MainConfig.class);
        String[] beanNames = context.getBeanNamesForType(Person.class);
        for (String beanName : beanNames) {
            System.out.println(beanName);
        }
        Person person = context.getBean(Person.class);
        System.out.println(person);
    }
}
//控制台打印
//        personValue
//        Person{id=null, name='张三', phoneNumber='12111234545', birth=null}
```

### 1.2 @ComponentScan-自动扫描组件&指定扫描规则

- @ComponentScan：自动扫描组件

```properties
value:指定要扫描的包
excludeFilters = Filter[] ：指定扫描的时候按照什么规则排除那些组件
includeFilters = Filter[] ：指定扫描的时候只需要包含哪些组件
FilterType.ANNOTATION:按照注解
FilterType.ASSIGNABLE_TYPE:按照给定的类型；
FilterType.ASPECTJ:使用ASPECTJ表达式
FilterType.REGEX:使用正则指定
FilterType.CUSTOM:使用自定义规则
```

- @ComponentScans：里面可以配置多个@ComponentScan



#### 1.2.1 代码示例

- 配置类：MainConfig.java

```java
package com.ifox.hgx.spring.annotation.config;


import com.ifox.hgx.spring.annotation.bean.Person;
import com.ifox.hgx.spring.annotation.service.PersonService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.stereotype.Controller;


//配置类==配置文件
//@Configuration  告诉Spring这是一个配置类
@Configuration

/**
 * @ComponentScan value:指定要扫描的包
 * excludeFilters = Filter[] ：指定扫描的时候按照什么规则排除那些组件
 * includeFilters = Filter[] ：指定扫描的时候只需要包含哪些组件
 * FilterType.ANNOTATION：按照注解
 * FilterType.ASSIGNABLE_TYPE：按照给定的类型；
 * FilterType.ASPECTJ：使用ASPECTJ表达式
 * FilterType.REGEX：使用正则指定
 * FilterType.CUSTOM：使用自定义规则
 */

//@ComponentScan(value = "com.ifox.hgx.spring.annotation", excludeFilters = {
//        @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Controller.class, Service.class})
//})
@ComponentScan(value = "com.ifox.hgx.spring.annotation", useDefaultFilters = false, includeFilters = {
        @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Controller.class}),
        @ComponentScan.Filter(type = FilterType.ASSIGNABLE_TYPE, classes = {PersonService.class})
})
//@ComponentScans(value = {
//        @ComponentScan(value = "com.ifox.hgx.spring.annotation", useDefaultFilters = false, includeFilters = {
//                @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Controller.class})
//        }), @ComponentScan(value = "com.ifox.hgx.spring.annotation", useDefaultFilters = false, includeFilters = {
//        @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = {Service.class})
//})
//})
public class MainConfig {

    //给容器中注册一个Bean;类型为返回值的类型，id默认是用方法名作为id
    @Bean(value = "personValue")
    public Person person() {
        return new Person("张三", "12111234545");
    }
}
```

- 其他注解类

```java
//PersonController
package com.ifox.hgx.spring.annotation.controller;

import org.springframework.stereotype.Controller;

@Controller
public class PersonController {
}

//PersonService
package com.ifox.hgx.spring.annotation.service;

import org.springframework.stereotype.Service;

@Service
public class PersonService {
}

//PersonRepository
package com.ifox.hgx.spring.annotation.dao;

import org.springframework.stereotype.Repository;

@Repository
public class PersonRepository {
}
```

- 测试：IOCTest.java

```java
package com.ifox.hgx.spring.annotation.test;


import com.ifox.hgx.spring.annotation.config.MainConfig;
import org.junit.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class IOCTest {

    @Test
    public void test01() {
        AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext(MainConfig.class);
        String[] definitionNames = applicationContext.getBeanDefinitionNames();
        for (String definitionName : definitionNames) {
            System.out.println(definitionName);
        }
    }
}
```

### 1.3 自定义TypeFilter指定过滤规则

```java
//将MainConfig.java 的ComponentScan修改为该配置
@ComponentScan(value = "com.ifox.hgx.spring.annotation", useDefaultFilters = false, includeFilters = {
        @ComponentScan.Filter(type = FilterType.CUSTOM, classes = {MyTypeFilter.class})
})
```

- 添加自定义扫描规则:MyTypeFilter.java

```java
package com.ifox.hgx.spring.annotation.config;

import org.springframework.core.io.Resource;
import org.springframework.core.type.AnnotationMetadata;
import org.springframework.core.type.ClassMetadata;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.core.type.filter.TypeFilter;

import java.io.IOException;

public class MyTypeFilter implements TypeFilter {

    /**
     * metadataReader：读取到的当前正在扫描的类的信息
     * metadataReaderFactory:可以获取到其他任何类信息的
     */
    @Override
    public boolean match(MetadataReader metadataReader, MetadataReaderFactory metadataReaderFactory)
            throws IOException {

        //获取当前类注解的信息
        AnnotationMetadata annotationMetadata = metadataReader.getAnnotationMetadata();
        //获取当前正在扫描的类的类信息
        ClassMetadata classMetadata = metadataReader.getClassMetadata();
        //获取当前类资源（类的路径）
        Resource resource = metadataReader.getResource();

        String className = classMetadata.getClassName();
        System.out.println("--->" + className);
        if (className.contains("er")) {
            return true;
        }
        return false;
    }
}
```
### 1.4 @Scope-设置组件作用域

- 配置类

```java
package com.ifox.hgx.spring.annotation.config;


import com.ifox.hgx.spring.annotation.bean.Person;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;


@Configuration

public class MainConfig2 {

    //默认是单实例的
    /**
     * @Scope:调整作用域
     * prototype：多实例的：ioc容器启动并不会去调用方法创建对象放在容器中。每次获取的时候才会调用方法创建对象；
     * singleton：单实例的（默认值）：ioc容器启动会调用方法创建对象放到ioc容器中。以后每次获取就是直接从容器（map.get()）中拿
     * request：同一次请求创建一个实例
     * session：同一个session创建一个实例
     *
     * 懒加载：
     * 单实例bean：默认在容器启动的时候创建对象；
     * 懒加载：容器启动不创建对象。第一次使用(获取)Bean创建对象，并初始化；
     * ConfigurableBeanFactory#SCOPE_SINGLETON singleton
     * ConfigurableBeanFactory#SCOPE_PROTOTYPE prototype
     * org.springframework.web.context.WebApplicationContext#SCOPE_REQUEST  request
     * org.springframework.web.context.WebApplicationContext#SCOPE_SESSION  session
     */
//	@Scope("prototype")
    @Lazy
    @Bean("person")
    public Person person() {
        System.out.println("给容器中添加Person....");
        return new Person("张三", "123312312321");
    }

}
```

- 测试代码

```java
@Test
public void test02(){
    AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext(MainConfig2.class);
    //		String[] definitionNames = applicationContext.getBeanDefinitionNames();
    //		for (String name : definitionNames) {
    //			System.out.println(name);
    //		}
    //
    System.out.println("ioc容器创建完成....");
    Object bean = applicationContext.getBean("person");
    Object bean2 = applicationContext.getBean("person");
    System.out.println(bean == bean2);
}
```

