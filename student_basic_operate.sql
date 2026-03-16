-- Ctrl +  /   和c的注释差不多 要加分号！！！  1. 实现注释DDL操作之数据库操作
-- show databases;
-- 创建数据库
create database if not exists mydb1;
-- 切换（选择要操作的）数据库

-- 删除数据库
-- drop database if exists mydb1;
-- 修改数据库编码
-- alter database mydb1 character set utf8;
-- 创建表
use  mydb1;
create table if not exists student(
sid int,
sname varchar(20),
gender varchar(20),
age int,
brith date,
address varchar(20)
);
-- 查看当前数据库所有的表
show  tables;
-- 查看指定表的创建语句
show create table student;
-- 查看表结构
desc student;
-- 删除表
drop table student;
-- 修改表添加列
alter table student add score double;
alter table student add dept varchar(20);
-- 修改一列
alter table student change dept department varchar(30);
-- 删除一列
alter table student drop department;
-- 修改表名字
rename table xuesheng to student;


-- DML操作    即数据操作语言
-- 数据的插入
INSERT INTO student (sid, sname, gender, age, brith, address, score) VALUES
(10001, '沈棠', '女', 13, '2001-01-01', '辛国孝城', 99),
(10002, '祈善', '男', 17, '1997-03-15', '辛国四宝郡', 95),
(10003, '即墨秋', '男', 22, '1992-07-20', '北漠', 97),
(10004, '顾池', '男', 20, '1994-05-08', '庚国曜灵阁', 92),
(10005, '林风', '女', 15, '1999-11-23', '辛国林家村', 88),
(10006, '褚曜', '男', 25, '1989-02-10', '褚国', 96),
(10007, '寥嘉', '男', 24, '1990-09-05', '康国', 90),
(10008, '公西仇', '男', 23, '1991-06-30', '戚国', 94),
(10009, '白素', '女', 18, '1996-04-12', '幽国', 86),
(10010, '宁燕', '女', 21, '1993-10-01', '康国', 91),
(10011, '奕信', '男', 30, '1984-08-17', '曲国', 89),
(10012, '姜胜', '女', 19, '1995-12-05', '辛国', 87),
(10013, '拓跋烈','男', 35, '1979-05-18', '北漠',90),
(10014, '苏绾','女', 27, '1987-12-08', '辛国',81),
(10015, '楚烈','男', 32, '1982-03-22', '褚国',82),
(10016, '温庭','男', 45, '1970-06-15', '康国',79),
(10017, '叶三娘','女', 38, '1976-08-09', '戚国',78),
(10018, '萧远','男', 29, '1985-01-27', '曲国',80),
(10019, '阮氏','女', 42, '1972-10-14', '辛国',77),
(10020, '孟和','男', 21, '1993-02-21', '北漠',76),
(10021, '林伯','男', 55, '1959-11-05', '辛国',75),
(10022, '唐妩','女', 23, '1991-07-03', '康国',74),
(10023, '韩章','男', 40, '1984-04-11', '庚国',73),
(10024, '花姨','女', 36, '1988-09-24', '幽国',94),
(10025, '卫峥','男', 22, '1992-08-16', '褚国',91),
(10026, '秦越','男', 31, '1983-11-01', '戚国',89),
(10027, '顾嬷嬷','女', 48, '1966-06-09', '康国',87),
(10028, '褚杰','男', 28, '1986-04-05', '褚国',85),
(10029, '魏寿','男', 40, '1974-05-12', '辛国',83),
(10030, '秦礼','男', 33, '1981-09-10', '辛国',82),
(10031, '徐解','男', 36, '1978-02-28', '辛国',81),
(10032, '崔孝', '男', 42, '1972-07-15', '辛国',80);

-- 删除数据 delete可加where来限定条件
delete from  student where sid=1001;
-- delete也可以删除整个表的内容
delete from student;
-- truncate 删除整个表的内容，连表格一起删除，重新创建一个表格 
truncate student;


-- 查询所有人
select sid, sname, gender, age, brith, address, score from student;
-- 查询人名和分数
select  sname, score from student;
-- 表起别名
select*  from student as s;
-- 列起别名
select sname as '姓名',address  '地址' from student;
-- 去掉重复的值
select distinct address from student;
-- 查询结果是表达式
select sid+10 from student;

-- 查询人名为沈棠的人的所有信息
select * from student where sname='沈棠' ;
-- 查询分数为97的人
select * from student where score=97 ;
-- 查询分数不是80的所有人
select * from student where score<>80 ;
-- 查询分数大于70的所有人的信息
select * from student where score>70 ;
-- 查询分数在80到90之间的所有人
select * from student where score>=80 AND score<=90 ;
-- 查询含有‘秦’的所有人
select * from student where sname like '%秦%';

-- 查询以‘秦’开头的所有人
select * from student where sname like '秦%';

-- 查询第二个字是风的人
select * from student where sname like'_风%';

-- 查询sid为null的人
-- select * from student where sid=NULL;错误写法
-- 在 SQL 中，NULL 代表 “未知值”，它不等于任何值，也不等于它本身，所以：
-- sid = NULL
-- 这是错误写法，永远返回 UNKNOWN（逻辑上等价于 FALSE），查不到任何数据。
-- 原因：NULL 不是一个具体值，用等号 = 去比较时，数据库无法判定 “未知是否等于未知”，所以结果永远不成立。

select * from student where sid is NULL;

-- 查询sid为null的人
select * from student where sid is not NULL;



-- 查询总人数
select count(sid) from student;
select count(*) from student;
-- 查询分数大于90的人的总数
select count(score) from student where score>=90;
-- 查询女生有多少人
select count(*) from student where gender='女';
-- 查询分数的总和
select sum(score) from student where gender='女';
select sum(score) from student where gender='男';
select sum(score) from student;


-- 查询分数的最高分
select max(score) from student;
-- 查询分数的最低分
select min(score) from student;
-- 查询女生的平均成绩
select avg(score) from student where gender='女';
select avg(score) from student where gender='男';
select avg(score) from student;
-- 统计各个性别的个数
SELECT gender AS 性别, COUNT(*) AS 人数 FROM student3 GROUP BY gender;

-- 使用least求最小值
select least(10,5,25);

-- 使用greatest求最大值
select greatest(10,5,25);

-- 使用成绩升序（降序）
select * from student order by score desc;
-- 在分数排序（降序）的基础上，以学号排序（降序）
select * from student order by score desc,sid desc;
-- 显示分数去重并排序（降序）
select distinct score from student order by score desc;

select * from student limit 0,8;
select * from student limit 8,8;
select * from student limit 16,8;
select * from student limit 24,8;

-- select * from student limit 0,60;
-- select * from student limit 0,60;
-- select * from student limit 0,60;
-- 位运算符

-- 位与
select 3&5;
-- 位或
select 3|5;
-- 位异或
select 3^5;
-- 位左移
select 3<<5;
-- 位右移
select 3>>5;
-- 位取反
select ~3;

drop table student1;
create table mydb1.student1(
sname varchar(20),
score double
);
insert into student1(sname,score) select sname,score from student;
select * from student1;

create table mydb1.student2(
gender varchar(20),
pnum int
);

insert into student2(gender,pnum) select gender,count(*) from student group by gender;
 
create table if not exists student3(
sid int,
sname varchar(20),
gender varchar(20),
age int,
brith date,
address varchar(20),
chinese double,
math double,
english double
);
INSERT INTO student3 (sid, sname, gender, age, brith, address, chinese, math, english) VALUES
(10001, '沈棠', '女', 13, '2001-01-01', '辛国孝城', 99, 100, 98),
(10002, '祈善', '男', 17, '1997-03-15', '辛国四宝郡', 95, 96, 94),
(10003, '即墨秋', '男', 22, '1992-07-20', '北漠', 97, 98, 96),
(10004, '顾池', '男', 20, '1994-05-08', '庚国曜灵阁', 92, 93, 91),
(10005, '林风', '女', 15, '1999-11-23', '辛国林家村', 88, 89, 87),
(10006, '褚曜', '男', 25, '1989-02-10', '褚国', 96, 97, 95),
(10007, '寥嘉', '男', 24, '1990-09-05', '康国', 90, 91, 89),
(10008, '公西仇', '男', 23, '1991-06-30', '戚国', 94, 95, 93),
(10009, '白素', '女', 18, '1996-04-12', '幽国', 86, 87, 85),
(10010, '宁燕', '女', 21, '1993-10-01', '康国', 91, 92, 90),
(10011, '奕信', '男', 30, '1984-08-17', '曲国', 89, 90, 88),
(10012, '姜胜', '女', 19, '1995-12-05', '辛国', 87, 88, 86),
(10013, '拓跋烈', '男', 35, '1979-05-18', '北漠', 90, 91, 89),
(10014, '苏绾', '女', 27, '1987-12-08', '辛国', 81, 82, 80),
(10015, '楚烈', '男', 32, '1982-03-22', '褚国', 82, 83, 81),
(10016, '温庭', '男', 45, '1970-06-15', '康国', 79, 80, 78),
(10017, '叶三娘', '女', 38, '1976-08-09', '戚国', 78, 79, 77),
(10018, '萧远', '男', 29, '1985-01-27', '曲国', 80, 81, 79),
(10019, '阮氏', '女', 42, '1972-10-14', '辛国', 77, 78, 76),
(10020, '孟和', '男', 21, '1993-02-21', '北漠', 76, 77, 75),
(10021, '林伯', '男', 55, '1959-11-05', '辛国', 75, 76, 74),
(10022, '唐妩', '女', 23, '1991-07-03', '康国', 74, 75, 73),
(10023, '韩章', '男', 40, '1984-04-11', '庚国', 73, 74, 72),
(10024, '花姨', '女', 36, '1988-09-24', '幽国', 94, 95, 93),
(10025, '卫峥', '男', 22, '1992-08-16', '褚国', 91, 92, 90),
(10026, '秦越', '男', 31, '1983-11-01', '戚国', 89, 90, 88),
(10027, '顾嬷嬷', '女', 48, '1966-06-09', '康国', 87, 88, 86),
(10028, '褚杰', '男', 28, '1986-04-05', '褚国', 85, 86, 84),
(10029, '魏寿', '男', 40, '1974-05-12', '辛国', 83, 84, 82),
(10030, '秦礼', '男', 33, '1981-09-10', '辛国', 82, 83, 81),
(10031, '徐解', '男', 36, '1978-02-28', '辛国', 81, 82, 80),
(10032, '崔孝', '男', 42, '1972-07-15', '辛国', 80, 81, 79);

INSERT INTO student3 (sid, sname, gender, age, brith, address, chinese, math, english) VALUES
(10033, '李玲玉', '女', 20, '2005-09-14', '康国', 99, 100, 98);
INSERT INTO student3 (sid, sname, gender, age, brith, address, chinese, math, english) VALUES
(10033, '陈少川', '女', 20, '2004-01-01', '康国', 80, 80, 80);



INSERT INTO student3 (sid, sname, gender, age, brith, address, chinese, math, english) VALUES
(10034, '李明宇', '男', 21, '2004-03-12', '辛国', 92, 88, 90);
INSERT INTO student3 (sid, sname, gender, age, brith, address, chinese, math, english) VALUES
(10035, '李若溪', '女', 19, '2005-07-25', '北漠', 89, 95, 91);
INSERT INTO student3 (sid, sname, gender, age, brith, address, chinese, math, english) VALUES
(10036, '李浩然', '男', 22, '2003-11-08', '褚国', 85, 87, 86);
INSERT INTO student3 (sid, sname, gender, age, brith, address, chinese, math, english) VALUES
(10037, '李舒雅', '女', 20, '2004-08-19', '康国', 94, 92, 93);
INSERT INTO student3 (sid, sname, gender, age, brith, address, chinese, math, english) VALUES
(10038, '李泽轩', '男', 23, '2002-05-30', '庚国', 81, 83, 82);

-- 查询表中所有学生的信息。
select * from student3;
-- 查询表中所有学生的姓名和对应的英语成绩。
select sname,english from student3;
-- 过滤表中重复数据。
select distinct english from student3;
-- 统计每个学生的总分。
select sname, chinese+math+english as 总分 from student3;
-- 在所有学生总分数上加10分特长分。
select sname, (chinese+math+english)+10  from student3;
-- 使用别名表示学生分数。
select sname, chinese as 语文, math as 数学, english as 英语, chinese+math+english as 总分 from student3;
-- 查询英语成绩大于90分的同学
select * from student3 where english>90;

-- 查询总分大于200分的所有同学
-- select sname from student3 group by sname having sum(chinese,math,english)>200;
select sname, chinese+math+english as 总分 from student3 where (chinese+math+english)>200;
-- 查询英语分数在 80—90之间的同学。
select * from student3 where english>80 and english<90;
-- 上面的不包含80和90
select * from student3 where english between 80 and 90;
-- 查询英语分数不在 80—90之间的同学。
select * from student3 where english not between 80 and 90;

-- 查询数学分数为89,90,91的同学。
select * from student3 where math=89 or math=90 or math=91;
-- 查询所有姓李的学生英语成绩。
select sname,english from student3 where sname like '李%';
-- 查询数学分80并且语文分80的同学。
select * from student3 where math=80 and chinese=80;
-- 查询英语80或者总分200的同学
select * from student3 where english=80 or (chinese+math+english)>200;
-- 对数学成绩降序排序后输出。
select math from student3 order by math desc;
-- 对总分排序后输出，然后再按从高到低的顺序输出
select (chinese+math+english) as '总分' from student3 order by (chinese+math+english) desc;
-- 对姓李的学生成绩排序输出
select * from student3 where sname like '李%' order by  (chinese+math+english) desc;
-- 查询男生和女生分别有多少人，并将人数降序排序输出
select gender,count(sname) from student3 group by gender;




use mybd2;
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
use mybd2;
-- 1返回拥有员工的部门名、部门号。
select DISTINCT d.dname,d.deptno
from dept1 d
join emp1 e on d.deptno=e.deptno;

-- 2工资水平多于沈棠的员工信息。
select * from emp1 
where sal>(
select sal
from emp1
where ename='沈棠'
) order by sal desc;
select sal from emp1 where ename='沈棠';
-- 3返回员工和所属经理的姓名。
select e1.ename as 员工姓名, e2.ename as 经理姓名
from emp1 e1 left outer join emp1 e2 on e2.empno=e1.mgr;

select * from emp1 e1 left outer join emp1 e2 on e2.empno=e1.mgr;
-- 4返回雇员的雇佣日期早于其经理雇佣日期的员工及其经理姓名。早于是时间小
select e.ename as '员工',e1.ename as '经理' 
from emp1 e join emp1 e1 on e1.empno=e.mgr 
where   e.hiredate < e1.hiredate
-- 5返回员工姓名及其所在的部门名称。
select e.ename,d.dname
from emp1 e,dept1 d
where e.deptno=d.deptno;
-- emp e left outer join dept1 d on e.deptno=d.deptno
-- union emp e right outer join dept1 d on e.deptno=d.deptno;
-- 6返回公西仇的经理姓名。
select e1.ename
from emp1 e left outer join emp1 e1 on e1.empno=e.mgr
where e.ename='公西仇';
-- 7返回部门号及其本部门的最低工资。
select deptno,min(sal)
from emp1
group by deptno
order by min(sal) desc;
-- select d.deptno,e.sal
-- from emp1 e left outer join dept1 d on e.deptno=d.deptno
-- where ()
-- 8返回销售部所有员工的姓名。
select e.ename
from emp1 e,dept1 d
where d.dname='销售部' and e.deptno=d.deptno;
-- 9返回工资水平多于平均工资的员工。
select e.ename,e.sal
from emp1 e 
where e.sal>
(
select avg(sal)
from emp1 e
);
select e.ename, e.sal, (select avg(sal) from emp1) as 平均工资
from emp1 e
where e.sal > (select avg(sal) from emp1);

-- select e.ename,e.sal,avg(sal)
-- from emp1 e 
-- where e.sal>avg(sal);
-- 10返回与顾池从事相同工作的员工。
select * 
from emp1
where job=
(select job
from emp1
where ename='顾池'
)and ename != '顾池'; 
-- 11返回工资高于 30 部门所有员工工资水平的员工信息。
select *
from emp1
where sal>all(select sal from emp1 where deptno=30);
-- 12返回员工工作及其从事此工作的最低工资。
use mybd2;
select job,min(sal)
from emp1  
group by job
order by min(sal) desc;
-- 13计算出员工的年薪，并且以年薪排序。
select *,(sal*12+IFNULL(comm, 0))
from emp1
order by (sal*12+IFNULL(comm, 0)) desc;
-- 14返回工资处于第四级别的员工的姓名。
use mybd2;
-- 14返回工资处于第四级别的员工的姓名。
SELECT e.ename
FROM emp1 e
JOIN salgrade1 s ON e.sal BETWEEN s.losal AND s.hisal  -- 关联员工工资和工资等级区间
WHERE s.grade = 4;  -- 筛选第四等级

-- 15返回工资为二等级的职员名字、部门所在地。
select ename,loc
from emp1 e,dept1 d,salgrade1 s
where e.deptno=d.deptno and s.grade=2 and e.sal BETWEEN s.losal AND s.hisal ; 






