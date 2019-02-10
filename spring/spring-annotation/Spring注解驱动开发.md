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

### 1.5 @Conditional-按照条件注册bean

- @Conditional 满足设定的条件才会注册相应的bean，可以标注在类和方法上。

```java
package org.springframework.context.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Conditional {
    Class<? extends Condition>[] value();

}
```



**代码示例**

- 配置类

```java
package com.ifox.hgx.spring.annotation.config;


import com.ifox.hgx.spring.annotation.bean.Person;
import com.ifox.hgx.spring.annotation.condition.LinuxCondition;
import com.ifox.hgx.spring.annotation.condition.WindowsCondition;
import org.springframework.context.annotation.*;


//类中组件统一设置。满足当前条件，这个类中配置的所有bean注册才能生效；
//@Conditional({WindowsCondition.class})
@Configuration
public class MainConfig2 {

    /**
     * @Conditional({Condition}) ： 按照一定的条件进行判断，满足条件给容器中注册bean
     *
     * 如果系统是windows，给容器中注册("bill")
     * 如果是linux系统，给容器中注册("linus")
     */
    @Conditional(WindowsCondition.class)
    @Bean("bill")
    public Person person01(){
        return new Person("Bill Gates","12313");
    }

    @Conditional(LinuxCondition.class)
    @Bean("linus")
    public Person person02(){
        return new Person("linus", "232342");
    }


}
```

- LinuxCondition.java

```java
package com.ifox.hgx.spring.annotation.condition;


import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.context.annotation.Condition;
import org.springframework.context.annotation.ConditionContext;
import org.springframework.core.env.Environment;
import org.springframework.core.type.AnnotatedTypeMetadata;

//判断是否linux系统
public class LinuxCondition implements Condition {

    /**
     * ConditionContext：判断条件能使用的上下文（环境）
     * AnnotatedTypeMetadata：注释信息
     */
    @Override
    public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
        // TODO 是否linux系统
        //1、能获取到ioc使用的beanfactory
        ConfigurableListableBeanFactory beanFactory = context.getBeanFactory();
        //2、获取类加载器
        ClassLoader classLoader = context.getClassLoader();
        //3、获取当前环境信息
        Environment environment = context.getEnvironment();
        //4、获取到bean定义的注册类
        BeanDefinitionRegistry registry = context.getRegistry();

        String property = environment.getProperty("os.name");

        //可以判断容器中的bean注册情况，也可以给容器中注册bean
        boolean definition = registry.containsBeanDefinition("person");

        if(property.contains("linux")){
            return true;
        }

        return false;
    }
}
```

- WindowsCondition.java

```java
package com.ifox.hgx.spring.annotation.condition;


import org.springframework.context.annotation.Condition;
import org.springframework.context.annotation.ConditionContext;
import org.springframework.core.type.AnnotatedTypeMetadata;

public class WindowsCondition implements Condition {

    @Override
    public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {

        String osName = context.getEnvironment().getProperty("os.name");

        System.out.println("OS Name:" + osName);

        if (osName.contains("Windows")) {
            return true;
        }

        return false;
    }
}

```

- 测试代码

```java
@Test
public void test03() {
    AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext(MainConfig2.class);
    String[] namesForType = applicationContext.getBeanNamesForType(Person.class);
    ConfigurableEnvironment environment = applicationContext.getEnvironment();
    //动态获取环境变量的值；Windows 10
    String property = environment.getProperty("os.name");
    System.out.println(property);
    for (String name : namesForType) {
        System.out.println(name);
    }

    Map<String, Person> persons = applicationContext.getBeansOfType(Person.class);
    System.out.println(persons);
}
```



### 1.6 @Import

- @Import-给容器中快速导入一个组件：id默认是组件的全类名

```java
//Bean：Color.java
package com.ifox.hgx.spring.annotation.bean;
public class Color {
}
//Bean：Red.java
package com.ifox.hgx.spring.annotation.bean;
public class Red {
}
//配置类：MainConfig2.java
@Import(value = {Color.class, Red.class})
@Configuration
public class MainConfig2 {
	//...
}
```

- @Import：使用ImportSelector接口实现注册bean

```java
package com.ifox.hgx.spring.annotation.condition;

import org.springframework.context.annotation.ImportSelector;
import org.springframework.core.type.AnnotationMetadata;

//自定义逻辑返回需要导入的组件
public class MyImportSelector implements ImportSelector {

    //返回值，就是到导入到容器中的组件全类名
    //AnnotationMetadata:当前标注@Import注解的类的所有注解信息
    @Override
    public String[] selectImports(AnnotationMetadata importingClassMetadata) {
        //importingClassMetadata
        //方法不要返回null值
        return new String[]{"com.ifox.hgx.spring.annotation.bean.Blue","com.ifox.hgx.spring.annotation.bean.Yellow"};
    }

}

```

```java
//@Import导入组件，id默认是组件的全类名
@Import(value = {Color.class, Red.class, MyImportSelector.class})
@Configuration
public class MainConfig2 {
    //....
}
```

- @Import：使用ImportBeanDefinitionRegistrar接口实现注册bean

```java
package com.ifox.hgx.spring.annotation.condition;

import com.ifox.hgx.spring.annotation.bean.RainBow;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.RootBeanDefinition;
import org.springframework.context.annotation.ImportBeanDefinitionRegistrar;
import org.springframework.core.type.AnnotationMetadata;


public class MyImportBeanDefinitionRegistrar implements ImportBeanDefinitionRegistrar {

    /**
     * AnnotationMetadata：当前类的注解信息
     * BeanDefinitionRegistry:BeanDefinition注册类；
     * 把所有需要添加到容器中的bean；调用
     * BeanDefinitionRegistry.registerBeanDefinition手工注册进来
     */
    @Override
    public void registerBeanDefinitions(AnnotationMetadata importingClassMetadata, BeanDefinitionRegistry registry) {

        boolean definition = registry.containsBeanDefinition("com.ifox.hgx.spring.annotation.bean.Red");
        boolean definition2 = registry.containsBeanDefinition("com.ifox.hgx.spring.annotation.bean.Blue");
        if (definition && definition2) {
            //指定Bean定义信息；（Bean的类型，Bean。。。）
            RootBeanDefinition beanDefinition = new RootBeanDefinition(RainBow.class);
            //注册一个Bean，指定bean名
            registry.registerBeanDefinition("rainBow", beanDefinition);
        }
    }
}
```

```java
//@Import导入组件，id默认是组件的全类名
@Import(value = {Color.class, Red.class, MyImportSelector.class, MyImportBeanDefinitionRegistrar.class})
@Configuration
public class MainConfig2 {
    //...
}
```

### 1.7 使用FactoryBean注册组件 

- FactoryBean：ColorFactoryBean.java

```java
package com.ifox.hgx.spring.annotation.factory;

import com.ifox.hgx.spring.annotation.bean.Color;
import org.springframework.beans.factory.FactoryBean;

//创建一个Spring定义的FactoryBean
public class ColorFactoryBean implements FactoryBean {

    //返回一个Color对象，这个对象会添加到容器中
    @Override
    public Color getObject() throws Exception {
        // TODO Auto-generated method stub
        System.out.println("ColorFactoryBean...getObject...");
        return new Color();
    }

    @Override
    public Class<?> getObjectType() {
        // TODO Auto-generated method stub
        return Color.class;
    }

    //是单例？
    //true：这个bean是单实例，在容器中保存一份
    //false：多实例，每次获取都会创建一个新的bean；
    @Override
    public boolean isSingleton() {
        return true;
    }
}
```

- 配置类

```java
@Configuration
public class MainConfig2 {
    @Bean
    public ColorFactoryBean colorFactoryBean(){
        return new ColorFactoryBean();
    }
}
```

- 测试代码

```java
private void printBeans(AnnotationConfigApplicationContext applicationContext){
    String[] definitionNames = applicationContext.getBeanDefinitionNames();
    for (String name : definitionNames) {
        System.out.println(name);
    }
}

@Test
public void testFactoryBean(){
    AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext(MainConfig2.class);
    printBeans(applicationContext);
    //工厂Bean获取的是调用getObject创建的对象
    Object bean2 = applicationContext.getBean("colorFactoryBean");
    Object bean3 = applicationContext.getBean("colorFactoryBean");
    Object object = applicationContext.getBean(Color.class) ;
    System.out.println("color:"+object);
    System.out.println("bean的类型："+bean2.getClass());
    System.out.println(bean2 == bean3);

    Object bean4 = applicationContext.getBean("&colorFactoryBean");
    System.out.println(bean4.getClass());
}
```

### 1.8 小总结

 **给容器中注册组件:**

- 包扫描+组件标注注解（@Controller/@Service/@Repository/@Component）[自己写的类]
- @Bean[导入的第三方包里面的组件]
- @Import[快速给容器中导入一个组件]
  - @Import(要导入到容器中的组件)；容器中就会自动注册这个组件，id默认是全类名
  - ImportSelector:返回需要导入的组件的全类名数组；
  - ImportBeanDefinitionRegistrar:手动注册bean到容器中
- 使用Spring提供的 FactoryBean（工厂Bean）
  - 默认获取到的是工厂bean调用getObject创建的对象
  - 要获取工厂Bean本身，我们需要给id前面加一个&
    - 例如：&colorFactoryBean



## 二 生命周期

### 2.1 @Bean指定初始化和销毁方法 

- bean:Car.java

```java
package com.ifox.hgx.spring.annotation.bean;

import org.springframework.stereotype.Component;

@Component
public class Car {
	
	public Car(){
		System.out.println("car constructor...");
	}
	
	public void init(){
		System.out.println("car ... init...");
	}

	private void destroy() {
			System.out.println("car ... destroy...");
	}
}
```

- 配置类:MainConfigOfLifeCycle.java

```java
package com.ifox.hgx.spring.annotation.config;

import com.ifox.hgx.spring.annotation.bean.Car;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;


@ComponentScan("com.ifox.hgx.spring.annotation.bean")
@Configuration
public class MainConfigOfLifeCycle {

    //    @Scope("prototype")
    @Bean(initMethod = "init", destroyMethod = "destroy")
    public Car car() {
        return new Car();
    }

}
```



### 2.2 InitializingBean和DisposableBean

```java
package com.ifox.hgx.spring.annotation.bean;

import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

@Component
public class Cat implements InitializingBean, DisposableBean {

    public Cat() {
        System.out.println("Cat constructor...");
    }

    /**
     * bean销毁前调用
     *
     * @throws Exception 异常
     */
    @Override
    public void destroy() throws Exception {
        System.out.println("Cat...destroy...");
    }

    /**
     * bean创建后并属性赋值后调用,相当于init
     *
     * @throws Exception 异常
     */
    @Override
    public void afterPropertiesSet() throws Exception {
        System.out.println("Cat...afterPropertiesSet...");
    }

}
```

### 2.3 @PostConstruct和@PreDestroy

```java
package com.ifox.hgx.spring.annotation.bean;

import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

@Component
public class Dog {

    public Dog() {
        System.out.println("dog constructor...");
    }

    //对象创建并赋值之后调用
    @PostConstruct
    public void init() {
        System.out.println("Dog....@PostConstruct...");
    }

    //容器移除对象之前
    @PreDestroy
    public void destroy() {
        System.out.println("Dog....@PreDestroy...");
    }
}
```

### 2.4 BeanPostProcessor后置处理器

```java
package com.ifox.hgx.spring.annotation.bean;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.stereotype.Component;

/**
 * 后置处理器：初始化前后进行处理工作
 * 将后置处理器加入到容器中
 */
@Component
public class MyBeanPostProcessor implements BeanPostProcessor {

    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        System.out.println("postProcessBeforeInitialization..." + beanName + "=>" + bean);
        return bean;
    }

    @Override
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        System.out.println("postProcessAfterInitialization..." + beanName + "=>" + bean);
        return bean;
    }

}
```

- 获取IOC容器；实现ApplicationContextAware接口，它的setApplicationContext传入了ApplicationContext

```java
package com.ifox.hgx.spring.annotation.bean;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

@Component
public class Dog implements ApplicationContextAware {

    //@Autowired
    private ApplicationContext applicationContext;

    public Dog() {
        System.out.println("dog constructor...");
    }

    //对象创建并赋值之后调用
    @PostConstruct
    public void init() {
        System.out.println("Dog....@PostConstruct...");
    }

    //容器移除对象之前
    @PreDestroy
    public void destroy() {
        System.out.println("Dog....@PreDestroy...");
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}
```

### 2.5 小总结

**bean的生命周期:**

- bean创建---初始化----销毁的过程

 **容器管理bean的生命周期**

- 我们可以自定义初始化和销毁方法；容器在bean进行到当前生命周期的时候来调用我们自定义的初始化和销毁方法

 **构造（对象创建）**

- 单实例：在容器启动的时候创建对象
- 多实例：在每次获取的时候创建对象

 **BeanPostProcessor.postProcessBeforeInitialization初始化：**

- 对象创建完成，并赋值好，调用初始化方法。。。

 **BeanPostProcessor.postProcessAfterInitialization销毁：**

- 单实例：容器关闭的时候
- 多实例：容器不会管理这个bean；容器不会调用销毁方法；


  **遍历得到容器中所有的BeanPostProcessor；挨个执行beforeInitialization，一但返回null，跳出for循环，不会执行后面的BeanPostProcessor.postProcessorsBeforeInitialization**

 **BeanPostProcessor原理**

 ```java
populateBean(beanName, mbd, instanceWrapper);//给bean进行属性赋值
initializeBean
{
    applyBeanPostProcessorsBeforeInitialization(wrappedBean, beanName);
    invokeInitMethods(beanName, wrappedBean, mbd);执行自定义初始化
    applyBeanPostProcessorsAfterInitialization(wrappedBean, beanName);
}
 ```

**生命周期管理方式：**

1）、指定初始化和销毁方法；通过@Bean指定init-method和destroy-method；

2）、通过让Bean实现InitializingBean（定义初始化逻辑），DisposableBean（定义销毁逻辑）;

3）、可以使用JSR250；

- @PostConstruct：在bean创建完成并且属性赋值完成；来执行初始化方法
- @PreDestroy：在容器销毁bean之前通知我们进行清理工作 

4）、BeanPostProcessor【interface】：bean的后置处理器,在bean初始化前后进行一些处理工作；

- postProcessBeforeInitialization:在初始化之前工作
- postProcessAfterInitialization:在初始化之后工作

**Spring底层对 BeanPostProcessor 的使用:**

- bean赋值，注入其他组件，@Autowired，生命周期注解功能，@Async,xxx BeanPostProcessor


