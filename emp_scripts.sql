-- 创建表
/*
创建员工表employee，字段如下
    id（员工编号），name（员工名字），gender(员工性别)，salary(员工薪资)
*/
use  mydb1;
-- create table employee(
-- id int primary key,
-- ename varchar(20),
-- gender varchar(20),
-- salary int
-- );

-- use  mydb1;
-- create table empl(
-- id int primary key,
-- ename varchar(20),
-- gender varchar(20),
-- salary int
-- );
drop table empl;



create table mydb1.emp2(
id int ,
ename varchar(20),
gender varchar(20),
salary int,
primary key (id)
);
-- 主键的作用  唯一非空
insert into emp2 values(1001,'张三','男',5000);


create table mydb1.emp3(
id int ,
ename varchar(20),
gender varchar(20),
salary int,
primary key (id,ename,gender)
);
insert into emp3 values(1001,'张三','男',5000);
insert into emp3 values(1001,'lisi','男',5000);
insert into emp3 values(1001,NULL,'男',5000);

create table mydb1.emp4(
id int ,
ename varchar(20),
gender varchar(20),
salary int
);
alter table emp4 add primary key (id,ename);
alter table emp4 drop primary key ;

create table mydb1.emp5(
id int primary key auto_increment,
ename varchar(20),
gender varchar(20),
salary int
);
insert into emp5 values(NULL,'沈棠','女',5000);
insert into emp5 values(NULL,'林风','女',5000);

create table mydb1.emp7(
id int primary key auto_increment,
ename varchar(20),
gender varchar(20),
salary int
);
alter table emp7 auto_increment=100;
insert into emp7 values(NULL,'沈棠','女',5000);
insert into emp7 values(NULL,'林风','女',5000);
delete from emp7;
truncate  emp7;

create table mydb1.emp8(
id int primary key auto_increment,
ename varchar(20) ,
gender varchar(20) DEFAULT '女',
salary int
);

insert into emp8 (id,ename,salary) values(NULL,'林风',5000);

drop table emp5;
insert into emp8 values(NULL,'褚曜', '男', 25);


insert into emp7 values(NULL,'褚曜', '男', 25);
/*
1,'张三','男',2000
2,'李四','男',1000
3,'王五','女',4000
*/
insert into  employee values
(1001,'张三','男',2000),
(1002,'李四','男',1000),
(1003,'王五','女',4000);
-- 3.修改表数据
-- 3.1 将所有员工薪水修改为5000元。
update employee set salary=5000;
-- 3.2 将姓名为'张三'的员工薪水修改为3000元。
update employee set salary=3000 where ename='张三';
-- 3.3 将姓名为'李四'的员工薪水修改为4000元，gender改为女。
update employee set salary=4000,gender='女' where ename='李四';
-- 3.4 将王五的薪水在原有基础上增加1000元。
update employee set salary=salary+1000 where ename='王五';
