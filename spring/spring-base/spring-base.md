# Spring



## 一 Spring是什么？

- Spring 是一个开源框架.

- Spring 为简化企业级应用开发而生. 使用 Spring 可以使简单的 JavaBean 实现以前只有 EJB 才能实现的功能.

- Spring 是一个 IOC(DI) 和 AOP 容器框架.

- 具体描述 Spring:

  - 轻量级：Spring 是非侵入性的 - 基于 Spring 开发的应用中的对象可以不依赖于 Spring 的 API
  - 依赖注入(DI --- dependency injection、IOC)
  - 面向切面编程(AOP --- aspect oriented programming)
  - 容器: Spring 是一个容器, 因为它包含并且管理应用对象的生命周期
  - 框架: Spring 实现了使用简单的组件配置组合成一个复杂的应用. 在 Spring 中可以使用 XML 和 Java 注解组合这些对象
  - 一站式：在 IOC 和 AOP 的基础上可以整合各种企业应用的开源框架和优秀的第三方类库 （实际上 Spring 自身也提供了展现层的 SpringMVC 和 持久层的 Spring JDBC）

- spring模块

  ![](img\spring模块.png)



## 二 第一个spring项目

### 2.1 搭建spring环境：spring依赖jar包（gradle）

```gradle
dependencies {
    // https://mvnrepository.com/artifact/org.springframework/spring-context
    compile group: 'org.springframework', name: 'spring-context', version: '5.0.8.RELEASE'
    compile group: 'junit', name: 'junit', version: '4.12'
}
```

### 2.2   建立spring项目 

- Spring 的配置文件: 一个典型的 Spring 项目需要创建一个或多个 Bean 配置文件, 这些配置文件用于在 Spring IOC 容器里配置 Bean. Bean 的配置文件可以放在 classpath 下, 也可以放在其它目录下. 

### 2.3 HelloWorld

- HelloWorld.java

```java
public class HelloWorld {

    private String user;

    public HelloWorld() {
        System.out.println("HelloWorld's constructor...");
    }

    public void setUser(String user) {
        System.out.println("setUser:" + user);
        this.user = user;
    }

    public HelloWorld(String user) {
        this.user = user;
    }

    public void hello(){
        System.out.println("Hello: " + user);
    }

}
```



- applicationContext.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <!-- 配置一个 bean -->
    <bean id="helloWorld" class="xxxx.xxxx.HelloWorld">
        <!-- 为属性赋值 -->
        <property name="user" value="Jerry"></property>
    </bean>

</beans>
```



## 三 Spring中Bean的配置

### 3.1   IOC & DI 概述  

- IOC(Inversion of Control)：其思想是反转资源获取的方向. 传统的资源查找方式要求组件向容器发起请求查找资源. 作为回应, 容器适时的返回资源. 而应用了 IOC 之后, 则是容器主动地将资源推送给它所管理的组件, 组件所要做的仅是选择一种合适的方式来接受资源. 这种行为也被称为查找的被动形式
- DI(Dependency Injection) — IOC 的另一种表述方式：即组件以一些预先定义好的方式(例如: setter 方法)接受来自如容器的资源注入. 相对于 IOC 而言，这种表述更直接

### 3.2 配置 bean

#### 3.2.1 概要

- 配置形式：基于 XML 文件的方式；基于注解的方式
- Bean 的配置方式：通过全类名（反射）、通过工厂方法（静态工厂方法 & 实例工厂方法）、FactoryBean
- IOC 容器 BeanFactory & ApplicationContext 概述
- 依赖注入的方式：属性注入；构造器注入
- 注入属性值细节
- 自动转配
- bean 之间的关系：继承；依赖
- bean 的作用域：singleton；prototype；WEB 环境作用域
- 使用外部属性文件
- spEL 
- IOC 容器中 Bean 的生命周期
- Spring 4.x 新特性：泛型依赖注入



#### 3.2.2 在 Spring 的 IOC 容器里配置 Bean

- 在 xml 文件中通过 bean 节点来配置 bean 
  - id：Bean 的名称。
    - 在 IOC 容器中必须是唯一的
    - 若 id 没有指定，Spring 自动将权限定性类名作为 Bean 的名字
    - id 可以指定多个名字，名字之间可用逗号、分号、或空格分隔



#### 3.2.3 Spring IOC 容器

- 在 Spring IOC 容器读取 Bean 配置创建 Bean 实例之前, 必须对它进行实例化. 只有在容器实例化后, 才可以从 IOC 容器里获取 Bean 实例并使用.
- Spring 提供了两种类型的 IOC 容器实现. 
  - BeanFactory: IOC 容器的基本实现.
  - ApplicationContext: 提供了更多的高级特性. 是 BeanFactory 的子接口.
  - BeanFactory 是 Spring 框架的基础设施，面向 Spring 本身；ApplicationContext 面向使用 Spring 框架的开发者，几乎所有的应用场合都直接使用 ApplicationContext 而非底层的 BeanFactory
  - 无论使用何种方式, 配置文件时相同的.
- **ApplicationContext** 的主要实现类：
  - ClassPathXmlApplicationContext：从 类路径下加载配置文件
  - FileSystemXmlApplicationContext: 从文件系统中加载配置文件
  - ConfigurableApplicationContext 扩展于 ApplicationContext，新增加两个主要方法：refresh() 和 close()， 让 ApplicationContext 具有启动、刷新和关闭上下文的能力
  - ApplicationContext 在初始化上下文时就实例化所有单例的 Bean。
  - WebApplicationContext 是专门为 WEB 应用而准备的，它允许从相对于 WEB 根目录的路径中完成初始化工作

![applicationContext](img/applicationContext.png)



- 从 IOC 容器中获取 Bean 

  ![getBean](img/getBean.png)



#### 3.2.4 依赖注入的方式 

- Spring 支持 3 种依赖注入的方式
  - 属性注入
  - 构造器注入
  - 工厂方法注入（很少使用，不推荐）

##### 3.2.4.1属性注入 

- 属性注入即通过 setter 方法注入Bean 的属性值或依赖的对象
- 属性注入使用 `<property>` 元素, 使用 name 属性指定 Bean 的属性名称，value 属性或 `<value>` 子节点指定属性值 
- 属性注入是实际应用中最常用的注入方式

```xml
<!-- 配置一个 bean -->
<bean id="helloWorld2" class="xxxxx.xxx.HelloWorld">
    <!-- 为属性赋值 -->
    <!-- 通过属性注入: 通过 setter 方法注入属性值 -->
    <property name="user" value="Tom"></property>
</bean>
```



##### 3.2.4.2构造方法注入 

- 通过构造方法注入Bean 的属性值或依赖的对象，它保证了 Bean 实例在实例化后就可以使用。
- 构造器注入在` <constructor-arg>` 元素里声明属性, `<constructor-arg> `中没有 name 属性

```xml
<!-- 通过构造器注入属性值 -->
<bean id="helloWorld3" class="xxx.HelloWorld">
    <!-- 要求: 在 Bean 中必须有对应的构造器.  -->
    <constructor-arg value="Mike"></constructor-arg>
</bean>

<!-- 若一个 bean 有多个构造器, 如何通过构造器来为 bean 的属性赋值 -->
<!-- 可以根据 index 和 value 进行更加精确的定位. (了解) -->
<!-- 对应了相应的构造器 -->
<bean id="car" class="xxx.Car">
    <constructor-arg value="KUGA" index="1"></constructor-arg>
    <constructor-arg value="ChangAnFord" index="0"></constructor-arg>
    <constructor-arg value="250000" type="float"></constructor-arg>
</bean>
```



#### 3.2.5 字面值 

- 字面值：可用字符串表示的值，可以通过 <value> 元素标签或 value 属性进行注入。
- 基本数据类型及其封装类、String 等类型都可以采取字面值注入的方式
- 若字面值中包含特殊字符，可以使用 <![CDATA[]]> 把字面值包裹起来。

```xml
<bean id="car2" class="xxx.Car">
    <constructor-arg value="ChangAnMazda"></constructor-arg>
    <!-- 若字面值中包含特殊字符, 则可以使用 DCDATA 来进行赋值. (了解) -->
    <constructor-arg>
        <value><![CDATA[<ATARZA>]]></value>
    </constructor-arg>
    <constructor-arg value="180" type="int"></constructor-arg>
</bean>
```



#### 3.2.6 引用其它 Bean 

- 组成应用程序的 Bean 经常需要相互协作以完成应用程序的功能. 要使 Bean 能够相互访问, 就必须在 Bean 配置文件中指定对 Bean 的引用
- 在 Bean 的配置文件中, 可以通过 `<ref>` 元素或 ref  属性为 Bean 的属性或构造器参数指定对 Bean 的引用. 
- 也可以在属性或构造器里包含 Bean 的声明, 这样的 Bean 称为内部 Bean

```xml
<bean id="dao5" class="xxx.Dao"></bean>

<bean id="service" class="xxx.Service">
    <!-- 通过 ref 属性值指定当前属性指向哪一个 bean! -->
    <property name="dao" ref="dao5"></property>
</bean>
```



#### 3.2.7 内部 Bean 

- 当 Bean 实例仅仅给一个特定的属性使用时, 可以将其声明为内部 Bean. 内部 Bean 声明直接包含在` <property> `或 `<constructor-arg> `元素里, 不需要设置任何 id 或 name 属性
- 内部 Bean 不能使用在任何其他地方

```xml
<!-- 声明使用内部 bean -->
<bean id="service2" class="xxx.Service">
    <property name="dao">
        <!-- 内部 bean, 类似于匿名内部类对象. 不能被外部的 bean 来引用, 也没有必要设置 id 属性 -->
        <bean class="xxx.Dao">
            <property name="dataSource" value="c3p0"></property>
        </bean>
    </property>
</bean>
```



#### 3.2.8 注入参数详解：null 值和级联属性 

- 可以使用专用的 `<null/>` 元素标签为 Bean 的字符串或其它对象类型的属性注入 null 值
- 和 Struts、Hiberante 等框架一样，Spring 支持级联属性的配置。

```xml
<bean id="action" class="xxx.Action">
    <property name="service" ref="service2"></property>
    <!-- 设置级联属性(了解) -->
    <property name="service.dao.dataSource" value="DBCP2"></property>
</bean>

<bean id="dao2" class="xxx.Dao">
    <!-- 为 Dao 的 dataSource 属性赋值为 null, 若某一个 bean 的属性值不是 null, 使用时需要为其设置为 null(了解) -->
    <property name="dataSource"><null/></property>
</bean>
```



#### 3.2.9 集合属性 

- 在 Spring中可以通过一组内置的 xml 标签(例如: `<list>`, `<set>` 或` <map>`) 来配置集合属性.
- 配置 java.util.List 类型的属性, 需要指定` <list> ` 标签, 在标签里包含一些元素. 这些标签可以通过` <value>` 指定简单的常量值, 通过 `<ref>` 指定对其他 Bean 的引用. 通过`<bean>` 指定内置 Bean 定义. 通过` <null/> `指定空元素. 甚至可以内嵌其他集合.
- 数组的定义和 List 一样, 都使用 `<list>`
- 配置 java.util.Set 需要使用 `<set>` 标签, 定义元素的方法与 List 一样.
- Java.util.Map 通过 `<map>` 标签定义, `<map> `标签里可以使用多个` <entry> `作为子标签. 每个条目包含一个键和一个值. 
- 必须在 `<key>` 标签里定义键
- 因为键和值的类型没有限制, 所以可以自由地为它们指定` <value>`, `<ref>`, `<bean>` 或 `<null>` 元素. 
- 可以将 Map 的键和值作为` <entry>` 的属性定义: 简单常量使用 key 和 value 来定义; Bean 引用通过 key-ref 和 value-ref 属性定义
- 使用 `<props> `定义 java.util.Properties, 该标签使用多个 `<prop>` 作为子标签. 每个 `<prop>` 标签必须定义 key 属性. 



```xml
<!-- 装配集合属性 -->
<bean id="user" class="xxx.User">
    <property name="userName" value="Jack"></property>
    <property name="cars">
        <!-- 使用 list 元素来装配集合属性 -->
        <list>
            <ref bean="car"/>
            <ref bean="car2"/>
        </list>
    </property>
</bean>
```



#### 3.2.10 使用 utility scheme 定义集合

- 使用基本的集合标签定义集合时, 不能将集合作为独立的 Bean 定义, 导致其他 Bean 无法引用该集合, 所以无法在不同 Bean 之间共享集合.
- 可以使用 util schema 里的集合标签定义独立的集合 Bean. 需要注意的是, 必须在 <beans> 根元素里添加 util schema 定义

```xml
<!-- 声明集合类型的 bean -->
<util:list id="cars">
    <ref bean="car"/>
    <ref bean="car2"/>
</util:list>

<bean id="user2" class="xxx.User">
    <property name="userName" value="Rose"></property>
    <!-- 引用外部声明的 list -->
    <property name="cars" ref="cars"></property>
</bean>
```



#### 3.2.11 使用 p 命名空间 

- 为了简化 XML 文件的配置，越来越多的 XML 文件采用属性而非子元素配置信息。
- Spring 从 2.5 版本开始引入了一个新的 p 命名空间，可以通过 `<bean> `元素属性的方式配置 Bean 的属性。
- 使用 p 命名空间后，基于 XML 的配置方式将进一步简化

```xml
<bean id="user3" class="xxx.User" p:cars-ref="cars" p:userName="Titannic"></bean>
```



#### 3.2.12 XML 配置里的 Bean 自动装配 

- Spring IOC 容器可以自动装配 Bean. 需要做的仅仅是在 `<bean>` 的 autowire 属性里指定自动装配的模式
- byType(根据类型自动装配): 若 IOC 容器中有多个与目标 Bean 类型一致的 Bean. 在这种情况下, Spring 将无法判定哪个 Bean 最合适该属性, 所以不能执行自动装配.
- byName(根据名称自动装配): 必须将目标 Bean 的名称和属性名设置的完全相同.
- constructor(通过构造器自动装配): 当 Bean 中存在多个构造器时, 此种自动装配方式将会很复杂. **不推荐使用**

```xml
<!-- 自动装配: 只声明 bean, 而把 bean 之间的关系交给 IOC 容器来完成 -->
<!--  
  byType: 根据类型进行自动装配. 但要求 IOC 容器中只有一个类型对应的 bean, 若有多个则无法完成自动装配.
  byName: 若属性名和某一个 bean 的 id 名一致, 即可完成自动装配. 若没有 id 一致的, 则无法完成自动装配
 -->
<!-- 在使用 XML 配置时, 自动转配用的不多. 但在基于 注解 的配置时, 自动装配使用的较多.  -->
<bean id="car" class="xxx.Car" p:id="45949" p:name="kksssk"></bean>
<!--Person{Car car} ,Person 有Car 类型的 car 属性-->
<bean id="person" class="xxx.Person" autowire="byName"></bean>
```

- XML 配置里的 Bean 自动装配的缺点 
  - 在 Bean 配置文件里设置 autowire 属性进行自动装配将会装配 Bean 的所有属性. 然而, 若只希望装配个别属性时, autowire 属性就不够灵活了. 
  - autowire 属性要么根据类型自动装配, 要么根据名称自动装配, 不能两者兼而有之.
  - 一般情况下，在实际的项目中很少使用自动装配功能，因为和自动装配功能所带来的好处比起来，明确清晰的配置文档更有说服力一些

###  3.2.13 继承 Bean 配置&依赖 Bean 配置  

#### 3.2.13.1 继承 Bean 配置

- Spring 允许继承 bean 的配置, 被继承的 bean 称为父 bean. 继承这个父 Bean 的 Bean 称为子 Bean
- 子 Bean 从父 Bean 中继承配置, 包括 Bean 的属性配置
- 子 Bean 也可以覆盖从父 Bean 继承过来的配置
- 父 Bean 可以作为配置模板, 也可以作为 Bean 实例. 若只想把父 Bean 作为模板, 可以设置 <bean> 的abstract 属性为 true, 这样 Spring 将不会实例化这个 Bean
- 并不是 `<bean>` 元素里的所有属性都会被继承. 比如: autowire, abstract 等.
- 也可以忽略父 Bean 的 class 属性, 让子 Bean 指定自己的类, 而共享相同的属性配置. 但此时 abstract 必须设为 true

#### 3.2.13.2 依赖 Bean 配置 
- Spring 允许用户通过 depends-on 属性设定 Bean 前置依赖的Bean，前置依赖的 Bean 会在本 Bean 实例化之前创建好
- 如果前置依赖于多个 Bean，则可以通过逗号，空格或的方式配置 Bean 的名称

```xml
<!-- bean 的配置能够继承吗 ? 使用 parent 来完成继承 -->	
<bean id="user4" parent="user" p:userName="Bob"></bean>

<bean id="user6" parent="user" p:userName="维多利亚"></bean>

<!-- 测试 depents-on -->	
<bean id="user5" parent="user" p:userName="Backham" depends-on="user6"></bean>
```



### 3.2.14 Bean 的作用域 

- 在 Spring 中, 可以在 `<bean>` 元素的 scope 属性里设置 Bean 的作用域. 
- 默认情况下, Spring 只为每个在 IOC 容器里声明的 Bean 创建唯一一个实例, 整个 IOC 容器范围内都能共享该实例：所有后续的 getBean() 调用和 Bean 引用都将返回这个唯一的 Bean 实例.该作用域被称为 **singleton**, 它是所有 Bean 的默认作用域.

![bean作用域](img\bean作用域.png)



