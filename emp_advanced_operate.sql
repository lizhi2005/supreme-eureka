create database mydb3;
use mydb3;
-- 创建部门表
CREATE TABLE dept1(
    deptno INT PRIMARY KEY,  -- 部门编号
    dname VARCHAR(14),       -- 部门名称
    loc VARCHAR(13)          -- 部门地址
);


-- 创建员工表
CREATE TABLE emp1(
    empno INT PRIMARY KEY,   -- 员工编号
    ename VARCHAR(10),       -- 员工姓名
    job VARCHAR(9),          -- 员工工作
    mgr INT,                 -- 员工直属领导编号
    hiredate DATE,           -- 入职时间
    sal DOUBLE,              -- 工资
    comm DOUBLE,             -- 奖金
    deptno INT               -- 对应dept表的外键
);


-- 创建工资等级表
CREATE TABLE salgrade1(
    grade INT,    -- 等级
    losal DOUBLE, -- 最低工资
    hisal DOUBLE  -- 最高工资
);

INSERT INTO dept1 (deptno, dname, loc) VALUES
(10, '财务部', '辛国孝城'),
(20, '技术部', '庚国曜灵阁'),
(30, '销售部', '北漠'),
(40, '人事部', '褚国'),
(50, '行政部', '康国');


INSERT INTO emp1 (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
-- 财务部（10）
(7369, '沈棠', '会计', 7902, '2010-01-01', 5800, 500, 10),
(7499, '祈善', '出纳', 7698, '2012-03-15', 4500, 300, 10),
(7521, '即墨秋', '财务主管', 7839, '2008-07-20', 8900, 1200, 10),
-- 技术部（20）
(7566, '顾池', '开发工程师', 7839, '2014-05-08', 9500, 800, 20),
(7654, '林风', '测试工程师', 7566, '2018-11-23', 6200, 400, 20),
(7698, '褚曜', '技术经理', 7839, '2005-02-10', 12000, 1500, 20),
-- 销售部（30）
(7782, '寥嘉', '销售代表', 7698, '2009-09-05', 4800, 1000, 30),
(7788, '公西仇', '销售主管', 7839, '2011-06-30', 7500, 1800, 30),
(7839, '白素', '总经理', NULL, '2000-04-12', 18000, NULL, 30),
-- 人事部（40）
(7844, '宁燕', '人事专员', 7788, '2013-10-01', 5200, 200, 40),
(7876, '奕信', 'HRBP', 7839, '2004-08-17', 6800, 350, 40),
(7900, '姜胜', '招聘专员', 7788, '2015-12-05', 4600, 150, 40),
-- 行政部（50）
(7902, '拓跋烈', '行政主管', 7839, '2009-05-18', 7200, 600, 50),
(7934, '苏绾', '前台', 7902, '2017-12-08', 3800, 100, 50),
(7944, '楚烈', '后勤专员', 7902, '2008-03-22', 4200, 250, 50);

INSERT INTO salgrade1 (grade, losal, hisal) VALUES
(1, 3000, 4000),   -- 初级
(2, 4001, 6000),   -- 专员级
(3, 6001, 8000),   -- 主管助理级
(4, 8001, 12000),  -- 主管/经理级
(5, 12001, 20000); -- 高管级


-- 创建视图
create or replace
view view1_emp 
as
select ename,job from emp1;

-- 查看表和视图
show tables;
show full tables;

drop view view1_emp;



-- 1: 查询部门平均薪水最高的部门名称
SELECT d.dname 
FROM emp1 e
JOIN dept1 d ON e.deptno = d.deptno
GROUP BY d.dname
ORDER BY AVG(e.sal) DESC
LIMIT 1;
-- JOIN dept1 d ON e.deptno = d.deptno：关联员工表和部门表，通过部门编号匹配；
-- GROUP BY d.dname：按部门名称分组，用于计算每个部门的平均薪资；
-- ORDER BY AVG(e.sal) DESC：按平均薪资降序排序（最高的排第一）；
-- LIMIT 1：只取第一条结果（即平均薪资最高的部门）。

select *
from(
select *,rank() over (order by asal desc) rn
from
(select dname,avg(sal) asal from emp1 e join dept1 d on  d.deptno=e.deptno group by dname order by avg(sal))t
)tt
where rn<2;
-- 2: 查询员工比所属领导薪资高的部门名、员工名、员工领导编号
INSERT INTO emp1 (empno, ename, job, mgr, hiredate, sal, comm, deptno) 
VALUES (7999, '江离', '高级工程师', 7566, '2020-01-01', 10000, 600, 20);

select dname,e.ename,e.sal,e.mgr,e1.ename,e1.sal
from emp1 e
join dept1 d on e.deptno=d.deptno
join emp1 e1 on e1.empno=e.mgr
where e.sal>e1.sal;

 
--  3:查询工资等级为4级，2000年以后入职的工作地点为北京的员工编号、姓名和工资，并查询出薪资前三名的员工信息.
SELECT *
FROM emp1
WHERE EXISTS (
  SELECT 1
  FROM salgrade1
  WHERE grade = 4
    AND emp1.sal BETWEEN losal AND hisal
);
-- 错误写法
-- select *
-- from emp1
-- where sal in(sal between losal and hisal
-- from salgrade1  where grade=4);
-- 查询工资等级为4级，2000年以后入职的工作地点为北京的员工编号、姓名和工资，并查询出薪资前三名的员工信息.
select empno,ename,sal
from
(SELECT  e.*,rank() over(partition by d.dname order by e.sal desc) rn
FROM emp1 e
JOIN salgrade1 s ON e.sal BETWEEN s.losal AND s.hisal
join  dept1  d on d.deptno=e.deptno
WHERE s.grade = 4 and e.hiredate>='2000-1-1' and  d.loc='庚国曜灵阁')t
where rn<4;


use mydb3;
delimiter $$
create procedure proc01()
begin
  select empno,ename from emp1;
end $$
delimiter ;
call proc01(); 

delimiter $$
create procedure proc02()
begin
  set @var_anme='张三';
  select @var_anme;
end $$
delimiter ;
call proc02(); 



delimiter $$
create procedure proc03( in empno int ,out out_ename varchar(10))
begin
  select ename into out_ename from emp1 where emp1.empno=empno;
end $$
delimiter ;
call proc03(7369,@out_ename); 
select @out_ename;

delimiter $$
create procedure proc04( in empno int ,out out_ename varchar(10),out out_sal decimal(7,2))
begin
  select ename,sal into out_ename,out_sal from emp1 where emp1.empno=empno;
end $$
delimiter ;
call proc04(7369,@out_ename,@out_sal); 
select @out_ename,@out_sal;


delimiter $$
create procedure proc5(inout inout_ename varchar(50),inout inout_sal int)
begin
  select  concat(deptno,"_",inout_ename) into inout_ename from emp1
where ename=inout_ename;
  set inout_sal=inout_sal *12;
end $$
delimiter ;
set @inout_ename='沈棠';
set @inout_sal=5000;
call proc5(@inout_ename,@inout_sal);
select @inout_ename;
select @inout_sal;

delimiter $$
create procedure proc6(in score int)
begin
  if score<60 and score>=0
    then 
      select '不及格';
  elseif score>=60 and score<80
    then select '及格';
  elseif score>=80 and score<90
    then select '良好';
  elseif score>=90 and score<=100
    then select '优秀';
  else
    select'输入错误';
  end if;
end $$
delimiter ;
call proc6(rand()+90);
call proc6(rand()*10000);

delimiter $$
create procedure proc7(in pay_type int)
begin 
  case pay_type 
    when 1 then select '微信支付';
    when 2 then select '支付宝支付';
    when 3 then select '银行卡支付';
    when 4 then select '翼支付支付';
    else select '其他支付';
    end case;
end $$
delimiter $$
call proc7(2);

delimiter $$
create procedure proc8(in score int)
begin
  case
    when score<60 and score>=0
      then 
        select '不及格';
    when score>=60 and score<80
      then 
        select '及格';
    when score>=80 and score<90
      then 
        select '良好';
    when score>=90 and score<=100
      then 
        select '优秀';
    else
        select '输入错误';
    end case;
end $$
delimiter ;
call proc8(rand()+90);
call proc8(rand()*10000);

use mydb3;
create table mydb3.user(
uid int,
username varchar(20),
password varchar(20)
);



delimiter $$
create procedure proc9(in countnum int)
begin
 declare i int default 1;
 label:while i<countnum do
    insert into user(uid,username,password)values(i,concat('user',i),'123456while');
    if i=5
      then leave label;
    end if;
    set i=i+1;
 end while label;
 select '循环结束 ';   
end $$
delimiter ;

call proc9(10);
truncate table user;


delimiter $$
create procedure proc10(in count int)
begin
  declare  i  int default 0;
  repeat
    insert into user(uid,username,password) values(i,concat('user',i),'123456repeat');
    set i=i+1;
    until i>count
    end repeat ;
    select '循环结束 ';
end $$
  
call proc10(10);


delimiter $$
create procedure proc11(in count int)
BEGIN
  declare i int default 1;
  label:loop
    insert into user(uid,username,password) values(i,concat('user',i),'123456loop');
    set i=i+1;
    if i>count
     then leave label;
   end if;
  end loop label;
  select 'over';
END $$
delimiter ;
call proc11(10);

use mydb3;
-- 输入一个部门名称，查询该部门的员工的编号名字和薪资将查询结果添加游标
delimiter $$
create procedure proc12(in in_name varchar(20))
begin
-- 定义局部变量
declare var_empno int;
declare var_ename varchar(20);
declare var_sal decimal(7,2);
-- 定义标记值
declare flag int default 1;
-- 声明游标
declare my_cursor cursor for
 select empno,ename,sal 
  from dept1 a,emp1 b
  where a.deptno=b.deptno and a.dname=in_name;
-- 定义句柄
declare continue handler for 1329 set flag=0;
-- 打开游标
open my_cursor;
-- 通过游标获取值
label:loop 
  fetch my_cursor into var_empno,var_ename,var_sal;
--   判断flag，如果唯1，则执行，否则不执行
  if flag=1 then 
    select var_empno,var_ename,var_sal;
  else leave label;
  end if;
  end loop label;
--   关闭游标
close my_cursor;
end $$
delimiter ;
call proc12('技术部');

use mydb3;
-- 创建一个数据库
-- create database mydb4;
set global log_bin_trust_function_creators=TRUE;
delimiter $$
create function proc13(in_empno int) returns varchar(50)
 begin 
 declare out_ename varchar(50);
 select ename  into out_ename from emp1 where empno=in_empno;
 return out_ename;
  end $$
 delimiter ;


-- 创建触发器
create table mydb3.user(
uid int primary key,
username varchar(20)  not null,
password varchar(20) not null
);
create table mydb3.user_logs(
id int primary key auto_increment,
time timestamp,
log_text varchar(20)
);


delimiter $$
 create trigger trigger_test before insert 
 on user for each row 
 begin
 insert into user_logs values(NULL,NOW(),"有用户信息插入");
end $$
delimiter ;

insert into user values(1,"沈棠","123456");


drop trigger if exists trigger_test2;

delimiter $$
 create trigger trigger_test1 before insert 
 on user for each row 
 begin
 insert into user_logs values(NULL,NOW(),concat("有用户信息插入",NEW.uid,NEW.username,NEW.password));
end $$
delimiter ;


insert into user values(4,"褚无晦","123456");

-- drop trigger if exists trigger_test1;
delimiter $$
 create trigger trigger_test2 before update
 on user for each row 
 begin
insert into user_logs values(NULL,NOW(),concat("有用户信息修改",NEW.uid,NEW.username,NEW.password));
end $$
delimiter ;
update user set username="林风" where uid=1;

truncate table user_logs;


 show triggers;

