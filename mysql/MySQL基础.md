# MySQL基础



## 一 数据库和Sql概述

### 1 数据库的好处

- 1.持久化数据到本地
- 2.可以实现结构化查询，方便管理

### 2 数据库相关概念

- 1、DB：数据库，保存一组有组织的数据的容器
- 2、DBMS：数据库管理系统，又称为数据库软件（产品），用于管理DB中的数据
- 3、SQL:结构化查询语言，用于和DBMS通信的语言

### 3 数据库存储数据的特点

-  1、将数据放到表中，表再放到库中
- 2、一个数据库中可以有多个表，每个表都有一个的名字，用来标识自己。表名具有唯一性。
- 3、表具有一些特性，这些特性定义了数据在表中如何存储，类似java中 “类”的设计。
- 4、表由列组成，我们也称为字段。所有表都是由一个或多个列组成的，每一列类似java 中的”属性”
- 5、表中的数据是按行存储的，每一行类似于java中的“对象”。

### 4 Sql语言概述

 #### 4.1 SQL的优点 

- 1、不是某个特定数据库供应商专有的语言，几乎所有 DBMS都支持SQL
-  2、简单易学 
- 3、虽然简单，但实际上是一种强有力的语言，灵活使用其语言元素，可以进行非常复杂和高级的数据库操作。

#### 4.2 SQL语言分类

- 1、DML(Data Manipulation Language):数据操纵语句，用于添加、删除、修改、查询数据库记录，并检查数据完整性 
- 2、DDL(Data Definition Language):数据定义语句，用于库和表的创建、修改、删除。 
- 3、DCL(Data Control Language):数据控制语句，用于定义用 户的访问权限和安全级别。

##### 4.2.1 DML

- DML用于查询与修改数据记录，包括如下SQL语句：
  - INSERT：添加数据到数据库中 
  - UPDATE：修改数据库中的数据 
  - DELETE：删除数据库中的数据 
  - SELECT：选择（查询）数据 
    - SELECT是SQL语言的基础，最为重要。

##### 4.2.2 DDL

- DDL用于定义数据库的结构，比如创建、修改或删除 数据库对象，包括如下SQL语句：
  - CREATE TABLE：创建数据库表 
  - ALTER TABLE：更改表结构、添加、删除、修改列长度 
  - DROP TABLE：删除表 
  - CREATE INDEX：在表上建立索引 
  - DROP INDEX：删除索引

 ##### 4.2.3 DCL 

- DCL用来控制数据库的访问，包括如下SQL语句：
  - GRANT：授予访问权限 
  - REVOKE：撤销访问权限 
  - COMMIT：提交事务处理 
  - ROLLBACK：事务处理回退 
  - SAVEPOINT：设置保存点 
  - LOCK：对数据库的特定部分进行锁定



## 二 MySQL安装与使用



###  1 Mysql产品特点

- MySQL数据库隶属于MySQL AB公司，总 部位于瑞典，后被oracle收购。
- 优点
  - 成本低：开放源代码，一般可以免费试用
  - 性能高：执行很快
  - 简单：很容易安装和使用

### 2 MySql数据库的安装 

#### 2.1DBMS分为两类

- 基于共享文件系统的DBMS （Access ） 
- 基于客户机
  - 服务器的DBMS （MySQL、Oracle、SqlServer）

#### 2.2下载与安装

- 参见:    [csdn博客]: https://blog.csdn.net/hgx_suiyuesusu/article/details/78368997


#### 2.3启动和停止MySQL服务

- 方式一：通过计算机管理方式 
  - 右击计算机—管理—服务—启动或停止MySQL服务
- 方式二：通过命令行方式
  - 启动: net start mysql服务名 
  - 停止: net stop mysql服务名

#### 2.4 MySQL服务端的登录和退出

- 登录 

  - `mysql 【-h主机名 -P端口号 】-u用户名 -p密码`

- 退出 

  - `exit或ctrl+C`

  

### 3 MySql数据库的使用

#### 3.1 MySQL语法规范

 - 1.不区分大小写,但建议关键字大写，表名、列名小写
 - 2.每条命令最好用分号结尾
 - 3.每条命令根据需要，可以进行缩进 或换行
 - 4.注释
   - 单行注释：#注释文字
   - 单行注释：-- 注释文字
   - 多行注释：/* 注释文字  */

#### 3.2 MySQL的常见命令 

```mysql
#1.查看当前所有的数据库
show databases;

#2.打开指定的库
use 库名

#3.查看当前库的所有表
show tables;

#4.查看其它库的所有表
show tables from 库名;

#5.创建表
create table 表名(

	列名 列类型,
	列名 列类型，
	。。。
);

#6.删除表
drop table 表名 ;

#7.查看表结构
desc 表名;

#8.查看服务器的版本
#方式一：登录到mysql服务端
select version();
#方式二：没有登录到mysql服务端
mysql --version
mysql --V

#9.显示表中的所有数据
select * from 表名;

#10.查询特定的列 
select 列名1,列名2, ... from 表名


#11.向表中插入记录, 注意：插入 varchar 或 date 型的数据要用 单引号 引起来
insert into 表名(列名列表) values(列对应的值的列表);

#12.修改记录
update 表名 set 列1 = 列1的值, 列2 = 列2的值 where ...

#13.删除记录
delete from 表名 where ...
```





  