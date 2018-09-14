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



## 三 DQL语言学习(数据处理之查询)

### 1.数据准备

```sql
CREATE DATABASE `myemployees` ;

USE `myemployees`;

DROP TABLE IF EXISTS `departments`;

CREATE TABLE `departments` (
  `department_id` int(4) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(3) DEFAULT NULL,
  `manager_id` int(6) DEFAULT NULL,
  `location_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `loc_id_fk` (`location_id`),
  CONSTRAINT `loc_id_fk` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=gb2312;

/*Data for the table `departments` */
insert  into `departments`(`department_id`,`department_name`,`manager_id`,`location_id`) values (10,'Adm',200,1700),(20,'Mar',201,1800),(30,'Pur',114,1700),(40,'Hum',203,2400),(50,'Shi',121,1500),(60,'IT',103,1400),(70,'Pub',204,2700),(80,'Sal',145,2500),(90,'Exe',100,1700),(100,'Fin',108,1700),(110,'Acc',205,1700),(120,'Tre',NULL,1700),(130,'Cor',NULL,1700),(140,'Con',NULL,1700),(150,'Sha',NULL,1700),(160,'Ben',NULL,1700),(170,'Man',NULL,1700),(180,'Con',NULL,1700),(190,'Con',NULL,1700),(200,'Ope',NULL,1700),(210,'IT ',NULL,1700),(220,'NOC',NULL,1700),(230,'IT ',NULL,1700),(240,'Gov',NULL,1700),(250,'Ret',NULL,1700),(260,'Rec',NULL,1700),(270,'Pay',NULL,1700);

/*Table structure for table `employees` */
DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `employee_id` int(6) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `job_id` varchar(10) DEFAULT NULL,
  `salary` double(10,2) DEFAULT NULL,
  `commission_pct` double(4,2) DEFAULT NULL,
  `manager_id` int(6) DEFAULT NULL,
  `department_id` int(4) DEFAULT NULL,
  `hiredate` datetime DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `dept_id_fk` (`department_id`),
  KEY `job_id_fk` (`job_id`),
  CONSTRAINT `dept_id_fk` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `job_id_fk` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=gb2312;

/*Data for the table `employees` */

insert  into `employees`(`employee_id`,`first_name`,`last_name`,`email`,`phone_number`,`job_id`,`salary`,`commission_pct`,`manager_id`,`department_id`,`hiredate`) values (100,'Steven','K_ing','SKING','515.123.4567','AD_PRES',24000.00,NULL,NULL,90,'1992-04-03 00:00:00'),(101,'Neena','Kochhar','NKOCHHAR','515.123.4568','AD_VP',17000.00,NULL,100,90,'1992-04-03 00:00:00'),(102,'Lex','De Haan','LDEHAAN','515.123.4569','AD_VP',17000.00,NULL,100,90,'1992-04-03 00:00:00'),(103,'Alexander','Hunold','AHUNOLD','590.423.4567','IT_PROG',9000.00,NULL,102,60,'1992-04-03 00:00:00'),(104,'Bruce','Ernst','BERNST','590.423.4568','IT_PROG',6000.00,NULL,103,60,'1992-04-03 00:00:00'),(105,'David','Austin','DAUSTIN','590.423.4569','IT_PROG',4800.00,NULL,103,60,'1998-03-03 00:00:00'),(106,'Valli','Pataballa','VPATABAL','590.423.4560','IT_PROG',4800.00,NULL,103,60,'1998-03-03 00:00:00'),(107,'Diana','Lorentz','DLORENTZ','590.423.5567','IT_PROG',4200.00,NULL,103,60,'1998-03-03 00:00:00'),(108,'Nancy','Greenberg','NGREENBE','515.124.4569','FI_MGR',12000.00,NULL,101,100,'1998-03-03 00:00:00'),(109,'Daniel','Faviet','DFAVIET','515.124.4169','FI_ACCOUNT',9000.00,NULL,108,100,'1998-03-03 00:00:00'),(110,'John','Chen','JCHEN','515.124.4269','FI_ACCOUNT',8200.00,NULL,108,100,'2000-09-09 00:00:00'),(111,'Ismael','Sciarra','ISCIARRA','515.124.4369','FI_ACCOUNT',7700.00,NULL,108,100,'2000-09-09 00:00:00'),(112,'Jose Manuel','Urman','JMURMAN','515.124.4469','FI_ACCOUNT',7800.00,NULL,108,100,'2000-09-09 00:00:00'),(113,'Luis','Popp','LPOPP','515.124.4567','FI_ACCOUNT',6900.00,NULL,108,100,'2000-09-09 00:00:00'),(114,'Den','Raphaely','DRAPHEAL','515.127.4561','PU_MAN',11000.00,NULL,100,30,'2000-09-09 00:00:00'),(115,'Alexander','Khoo','AKHOO','515.127.4562','PU_CLERK',3100.00,NULL,114,30,'2000-09-09 00:00:00'),(116,'Shelli','Baida','SBAIDA','515.127.4563','PU_CLERK',2900.00,NULL,114,30,'2000-09-09 00:00:00'),(117,'Sigal','Tobias','STOBIAS','515.127.4564','PU_CLERK',2800.00,NULL,114,30,'2000-09-09 00:00:00'),(118,'Guy','Himuro','GHIMURO','515.127.4565','PU_CLERK',2600.00,NULL,114,30,'2000-09-09 00:00:00'),(119,'Karen','Colmenares','KCOLMENA','515.127.4566','PU_CLERK',2500.00,NULL,114,30,'2000-09-09 00:00:00'),(120,'Matthew','Weiss','MWEISS','650.123.1234','ST_MAN',8000.00,NULL,100,50,'2004-02-06 00:00:00'),(121,'Adam','Fripp','AFRIPP','650.123.2234','ST_MAN',8200.00,NULL,100,50,'2004-02-06 00:00:00'),(122,'Payam','Kaufling','PKAUFLIN','650.123.3234','ST_MAN',7900.00,NULL,100,50,'2004-02-06 00:00:00'),(123,'Shanta','Vollman','SVOLLMAN','650.123.4234','ST_MAN',6500.00,NULL,100,50,'2004-02-06 00:00:00'),(124,'Kevin','Mourgos','KMOURGOS','650.123.5234','ST_MAN',5800.00,NULL,100,50,'2004-02-06 00:00:00'),(125,'Julia','Nayer','JNAYER','650.124.1214','ST_CLERK',3200.00,NULL,120,50,'2004-02-06 00:00:00'),(126,'Irene','Mikkilineni','IMIKKILI','650.124.1224','ST_CLERK',2700.00,NULL,120,50,'2004-02-06 00:00:00'),(127,'James','Landry','JLANDRY','650.124.1334','ST_CLERK',2400.00,NULL,120,50,'2004-02-06 00:00:00'),(128,'Steven','Markle','SMARKLE','650.124.1434','ST_CLERK',2200.00,NULL,120,50,'2004-02-06 00:00:00'),(129,'Laura','Bissot','LBISSOT','650.124.5234','ST_CLERK',3300.00,NULL,121,50,'2004-02-06 00:00:00'),(130,'Mozhe','Atkinson','MATKINSO','650.124.6234','ST_CLERK',2800.00,NULL,121,50,'2004-02-06 00:00:00'),(131,'James','Marlow','JAMRLOW','650.124.7234','ST_CLERK',2500.00,NULL,121,50,'2004-02-06 00:00:00'),(132,'TJ','Olson','TJOLSON','650.124.8234','ST_CLERK',2100.00,NULL,121,50,'2004-02-06 00:00:00'),(133,'Jason','Mallin','JMALLIN','650.127.1934','ST_CLERK',3300.00,NULL,122,50,'2004-02-06 00:00:00'),(134,'Michael','Rogers','MROGERS','650.127.1834','ST_CLERK',2900.00,NULL,122,50,'2002-12-23 00:00:00'),(135,'Ki','Gee','KGEE','650.127.1734','ST_CLERK',2400.00,NULL,122,50,'2002-12-23 00:00:00'),(136,'Hazel','Philtanker','HPHILTAN','650.127.1634','ST_CLERK',2200.00,NULL,122,50,'2002-12-23 00:00:00'),(137,'Renske','Ladwig','RLADWIG','650.121.1234','ST_CLERK',3600.00,NULL,123,50,'2002-12-23 00:00:00'),(138,'Stephen','Stiles','SSTILES','650.121.2034','ST_CLERK',3200.00,NULL,123,50,'2002-12-23 00:00:00'),(139,'John','Seo','JSEO','650.121.2019','ST_CLERK',2700.00,NULL,123,50,'2002-12-23 00:00:00'),(140,'Joshua','Patel','JPATEL','650.121.1834','ST_CLERK',2500.00,NULL,123,50,'2002-12-23 00:00:00'),(141,'Trenna','Rajs','TRAJS','650.121.8009','ST_CLERK',3500.00,NULL,124,50,'2002-12-23 00:00:00'),(142,'Curtis','Davies','CDAVIES','650.121.2994','ST_CLERK',3100.00,NULL,124,50,'2002-12-23 00:00:00'),(143,'Randall','Matos','RMATOS','650.121.2874','ST_CLERK',2600.00,NULL,124,50,'2002-12-23 00:00:00'),(144,'Peter','Vargas','PVARGAS','650.121.2004','ST_CLERK',2500.00,NULL,124,50,'2002-12-23 00:00:00'),(145,'John','Russell','JRUSSEL','011.44.1344.429268','SA_MAN',14000.00,0.40,100,80,'2002-12-23 00:00:00'),(146,'Karen','Partners','KPARTNER','011.44.1344.467268','SA_MAN',13500.00,0.30,100,80,'2002-12-23 00:00:00'),(147,'Alberto','Errazuriz','AERRAZUR','011.44.1344.429278','SA_MAN',12000.00,0.30,100,80,'2002-12-23 00:00:00'),(148,'Gerald','Cambrault','GCAMBRAU','011.44.1344.619268','SA_MAN',11000.00,0.30,100,80,'2002-12-23 00:00:00'),(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018','SA_MAN',10500.00,0.20,100,80,'2002-12-23 00:00:00'),(150,'Peter','Tucker','PTUCKER','011.44.1344.129268','SA_REP',10000.00,0.30,145,80,'2014-03-05 00:00:00'),(151,'David','Bernstein','DBERNSTE','011.44.1344.345268','SA_REP',9500.00,0.25,145,80,'2014-03-05 00:00:00'),(152,'Peter','Hall','PHALL','011.44.1344.478968','SA_REP',9000.00,0.25,145,80,'2014-03-05 00:00:00'),(153,'Christopher','Olsen','COLSEN','011.44.1344.498718','SA_REP',8000.00,0.20,145,80,'2014-03-05 00:00:00'),(154,'Nanette','Cambrault','NCAMBRAU','011.44.1344.987668','SA_REP',7500.00,0.20,145,80,'2014-03-05 00:00:00'),(155,'Oliver','Tuvault','OTUVAULT','011.44.1344.486508','SA_REP',7000.00,0.15,145,80,'2014-03-05 00:00:00'),(156,'Janette','K_ing','JKING','011.44.1345.429268','SA_REP',10000.00,0.35,146,80,'2014-03-05 00:00:00'),(157,'Patrick','Sully','PSULLY','011.44.1345.929268','SA_REP',9500.00,0.35,146,80,'2014-03-05 00:00:00'),(158,'Allan','McEwen','AMCEWEN','011.44.1345.829268','SA_REP',9000.00,0.35,146,80,'2014-03-05 00:00:00'),(159,'Lindsey','Smith','LSMITH','011.44.1345.729268','SA_REP',8000.00,0.30,146,80,'2014-03-05 00:00:00'),(160,'Louise','Doran','LDORAN','011.44.1345.629268','SA_REP',7500.00,0.30,146,80,'2014-03-05 00:00:00'),(161,'Sarath','Sewall','SSEWALL','011.44.1345.529268','SA_REP',7000.00,0.25,146,80,'2014-03-05 00:00:00'),(162,'Clara','Vishney','CVISHNEY','011.44.1346.129268','SA_REP',10500.00,0.25,147,80,'2014-03-05 00:00:00'),(163,'Danielle','Greene','DGREENE','011.44.1346.229268','SA_REP',9500.00,0.15,147,80,'2014-03-05 00:00:00'),(164,'Mattea','Marvins','MMARVINS','011.44.1346.329268','SA_REP',7200.00,0.10,147,80,'2014-03-05 00:00:00'),(165,'David','Lee','DLEE','011.44.1346.529268','SA_REP',6800.00,0.10,147,80,'2014-03-05 00:00:00'),(166,'Sundar','Ande','SANDE','011.44.1346.629268','SA_REP',6400.00,0.10,147,80,'2014-03-05 00:00:00'),(167,'Amit','Banda','ABANDA','011.44.1346.729268','SA_REP',6200.00,0.10,147,80,'2014-03-05 00:00:00'),(168,'Lisa','Ozer','LOZER','011.44.1343.929268','SA_REP',11500.00,0.25,148,80,'2014-03-05 00:00:00'),(169,'Harrison','Bloom','HBLOOM','011.44.1343.829268','SA_REP',10000.00,0.20,148,80,'2014-03-05 00:00:00'),(170,'Tayler','Fox','TFOX','011.44.1343.729268','SA_REP',9600.00,0.20,148,80,'2014-03-05 00:00:00'),(171,'William','Smith','WSMITH','011.44.1343.629268','SA_REP',7400.00,0.15,148,80,'2014-03-05 00:00:00'),(172,'Elizabeth','Bates','EBATES','011.44.1343.529268','SA_REP',7300.00,0.15,148,80,'2014-03-05 00:00:00'),(173,'Sundita','Kumar','SKUMAR','011.44.1343.329268','SA_REP',6100.00,0.10,148,80,'2014-03-05 00:00:00'),(174,'Ellen','Abel','EABEL','011.44.1644.429267','SA_REP',11000.00,0.30,149,80,'2014-03-05 00:00:00'),(175,'Alyssa','Hutton','AHUTTON','011.44.1644.429266','SA_REP',8800.00,0.25,149,80,'2014-03-05 00:00:00'),(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265','SA_REP',8600.00,0.20,149,80,'2014-03-05 00:00:00'),(177,'Jack','Livingston','JLIVINGS','011.44.1644.429264','SA_REP',8400.00,0.20,149,80,'2014-03-05 00:00:00'),(178,'Kimberely','Grant','KGRANT','011.44.1644.429263','SA_REP',7000.00,0.15,149,NULL,'2014-03-05 00:00:00'),(179,'Charles','Johnson','CJOHNSON','011.44.1644.429262','SA_REP',6200.00,0.10,149,80,'2014-03-05 00:00:00'),(180,'Winston','Taylor','WTAYLOR','650.507.9876','SH_CLERK',3200.00,NULL,120,50,'2014-03-05 00:00:00'),(181,'Jean','Fleaur','JFLEAUR','650.507.9877','SH_CLERK',3100.00,NULL,120,50,'2014-03-05 00:00:00'),(182,'Martha','Sullivan','MSULLIVA','650.507.9878','SH_CLERK',2500.00,NULL,120,50,'2014-03-05 00:00:00'),(183,'Girard','Geoni','GGEONI','650.507.9879','SH_CLERK',2800.00,NULL,120,50,'2014-03-05 00:00:00'),(184,'Nandita','Sarchand','NSARCHAN','650.509.1876','SH_CLERK',4200.00,NULL,121,50,'2014-03-05 00:00:00'),(185,'Alexis','Bull','ABULL','650.509.2876','SH_CLERK',4100.00,NULL,121,50,'2014-03-05 00:00:00'),(186,'Julia','Dellinger','JDELLING','650.509.3876','SH_CLERK',3400.00,NULL,121,50,'2014-03-05 00:00:00'),(187,'Anthony','Cabrio','ACABRIO','650.509.4876','SH_CLERK',3000.00,NULL,121,50,'2014-03-05 00:00:00'),(188,'Kelly','Chung','KCHUNG','650.505.1876','SH_CLERK',3800.00,NULL,122,50,'2014-03-05 00:00:00'),(189,'Jennifer','Dilly','JDILLY','650.505.2876','SH_CLERK',3600.00,NULL,122,50,'2014-03-05 00:00:00'),(190,'Timothy','Gates','TGATES','650.505.3876','SH_CLERK',2900.00,NULL,122,50,'2014-03-05 00:00:00'),(191,'Randall','Perkins','RPERKINS','650.505.4876','SH_CLERK',2500.00,NULL,122,50,'2014-03-05 00:00:00'),(192,'Sarah','Bell','SBELL','650.501.1876','SH_CLERK',4000.00,NULL,123,50,'2014-03-05 00:00:00'),(193,'Britney','Everett','BEVERETT','650.501.2876','SH_CLERK',3900.00,NULL,123,50,'2014-03-05 00:00:00'),(194,'Samuel','McCain','SMCCAIN','650.501.3876','SH_CLERK',3200.00,NULL,123,50,'2014-03-05 00:00:00'),(195,'Vance','Jones','VJONES','650.501.4876','SH_CLERK',2800.00,NULL,123,50,'2014-03-05 00:00:00'),(196,'Alana','Walsh','AWALSH','650.507.9811','SH_CLERK',3100.00,NULL,124,50,'2014-03-05 00:00:00'),(197,'Kevin','Feeney','KFEENEY','650.507.9822','SH_CLERK',3000.00,NULL,124,50,'2014-03-05 00:00:00'),(198,'Donald','OConnell','DOCONNEL','650.507.9833','SH_CLERK',2600.00,NULL,124,50,'2014-03-05 00:00:00'),(199,'Douglas','Grant','DGRANT','650.507.9844','SH_CLERK',2600.00,NULL,124,50,'2014-03-05 00:00:00'),(200,'Jennifer','Whalen','JWHALEN','515.123.4444','AD_ASST',4400.00,NULL,101,10,'2016-03-03 00:00:00'),(201,'Michael','Hartstein','MHARTSTE','515.123.5555','MK_MAN',13000.00,NULL,100,20,'2016-03-03 00:00:00'),(202,'Pat','Fay','PFAY','603.123.6666','MK_REP',6000.00,NULL,201,20,'2016-03-03 00:00:00'),(203,'Susan','Mavris','SMAVRIS','515.123.7777','HR_REP',6500.00,NULL,101,40,'2016-03-03 00:00:00'),(204,'Hermann','Baer','HBAER','515.123.8888','PR_REP',10000.00,NULL,101,70,'2016-03-03 00:00:00'),(205,'Shelley','Higgins','SHIGGINS','515.123.8080','AC_MGR',12000.00,NULL,101,110,'2016-03-03 00:00:00'),(206,'William','Gietz','WGIETZ','515.123.8181','AC_ACCOUNT',8300.00,NULL,205,110,'2016-03-03 00:00:00');

/*Table structure for table `jobs` */
DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `job_id` varchar(10) NOT NULL,
  `job_title` varchar(35) DEFAULT NULL,
  `min_salary` int(6) DEFAULT NULL,
  `max_salary` int(6) DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

/*Data for the table `jobs` */
insert  into `jobs`(`job_id`,`job_title`,`min_salary`,`max_salary`) values ('AC_ACCOUNT','Public Accountant',4200,9000),('AC_MGR','Accounting Manager',8200,16000),('AD_ASST','Administration Assistant',3000,6000),('AD_PRES','President',20000,40000),('AD_VP','Administration Vice President',15000,30000),('FI_ACCOUNT','Accountant',4200,9000),('FI_MGR','Finance Manager',8200,16000),('HR_REP','Human Resources Representative',4000,9000),('IT_PROG','Programmer',4000,10000),('MK_MAN','Marketing Manager',9000,15000),('MK_REP','Marketing Representative',4000,9000),('PR_REP','Public Relations Representative',4500,10500),('PU_CLERK','Purchasing Clerk',2500,5500),('PU_MAN','Purchasing Manager',8000,15000),('SA_MAN','Sales Manager',10000,20000),('SA_REP','Sales Representative',6000,12000),('SH_CLERK','Shipping Clerk',2500,5500),('ST_CLERK','Stock Clerk',2000,5000),('ST_MAN','Stock Manager',5500,8500);

/*Table structure for table `locations` */
DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `street_address` varchar(40) DEFAULT NULL,
  `postal_code` varchar(12) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state_province` varchar(25) DEFAULT NULL,
  `country_id` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3201 DEFAULT CHARSET=gb2312;

/*Data for the table `locations` */
insert  into `locations`(`location_id`,`street_address`,`postal_code`,`city`,`state_province`,`country_id`) values (1000,'1297 Via Cola di Rie','00989','Roma',NULL,'IT'),(1100,'93091 Calle della Testa','10934','Venice',NULL,'IT'),(1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP'),(1300,'9450 Kamiya-cho','6823','Hiroshima',NULL,'JP'),(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),(1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US'),(1700,'2004 Charade Rd','98199','Seattle','Washington','US'),(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'),(1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA'),(2000,'40-5-12 Laogianggen','190518','Beijing',NULL,'CN'),(2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN'),(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU'),(2300,'198 Clementi North','540198','Singapore',NULL,'SG'),(2400,'8204 Arthur St',NULL,'London',NULL,'UK'),(2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK'),(2600,'9702 Chester Road','09629850293','Stretford','Manchester','UK'),(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE'),(2800,'Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR'),(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH'),(3000,'Murtenstrasse 921','3095','Bern','BE','CH'),(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL'),(3200,'Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');
```





 ### 2. 基本select查询

```mysql
SELECT *|{[DISTINCT] column|expression [alias],...} FROM table;
```

- SELECT 标识选择哪些列。
- FROM 标识从哪个表中选择。
- 特点：
  - ①通过select查询完的结果 ，是一个虚拟的表格，不是真实存在
  - ② 要查询的东西 可以是常量值、可以是表达式、可以是字段、可以是函数

#### 2.1 选择全部列

```sql
SELECT * FROM   departments;
```

#### 2.2 选择特定的列

```sql
SELECT department_id, location_id FROM   departments;
```

#### 2.3  查询常量值,表达式,函数

```mysql
#查询常量值
SELECT 1000 ;
SELECT 'join' ;
#查询表达式
SELECT 100*80 ;
#查询函数
SELECT VERSION() ;
```



### 3.列的别名

 #### 3.1 列的别名: 
 - 重命名一个列。

 - 便于计算。

 - 紧跟列名，也可以在列名和别名之间加入关键字 ‘AS’，别名使用**双引号**，以便在别名中包含空格或特殊的字符并区分大小写。

#### 3.2 使用别名

```sql
SELECT last_name AS name, commission_pct comm FROM   employees;
SELECT last_name "Name", salary*12 "Annual Salary" FROM   employees;
```



### 4.去重(DISTINCT)

```sql
SELECT  DISTINCT department_id FROM employees ;
```



### 5.+号和concat

- +号: 仅仅只有一个功能 ---- 运算符

  ```mysql
  # 两个操作数都为数值型，则做加法运算
  select 100+90;
  # 只要其中一方为字符型，试图将字符型数值转换成数值型
  # 如果转换成功，则继续做加法运算
  # 如果转换失败，则将字符型数值转换成0
  select '123'+90;
  # 只要其中一方为null，则结果肯定为null 
  select nul1+10;
  ```

- concat: 连接字符

  ```sql
  SELECT CONCAT(employees.first_name,employees.last_name) AS 姓名 FROM employees  ;
  ```

  

### 6.条件查询

- 根据条件过滤原始表的数据，查询到想要的数据

- 语法：

  ```sql
  select  要查询的字段|表达式|常量值|函数 from 表 where 条件 ;
  ```

- 条件分类

  - 条件表达式
    - 示例：salary>10000
    - 条件运算符：

      `> < >= <= = != <>`

  - 逻辑表达式
    - 示例：salary>10000 && salary<20000

    - 例子: 查询部门编号不是在90到110之间，或者工资高于15000的员工信息

      ```sql
      SELECT * FROM employees WHERE NOT(department_id>=90 AND  department_id<=110) OR salary>15000;
      ```

      

    - 逻辑运算符

      - and（&&）:两个条件如果同时成立，结果为true，否则为false
      - or(||)：两个条件只要有一个成立，结果为true，否则为false
      - not(!)：如果条件成立，则not后为false，否则为true

- 模糊查询

  - 示例：last_name like 'a%'

  - 关键字

    - like , between , and , in is null

  - 关键字详细

    - 一般和通配符搭配使用

    - 通配符：

       % 任意多个字符,包含0个字符
       _  任意单个字符

    - **like**
      - 案例1：查询员工名中包含字符a的员工信息

      ```sql
      select 	* fromemployees where last_name like '%a%';
      ```

      - 案例2：查询员工名中第三个字符为n，第五个字符为l的员工名和工资

      ```sql
      select last_name,salary FROM employees WHERE last_name LIKE '__n_l%';
      ```

      - 案例3：查询员工名中第二个字符为_的员工名

      ```sql
      SELECT last_name FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$';
      ```

    - **between and**

      - 含义:判断某字段的值在条件范围内

      - 特点

        - ①使用between and 可以提高语句的简洁度
        - ②包含临界值
        - ③两个临界值不要调换顺序

      - 案例: 查询员工编号在100到120之间的员工信息

        ```sql
        SELECT * FROM employees WHERE employee_id >= 120 AND employee_id<=100;
        #----------等价------------
        SELECT * FROM employees WHERE employee_id BETWEEN 120 AND 100;
        
        ```

    - **in**

      - 含义：判断某字段的值是否属于in列表中的某一项
      - 特点：
        - ①使用in提高语句简洁度
        - ②in列表的值类型必须一致或兼容
        - ③in列表中不支持通配符
      - 案例：查询员工的工种编号是 IT_PROG、AD_VP、AD_PRES中的一个员工名和工种编号

      ```sql
      SELECT last_name,job_id FROM employees WHERE job_id = 'IT_PROT' OR job_id = 'AD_VP' OR JOB_ID ='AD_PRES';
      #-----等价-------------
      SELECT last_name,job_id FROM employees WHERE job_id IN( 'IT_PROT' ,'AD_VP','AD_PRES');
      ```

    - **is null**

      - 特点

        - =或<>不能用于判断null值
        - is null或is not null 可以判断null值

      - 案例1：查询没有奖金的员工名和奖金率

        ```sql
        SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NULL;
        ```

      - 案例2：查询有奖金的员工名和奖金率

        ```sql
        SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NOT NULL;
        ```

    - 安全等于 <=>

      - 案例1：查询没有奖金的员工名和奖金率

        ```sql
        SELECT last_name,commission_pct FROM employees WHERE commission_pct <=> NULL;
        ```

      - 案例2：查询工资为12000的员工信息

        ```sql
        SELECT last_name,salary FROM employees WHERE salary <=> 12000;
        ```

    - 比较 `is null`  和 `<=>`

      `IS NULL`:仅仅可以判断NULL值，可读性较高，建议使用
      `<=> ` :既可以判断NULL值，又可以判断普通的数值，可读性较低

### 7.排序查询(order by)

- 语法 

  ```sql
  语法：
  select 要查询的东西 from 表 where 条件 order by 排序的字段|表达式|函数|别名 【asc|desc】
  ```

- 使用 ORDER BY 子句排序 

  - ASC（ascend）: 升序 
  - DESC（descend）: 降序 

- **ORDER BY 子句在SELECT语句的结尾,limit除外。**

- 例子

  ```sql
  SELECT * FROM employees WHERE employee_id >= 90 ORDER BY hiredate ASC  ;
  
  SELECT *, employees.salary*12*(1 + IFNULL(commission_pct,0)) 年薪 FROM employees ORDER BY 年薪 ASC ;
  
  SELECT LENGTH(last_name) 字节长度, last_name ,salary FROM employees ORDER BY 字节长度 DESC ;
  
  SELECT * FROM employees ORDER BY salary ASC , employee_id DESC ;
  ```



### 8.常见函数

- 概念：类似于java的方法，将一组逻辑语句封装在方法体中，对外暴露方法名
- 好处：1、隐藏了实现细节  2、提高代码的重用性

#### 8.1单行函数

##### 8.1.1 字符函数

- 大小写控制函数 : 改变字符的大小写

  | 函数名 | 函数         | 结果 |
  | ------ | ------------ | ---- |
  | LOWER  | LOWER('Sql') | sql  |
  | UPPER  | UPPER('Sql') | SQL  |


  - 字符控制函数

    | 函数名  | 作用                                   | 函数示例                    | 结果         |
    | ------- | -------------------------------------- | --------------------------- | ------------ |
    | concat  | 拼接                                   | CONCAT('Hello', 'World')    | HelloWorld   |
    | substr  | 截取子串                               | SUBSTR('HelloWorld',1,5)    | Hello        |
    | trim    | 去前后指定的空格和字符                 | TRIM('H' FROM 'HelloWorld') | elloWorld    |
    | ltrim   | 去左边空格                             | ....                        | ...          |
    | rtrim   | 去右边空格                             | ....                        | ...          |
    | replace | 替换                                   | REPLACE('abcd','b','m')     | amcd         |
    | lpad    | 左填充                                 | LPAD(salary,10,'*')         | `*****24000` |
    | rpad    | 右填充                                 | RPAD(salary, 10, '*')       | `24000*****` |
    | instr   | 返回子串第一次出现的索引(找不到,返回0) | INSTR('HelloWorld', 'W')    | 6            |
    | length  | 获取字节个数                           | LENGTH('HelloWorld')        | 10           |

- 注意:

  ```sql
  # sql中,索引从1开始
  
  # 截取从指定索引处后面的所有字符
  
  SELECT SUBSTR('AAAHHH',2) ;
  SELECT SUBSTR('AAAHHH' FROM 2) ;
  
  # 截取从指定索引开始,指定的字符长度
  
  SELECT SUBSTR('AAAHHH',2,3) ;
  
  SELECT SUBSTR('AAAHHH' FROM 2 FOR 3) AS out_put  ;
  
  ```


##### 8.1.2 数学函数

- round 四舍五入
- ceil 向上取整,返回>=该参数的最小整数
- floor 向下取整，返回<=该参数的最大整数
- truncate 截断
- mod取余
- rand 随机数

```sql
#round 四舍五入
SELECT ROUND(-1.55);
SELECT ROUND(1.567,2);


#ceil 向上取整,返回>=该参数的最小整数

SELECT CEIL(-1.02);

#floor 向下取整，返回<=该参数的最大整数
SELECT FLOOR(-9.99);

#truncate 截断

SELECT TRUNCATE(1.69999,1);

#mod取余
/*
mod(a,b) ：  a-a/b*b

mod(-10,-3):-10- (-10)/(-3)*（-3）=-1
*/
SELECT MOD(10,-3);
SELECT 10%3;

# 随机数 RAND
SELECT RAND() * 10 ;
```



##### 8.1.3 日期函数

- `now`:当前系统日期+时间
	 `curdate`:当前系统日期	
- `curtime`:当前系统时间
- `str_to_date`:将字符转换成日期
- `date_format`:将日期转换成字符

```sql
#now 返回当前系统日期+时间
SELECT NOW();

#curdate 返回当前系统日期，不包含时间
SELECT CURDATE();

#curtime 返回当前时间，不包含日期
SELECT CURTIME();

#可以获取指定的部分，年、月、日、小时、分钟、秒
SELECT YEAR(NOW()) 年;
SELECT YEAR('1998-1-1') 年;
SELECT  YEAR(hiredate) 年 FROM employees;
SELECT MONTH(NOW()) 月;
SELECT MONTHNAME(NOW()) 月;

#str_to_date 将字符通过指定的格式转换成日期
SELECT STR_TO_DATE('1998-3-2','%Y-%c-%d') AS out_put;

#查询入职日期为1992--4-3的员工信息
SELECT * FROM employees WHERE hiredate = '1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y');

#date_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%y年%m月%d日') AS out_put;

#查询有奖金的员工名和入职日期(xx月/xx日 xx年)
SELECT last_name,DATE_FORMAT(hiredate,'%m月/%d日 %y年') 入职日期
FROM employees
WHERE commission_pct IS NOT NULL;
```

- 格式符

| 序号 | 格式符 | 功能                |
| ---- | ------ | ------------------- |
| 1    | %Y     | 四位的年份          |
| 2    | %y     | 2位的年份           |
| 3    | %m     | 月份 (01,02…11,12） |
| 4    | %c     | 月（1,2,…11,12）    |
| 5    | %d     | 日（01,02,…）       |
| 6    | %H     | 小时(24小时制）     |
| 7    | %h     | 小时（12小时制）    |
| 8    | %i     | 分钟（00,01…59）    |
| 9    | %s     | 秒（00,01,…59）     |



##### 8.1.4 其他函数

- SELECT VERSION();//查询mysql版本
- SELECT DATABASE();//查询当前数据库
- SELECT USER();//查询用户

##### 8.1.5 流程控制函数

- **if函数： if else 的效果**

  ```sql
  SELECT IF(10<5,'大','小');
  
  SELECT last_name,commission_pct,IF(commission_pct IS NULL,'没奖金，呵呵','有奖金，嘻嘻') 备注
  FROM employees;
  ```

- **case函数的使用一： switch case 的效果**

  ```mysql
  case 要判断的字段或表达式
    when 常量1 then 要显示的值1或语句1;
    when 常量2 then 要显示的值2或语句2;
    ...
    else 要显示的值n或语句n;
  end
  -----------------
  case 
  when 条件1 then 要显示的值1或语句1
  when 条件2 then 要显示的值2或语句2
  。。。
  else 要显示的值n或语句n
  end
  ```


  ```mysql
  /*案例：查询员工的工资，要求
  
  部门号=30，显示的工资为1.1倍
  部门号=40，显示的工资为1.2倍
  部门号=50，显示的工资为1.3倍
  其他部门，显示的工资为原工资
  */
  
  SELECT salary 原始工资,department_id,
  CASE department_id
  WHEN 30 THEN salary*1.1
  WHEN 40 THEN salary*1.2
  WHEN 50 THEN salary*1.3
  ELSE salary
  END AS 新工资
  FROM employees;
  
  /*案例：查询员工的工资的情况
  如果工资>20000,显示A级别
  如果工资>15000,显示B级别
  如果工资>10000，显示C级别
  否则，显示D级别
  */
  
  SELECT salary,
  CASE 
  WHEN salary>20000 THEN 'A'
  WHEN salary>15000 THEN 'B'
  WHEN salary>10000 THEN 'C'
  ELSE 'D'
  END AS 工资级别
  FROM employees;
  ```

  

#### 8.2 分组函数(统计函数,聚合函数,组函数)

- 功能：用作统计使用，又称为聚合函数或统计函数或组函数
- 分类：
  - `sum` 求和、`avg` 平均值、`max` 最大值 、`min` 最小值 、`count` 计算个数
- 特点：
- 1、`sum`、`avg`一般用于处理数值型,`max`、`min`、`count`可以处理任何类型

- 2、以上分组函数都忽略null值
- 3、可以和`distinct`搭配实现去重的运算
- 4、`count`函数的单独介绍
  - 一般使用count(*)用作统计行数

- 5、和分组函数一同查询的字段要求是group by后的字段



```sql
#1、简单 的使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT COUNT(salary) FROM employees;


SELECT SUM(salary) 和,AVG(salary) 平均,MAX(salary) 最高,MIN(salary) 最低,COUNT(salary) 个数
FROM employees;

SELECT SUM(salary) 和,ROUND(AVG(salary),2) 平均,MAX(salary) 最高,MIN(salary) 最低,COUNT(salary) 个数
FROM employees;

#2、参数支持哪些类型

SELECT SUM(last_name) ,AVG(last_name) FROM employees;
SELECT SUM(hiredate) ,AVG(hiredate) FROM employees;
SELECT MAX(last_name),MIN(last_name) FROM employees;
SELECT MAX(hiredate),MIN(hiredate) FROM employees;
SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(last_name) FROM employees;

#3、是否忽略null

SELECT SUM(commission_pct) ,AVG(commission_pct),SUM(commission_pct)/35,SUM(commission_pct)/107 FROM employees;
SELECT MAX(commission_pct) ,MIN(commission_pct) FROM employees;
SELECT COUNT(commission_pct) FROM employees;
SELECT commission_pct FROM employees;

#4、和distinct搭配

SELECT SUM(DISTINCT salary),SUM(salary) FROM employees;
SELECT COUNT(DISTINCT salary),COUNT(salary) FROM employees;

#5、count函数的详细介绍

SELECT COUNT(salary) FROM employees;
SELECT COUNT(*) FROM employees;
SELECT COUNT(1) FROM employees;

/*
效率：
MYISAM存储引擎下  ，COUNT(*)的效率高
INNODB存储引擎下，COUNT(*)和COUNT(1)的效率差不多，比COUNT(字段)要高一些
*/

#6、和分组函数一同查询的字段有限制

SELECT AVG(salary),employee_id  FROM employees;
```



### 9 分组查询

#### 9.1 语法

```sql
select 查询列表 from 表 【where 筛选条件】 group by 分组的字段【order by 排序的字段】;
```



#### 9.2 特点

- 1、和分组函数一同查询的字段必须是group by后出现的字段
- 2、筛选分为两类：分组前筛选和分组后筛选

| #          | 针对的表            | 位置       | 连接的关键字 |
| ---------- | ------------------- | ---------- | ------------ |
| 分组前筛选 | 原始表              | group by前 | where        |
| 分组后筛选 | group by 后的结果集 | group by后 | having       |

- 问题
  - 问题1：分组函数做筛选能不能放在where后面

    答：不能

  - 问题2：where——group by——having

    一般来讲，能用分组前筛选的，尽量使用分组前筛选，提高效率

- 3、分组可以按单个字段也可以按多个字段
- 4、可以搭配着排序使用

#### 9.3 案例

```sql
#1.简单的分组

#案例1：查询每个工种的员工平均工资
SELECT AVG(salary),job_id FROM employees GROUP BY job_id;
#案例2：查询每个位置的部门个数
SELECT COUNT(*),location_id FROM departments GROUP BY location_id;

#2、可以实现分组前的筛选

#案例1：查询邮箱中包含a字符的 每个部门的最高工资
SELECT MAX(salary),department_id FROM employees WHERE email LIKE '%a%' GROUP BY department_id;
#案例2：查询有奖金的每个领导手下员工的平均工资
SELECT AVG(salary),manager_id FROM employees WHERE commission_pct IS NOT NULL GROUP BY manager_id;

#3、分组后筛选

#案例1：查询哪个部门的员工个数>5
#①查询每个部门的员工个数
SELECT COUNT(*),department_id FROM employees GROUP BY department_id;
#② 筛选刚才①结果
SELECT COUNT(*),department_id FROM employees GROUP BY department_id HAVING COUNT(*)>5;

#案例2：每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT job_id,MAX(salary) FROM employees WHERE commission_pct IS NOT NULL GROUP BY job_id HAVING MAX(salary)>12000;

#案例3：领导编号>102的每个领导手下的最低工资大于5000的领导编号和最低工资
SELECT manager_id,MIN(salary) FROM employees WHERE manager_id>102 GROUP BY manager_id HAVING MIN(salary)>5000;

#4.添加排序

#案例：每个工种有奖金的员工的最高工资>6000的工种编号和最高工资,按最高工资升序
SELECT job_id,MAX(salary) m FROM employees WHERE commission_pct IS NOT NULL GROUP BY job_id HAVING m>6000 ORDER BY m ;

#5.按多个字段分组

#案例：查询每个工种每个部门的最低工资,并按最低工资降序
SELECT MIN(salary),job_id,department_id FROM employees GROUP BY department_id,job_id ORDER BY MIN(salary) DESC;
```



### 10 连接查询



​					
​						
​	
​	    			

