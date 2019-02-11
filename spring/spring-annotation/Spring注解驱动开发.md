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

## 三 属性赋值

**@Value赋值**

**@PropertySource加载外部配置文件**

- javaBean:Person.java

```java
package com.ifox.hgx.spring.annotation.bean;


import org.springframework.beans.factory.annotation.Value;

import java.util.Date;

public class Person {

    /**
     * 使用@Value赋值；
     * 1、基本数值
     * 2、可以写SpEL； #{}
     * 3、可以写${}；取出配置文件【properties】中的值（在运行环境变量里面的值）
     */

    @Value("#{T(Math).random()*1000 -1 }")
    private Integer id;
    @Value("张三")
    private String name;
    @Value("${person.phoneNumber}")
    private String phoneNumber;
    @Value("#{nowDate}")
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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    @Override
    public String toString() {
        return "Person{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", birth=" + birth +
                '}';
    }
}
```

- 配置类

```java
package com.ifox.hgx.spring.annotation.config;

import com.ifox.hgx.spring.annotation.bean.Person;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import java.time.Instant;
import java.util.Date;

/**
 * 使用@PropertySource读取外部配置文件中的k/v保存到运行的环境变量中;加载完外部的配置文件以后使用${}取出配置文件的值
 */
@PropertySource(value = {"classpath:person.properties"})
@Configuration
public class MainConfigOfPropertyValues {

    @Bean
    public Person person() {
        return new Person();
    }

    @Bean(value = "nowDate")
    public Date date(){
        return Date.from(Instant.now()) ;
    }
}
```

- person.properties

 ```properties
person.phoneNumber=129992929
 ```

- 测试

```java
package com.ifox.hgx.spring.annotation.test;

import com.ifox.hgx.spring.annotation.bean.Person;
import com.ifox.hgx.spring.annotation.config.MainConfigOfPropertyValues;
import org.junit.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;

public class IOCTest_PropertyValue {
    AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext(MainConfigOfPropertyValues.class);
    @Test
    public void test01(){
        printBeans(applicationContext);
        System.out.println("=============");

        Person person = (Person) applicationContext.getBean("person");
        System.out.println(person);


        ConfigurableEnvironment environment = applicationContext.getEnvironment();
        String property = environment.getProperty("person.phoneNumber");
        System.out.println(property);
        applicationContext.close();
    }

    private void printBeans(AnnotationConfigApplicationContext applicationContext){
        String[] definitionNames = applicationContext.getBeanDefinitionNames();
        for (String name : definitionNames) {
            System.out.println(name);
        }
    }

}
```

## 四 自动装配

**Spring利用依赖注入（DI），完成对IOC容器中中各个组件的依赖关系赋值**

**AutowiredAnnotationBeanPostProcessor:解析完成自动装配功能**


### 4.1 @Autowired:自动注入

- 默认优先按照类型去容器中找对应的组件:applicationContext.getBean(BookDao.class);找到就赋值
- 如果找到多个相同类型的组件，再将属性的名称作为组件的id去容器中查找`applicationContext.getBean("bookDao")`
- @Qualifier("bookDao")：使用@Qualifier指定需要装配的组件的id，而不是使用属性名
- 自动装配默认一定要将属性赋值好，没有就会报错；可以使用@Autowired(required=false),使所需的组件没有的时不装配。
- @Primary：让Spring进行自动装配的时候，默认使用首选的bean；也可以继续使用@Qualifier指定需要装配的bean的名字

```java
public class BookService {
    @Autowired
    private BookDao bookDao;
}
```



**代码示例**

- 配置类

```java
package com.ifox.hgx.spring.annotation.config;


import com.ifox.hgx.spring.annotation.bean.Car;
import com.ifox.hgx.spring.annotation.bean.Color;
import com.ifox.hgx.spring.annotation.bean.Person;
import com.ifox.hgx.spring.annotation.dao.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
@ComponentScan({"com.ifox.hgx.spring.annotation.service","com.ifox.hgx.spring.annotation.dao",
		"com.ifox.hgx.spring.annotation.controller","com.ifox.hgx.spring.annotation.bean"})
public class MainConfigOfAutowired {

	@Primary
	@Bean(value = "personRepository2")
	public PersonRepository personRepository(){
		PersonRepository personRepository = new PersonRepository();
		personRepository.setIndex(2);
		return personRepository;
	}
}

```

- controller

```java
package com.ifox.hgx.spring.annotation.controller;

import com.ifox.hgx.spring.annotation.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class PersonController {

    @Autowired
    private PersonService personService ;

    public void prin(){
        System.out.println(personService.getPersonById(12312321));
    }

    @Override
    public String toString() {
        return "PersonController{" +
                "personService=" + personService +
                '}';
    }
}
```

- service

```java
package com.ifox.hgx.spring.annotation.service;

import com.ifox.hgx.spring.annotation.bean.Person;
import com.ifox.hgx.spring.annotation.dao.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class PersonService {

//    @Qualifier(value = "personRepository")
    @Autowired(required = false)
    private PersonRepository personRepository;

    public Person getPersonById(Integer id) {

        return personRepository.getById(id);
    }

    @Override
    public String toString() {
        return "PersonService{" +
                "personRepository=" + personRepository +
                '}';
    }
}
```

- repository

```java
package com.ifox.hgx.spring.annotation.dao;

import com.ifox.hgx.spring.annotation.bean.Person;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.Date;

@Repository
public class PersonRepository {

    private Integer index = 0 ;

    public Person getById(Integer id) {
        return new Person(id, "哈哈哈", "1231232132", Date.from(Instant.now()));
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    @Override
    public String toString() {
        return "PersonRepository{" +
                "index=" + index +
                '}';
    }
}
```

- 测试

```java
package com.ifox.hgx.spring.annotation.test;

import com.ifox.hgx.spring.annotation.bean.Color;
import com.ifox.hgx.spring.annotation.config.MainConfigOfAutowired;
import com.ifox.hgx.spring.annotation.controller.PersonController;
import com.ifox.hgx.spring.annotation.dao.PersonRepository;
import org.junit.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class IOCTest_Autowired {

    @Test
    public void test01() {
        AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext(MainConfigOfAutowired.class);

        PersonController personController = applicationContext.getBean(PersonController.class);
        System.out.println(personController);

//        PersonRepository personRepository = applicationContext.getBean(PersonRepository.class);
//        System.out.println(personRepository);
       
        System.out.println(applicationContext);
        applicationContext.close();
    }
}
```





### 4.2 @Resource(JSR250)和@Inject(JSR330)[java规范的注解]

- @Resource
    - 可以和@Autowired一样实现自动装配功能；默认是按照组件名称进行装配的
    - 没有能支持@Primary功能，没有支持@Autowired(reqiured=false)
- @Inject
    - 需要导入javax.inject的包，和Autowired的功能一样。没有required=false的功能；
- 区别
    - @Autowired:Spring定义的
    - @Resource、@Inject 是java规范的

**代码**

```java
@Service
public class PersonService {

//    @Qualifier(value = "personRepository")
//    @Autowired(required = false)
//    @Resource
    @Inject
    private PersonRepository personRepository;

//省略。。。。
}
```



### 4.3 标注位置

@Autowired:构造器，参数，方法，属性；都是从容器中获取参数组件的值

- [标注在方法位置]：@Bean+方法参数；参数从容器中获取;默认不写@Autowired效果是一样的；都能自动装配
- [标在构造器上]：如果组件只有一个有参构造器，这个有参构造器的@Autowired可以省略，参数位置的组件还是可以自动从容器中获取
- 放在参数位置

**代码**

- bean

```java
package com.ifox.hgx.spring.annotation.bean;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//默认加在ioc容器中的组件，容器启动会调用无参构造器创建对象，再进行初始化赋值等操作
@Component
public class Boss {


    private Car car;

    //构造器要用的组件，都是从容器中获取
    public Boss(Car car) {
        this.car = car;
        System.out.println("Boss...有参构造器");
    }


    public Car getCar() {
        return car;
    }


    //@Autowired
    //标注在方法，Spring容器创建当前对象，就会调用方法，完成赋值；
    //方法使用的参数，自定义类型的值从ioc容器中获取
    public void setCar(Car car) {
        System.out.println("setCar。。。调用");
        this.car = car;
    }


    @Override
    public String toString() {
        return "Boss [car=" + car + "]";
    }
}
```

- 配置类中相关代码

```java
/**
 * @Bean 标注的方法创建对象的时候，方法参数的值从容器中获取
 */
@Bean
public Color color(Car car){
    Color color = new Color();
    color.setCar(car);
    return color;
}
```

- bean

```java
package com.ifox.hgx.spring.annotation.bean;


public class Color {

    private Car car ;

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    @Override
    public String toString() {
        return "Color{" +
                "car=" + car +
                '}';
    }
}
```

### 4.4 使用Spring容器底层的组件

**自定义组件想要使用Spring容器底层的一些组件（ApplicationContext，BeanFactory，xxx）**

- 自定义组件实现xxxAware：在创建对象的时候，会调用接口规定的方法注入相关组件
- Aware把Spring底层一些组件注入到自定义的Bean中
- xxxAware功能使用xxxProcessor：ApplicationContextAware==》ApplicationContextAwareProcessor

![Aware接口](img/Aware接口.png)

**代码**

- bean

```java
package com.ifox.hgx.spring.annotation.bean;


import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanNameAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.EmbeddedValueResolverAware;
import org.springframework.stereotype.Component;
import org.springframework.util.StringValueResolver;

@Component
public class Red implements ApplicationContextAware, BeanNameAware, EmbeddedValueResolverAware {

    private ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        // TODO Auto-generated method stub
        System.out.println("传入的ioc："+applicationContext);
        this.applicationContext = applicationContext;
    }

    @Override
    public void setBeanName(String name) {
        // TODO Auto-generated method stub
        System.out.println("当前bean的名字："+name);
    }

    @Override
    public void setEmbeddedValueResolver(StringValueResolver resolver) {
        // TODO Auto-generated method stub
        String resolveStringValue = resolver.resolveStringValue("你好 ${os.name} 我是 #{20*18}");
        System.out.println("解析的字符串："+resolveStringValue);
    }
    
}

```

- 测试

```java
package com.ifox.hgx.spring.annotation.test;

import com.ifox.hgx.spring.annotation.bean.Boss;
import com.ifox.hgx.spring.annotation.bean.Car;
import com.ifox.hgx.spring.annotation.bean.Color;
import com.ifox.hgx.spring.annotation.config.MainConfigOfAutowired;
import com.ifox.hgx.spring.annotation.controller.PersonController;
import com.ifox.hgx.spring.annotation.dao.PersonRepository;
import org.junit.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class IOCTest_Autowired {

    @Test
    public void test01() {
        AnnotationConfigApplicationContext applicationContext = new AnnotationConfigApplicationContext(MainConfigOfAutowired.class);

        PersonController personController = applicationContext.getBean(PersonController.class);
        System.out.println(personController);

//        PersonRepository personRepository = applicationContext.getBean(PersonRepository.class);
//        System.out.println(personRepository);

		Boss boss = applicationContext.getBean(Boss.class);
		System.out.println(boss);
		Car car = applicationContext.getBean(Car.class);
		System.out.println(car);

        Color color = applicationContext.getBean(Color.class);
        System.out.println(color);
        System.out.println(applicationContext);
        applicationContext.close();
    }

}
```

### 4.5 @Profile环境搭建

**Spring为我们提供的可以根据当前环境，动态的激活和切换一系列组件的功能**

- 如：开发环境、测试环境、生产环境

**代码**

```java
package com.ifox.hgx.spring.annotation.config;




import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.EmbeddedValueResolverAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.util.StringValueResolver;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * Profile：
 * 		Spring为我们提供的可以根据当前环境，动态的激活和切换一系列组件的功能；
 *
 * 开发环境、测试环境、生产环境；
 * 数据源：(/A)(/B)(/C)；
 *
 *
 * @Profile：指定组件在哪个环境的情况下才能被注册到容器中，不指定，任何环境下都能注册这个组件
 *
 * 1）、加了环境标识的bean，只有这个环境被激活的时候才能注册到容器中。默认是default环境
 * 2）、写在配置类上，只有是指定的环境的时候，整个配置类里面的所有配置才能开始生效
 * 3）、没有标注环境标识的bean在，任何环境下都是加载的；
 */

@PropertySource("classpath:/db.properties")
@Configuration
public class MainConfigOfProfile implements EmbeddedValueResolverAware{

	@Value("${db.user}")
	private String user;

	private StringValueResolver valueResolver;

	private String  driverClass;


	@Profile("test")
	@Bean("testDataSource")
	public DataSource dataSourceTest(@Value("${db.password}")String pwd) throws Exception{
		ComboPooledDataSource dataSource = new ComboPooledDataSource();
		dataSource.setUser(user);
		dataSource.setPassword(pwd);
		dataSource.setJdbcUrl("jdbc:mysql://localhost:3306/test");
		dataSource.setDriverClass(driverClass);
		return dataSource;
	}


	@Profile("dev")
	@Bean("devDataSource")
	public DataSource dataSourceDev(@Value("${db.password}")String pwd) throws Exception{
		ComboPooledDataSource dataSource = new ComboPooledDataSource();
		dataSource.setUser(user);
		dataSource.setPassword(pwd);
		dataSource.setJdbcUrl("jdbc:mysql://localhost:3306/dev");
		dataSource.setDriverClass(driverClass);
		return dataSource;
	}

	@Profile("prod")
	@Bean("prodDataSource")
	public DataSource dataSourceProd(@Value("${db.password}")String pwd) throws Exception{
		ComboPooledDataSource dataSource = new ComboPooledDataSource();
		dataSource.setUser(user);
		dataSource.setPassword(pwd);
		dataSource.setJdbcUrl("jdbc:mysql://localhost:3306/prod");

		dataSource.setDriverClass(driverClass);
		return dataSource;
	}

	@Override
	public void setEmbeddedValueResolver(StringValueResolver resolver) {

		this.valueResolver = resolver;
		driverClass = valueResolver.resolveStringValue("${db.driverClass}");
	}

}
```

- db.properties

```properties
db.user=root
db.password=123456
db.driverClass=com.mysql.jdbc.Driver
```

- 测试

```java
package com.ifox.hgx.spring.annotation.test;

import javax.sql.DataSource;

import com.ifox.hgx.spring.annotation.config.MainConfigOfProfile;
import org.junit.Test;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;



public class IOCTest_Profile {

	//1、使用命令行动态参数: 在虚拟机参数位置加载 -Dspring.profiles.active=test
	//2、代码的方式激活某种环境；
	@Test
	public void test01(){
		AnnotationConfigApplicationContext applicationContext =
//				new AnnotationConfigApplicationContext(MainConfigOfProfile.class) ;
				new AnnotationConfigApplicationContext();
		//1、创建一个applicationContext
		//2、设置需要激活的环境
		applicationContext.getEnvironment().setActiveProfiles("dev");
		//3、注册主配置类
		applicationContext.register(MainConfigOfProfile.class);
		//4、启动刷新容器
		applicationContext.refresh();


		String[] namesForType = applicationContext.getBeanNamesForType(DataSource.class);
		for (String string : namesForType) {
			System.out.println(string);
		}

		applicationContext.close();
	}

}
```

