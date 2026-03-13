-- 员工/部门/工资等级表相关 DDL + DML
-- 数据库：mybd2
-- 功能：包含部门/员工/工资等级表创建、数据插入、15道查询题解答

-- ==================== 数据库操作 ====================
create database if not exists mybd2;
use mybd2;

-- ==================== 部门表创建 ====================
CREATE TABLE dept1(
    deptno INT PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(13)
);
-- ... 后续粘贴所有员工/部门表相关 SQL ...

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

CREATE TABLE mydb1.emp(
    empno    INT,        -- 员工编号
    ename    VARCHAR(50),-- 员工名字
    job      VARCHAR(50),-- 工作名字
    mgr      INT,        -- 上级领导编号
    hiredate DATE,       -- 入职日期
    sal      INT,        -- 薪资
    comm     INT,        -- 奖金
    deptno   INT         -- 部门编号
);
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
(7369, '沈棠', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, '祈善', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, '即墨秋', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7566, '顾池', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7654, '林风', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7698, '褚曜', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, '寥嘉', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, '公西仇', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7839, '白素', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7844, '宁燕', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7876, '奕信', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
(7900, '姜胜', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7902, '拓跋烈', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7934, '苏绾', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);
-- 1、按员工编号升序排列不在 10 号部门工作的员工信息
select * from emp where deptno !=10  order by empno; 
-- 2、查询姓名第二个字母不是 "A" 且薪水大于1000元的员工信息，按年薪降序排列
select * FROM emp WHERE ename NOT like '_A%' AND sal > 1000 ORDER BY  (sal + IFNULL(comm, 0)) * 12 DESC,empno ASC;
    -- 姓名第二个字母不是"A"：_ 匹配单个字符，% 匹配任意字符  LIKE   
    -- 薪水大于1000元
    
-- 按年薪降序排列（年薪相同则按员工编号升序）
select * FROM emp  ORDER BY  (sal + IFNULL(comm, 0)) * 12 DESC,empno ASC;   
-- 3、求每个部门的平均薪水
select deptno,avg(sal) from emp group by deptno;
-- 4、求各个部门的最高薪水
select deptno,max(sal) from emp group by deptno;
-- 5、求每个部门每个岗位的最高薪水
select deptno,job,max(sal) from emp group by deptno,job;

-- 6、求平均薪水大于2000的部门编号
select deptno,avg(sal) avg_sal from emp group by deptno having avg_sal > 2000;
-- 7、将部门平均薪水大于1500的部门编号列出来，按部门平均薪水降序排列
select deptno,avg(sal) avg_sal from emp group by deptno having avg_sal > 1500 order by avg_sal desc;
-- 8、选择公司中有奖金的员工姓名，工资
select ename,sal from emp where comm is not null;
-- 9、查询员工最高工资
select max(sal) from emp ;
-- 10、查询员工最高工资和最低工资的差距
select max(sal)-min(sal) from emp;




create database mybd2;


create table mybd2.dept(
deptno varchar(20) primary key,
name varchar(20)
);

create table if not exists mybd2.emp(
eid varchar(20),
ename varchar(20),
age int,
dept_id varchar(20),
constraint emp_fk foreign key (dept_id) references dept(deptno)
);




drop table mybd2.dept;
drop table mybd2.emp;

create table if not exists mybd2.student(
sid int primary key auto_increment,
name varchar(20),
age int,
gender varchar(20)
);

create table if not exists mybd2.course(
cid int primary key auto_increment,
cidname varchar(20)
);
create table if not exists mybd2.score(
sid int ,
cid int,
score double
);
alter table mybd2.score add foreign key(sid)  references student(sid);
alter table mybd2.score add foreign key(cid)  references course(cid);

INSERT INTO mybd2.student (sid, name, age, gender) VALUES
(10001, '沈棠', 13, '女'),
(10002, '祈善', 17, '男'),
(10003, '即墨秋', 22, '男'),
(10004, '顾池', 20, '男'),
(10005, '林风', 15, '女'),
(10006, '褚曜', 25, '男'),
(10007, '寥嘉', 24, '男'),
(10008, '公西仇', 23, '男'),
(10009, '白素', 18, '女'),
(10010, '宁燕', 21, '女'),
(10011, '奕信', 30, '男'),
(10012, '姜胜', 19, '女'),
(10013, '拓跋烈', 35, '男'),
(10014, '苏绾', 27, '女'),
(10015, '楚烈', 32, '男'),
(10016, '温庭', 45, '男'),
(10017, '叶三娘', 38, '女'),
(10018, '萧远', 29, '男'),
(10019, '阮氏', 42, '女'),
(10020, '孟和', 21, '男'),
(10021, '林伯', 55, '男'),
(10022, '唐妩', 23, '女'),
(10023, '韩章', 40, '男'),
(10024, '花姨', 36, '女'),
(10025, '卫峥', 22, '男'),
(10026, '秦越', 31, '男'),
(10027, '顾嬷嬷', 48, '女'),
(10028, '褚杰', 28, '男'),
(10029, '魏寿', 40, '男'),
(10030, '秦礼', 33, '男'),
(10031, '徐解', 36, '男'),
(10032, '崔孝', 42, '男');

INSERT INTO mybd2.course (cidname) VALUES
('语文'),
('数学'),
('英语'),
('物理'),
('化学'),
('历史'),
('地理'),
('生物');

INSERT INTO mybd2.score (sid, cid, score) VALUES
-- 每个学生随机分配3门课程的分数（复用原score字段值）
(10001, 1, 99), (10001, 2, 98), (10001, 3, 97),
(10002, 1, 95), (10002, 2, 94), (10002, 4, 93),
(10003, 1, 97), (10003, 5, 96), (10003, 6, 95),
(10004, 2, 92), (10004, 4, 91), (10004, 7, 90),
(10005, 1, 88), (10005, 3, 87), (10005, 8, 86),
(10006, 2, 96), (10006, 5, 95), (10006, 6, 94),
(10007, 1, 90), (10007, 4, 89), (10007, 7, 88),
(10008, 3, 94), (10008, 5, 93), (10008, 8, 92),
(10009, 1, 86), (10009, 2, 85), (10009, 6, 84),
(10010, 2, 91), (10010, 4, 90), (10010, 7, 89),
(10011, 1, 89), (10011, 3, 88), (10011, 5, 87),
(10012, 2, 87), (10012, 6, 86), (10012, 8, 85),
(10013, 4, 90), (10013, 7, 89), (10013, 5, 88),
(10014, 1, 81), (10014, 3, 80), (10014, 6, 79),
(10015, 2, 82), (10015, 4, 81), (10015, 8, 80);
use  mybd2;
-- 基础题（笛卡尔积 / 简单筛选）
-- 查询所有学生与所有课程的组合（显示：学生姓名、性别、课程名称）
select * from student,course;
-- 查询年龄小于 20 岁的女学生，与所有理科课程（数学、物理、化学）的组合（显示：姓名、年龄、课程名称）
select * from student where gender='女' and age<20 inner course on cidname='物理',cidname='化学',cidname='生物';
select * from student s,course c where s.gender='女' and s.age<20 and c.cidname IN ('数学', '物理', '化学');
-- 查询 “北漠” 相关学生（姓名含 “拓跋烈 / 即墨秋 / 孟和”）与文科课程（语文、历史、地理）的组合（显示：姓名、课程名称）
-- 进阶题（聚合 / 分组 / 条件计算）
-- 统计男生、女生分别对应多少门课程（显示：性别、课程总数）
-- 按学生年龄分组（10-20 岁、21-30 岁、31 岁以上），统计每个年龄段对应的课程数量（显示：年龄分组、课程总数）
-- 查询姓名含 “褚” 字的学生，与 “生物 / 英语” 课程的组合，按学生年龄升序排列（显示：姓名、年龄、课程名称）
-- 综合题（复杂筛选 / 排序 / 去重）
-- 查询年龄大于 30 岁的学生，排除 “康国” 相关学生（姓名含 “寥嘉 / 宁燕 / 唐妩 / 温庭”），与除 “数学” 外所有课程的组合（显示：姓名、年龄、课程名称）
-- 统计每类课程（文科 / 理科）对应的学生人数：
-- 文科：语文、历史、地理；理科：数学、物理、化学、生物、英语
-- 显示：课程类别（文科 / 理科）、对应学生总数
-- 查询所有 “辛国” 相关学生（姓名含 “沈棠 / 祈善 / 林风 / 姜胜 / 苏绾 / 阮氏 / 林伯 / 魏寿 / 秦礼 / 徐解 / 崔孝”），与 “语文 / 数学” 课程的组合，按课程名称升序、学生年龄降序排列（显示：姓名、年龄、课程名称）



-- 查询每门课程的选修学生
-- 查询 “语文” 课程的选修学生
-- 查询 “语文” 和 “数学” 两门课程的选修学生
-- 查询每门课程的选修人数，并按人数升序排序
-- 查询选修人数≥3 的课程，并按人数降序排序
-- 拓展变式题（可选练）
-- 若想增加难度，可补充这些同逻辑变式题：6. 查询没有学生选修的课程名称7. 查询选修了 3 门及以上课程的学生姓名8. 查询 “数学” 课程分数最高的学生姓名和分数9. 查询年龄小于 20 岁的学生选修的所有课程名称10. 查询每门课程的平均分，并筛选出平均分≥85 的课程
-- 

USE mybd2;
-- 创建部门表（dept）：部门号(deptno)为主键，部门名称(dname)
CREATE TABLE IF NOT EXISTS mybd2.dept (
    deptno INT PRIMARY KEY AUTO_INCREMENT,  -- 部门号（主键，自增）
    dname VARCHAR(20)                       -- 部门名称
);

-- 创建员工表（emp）：员工号(empno)为主键，关联部门号(deptno)
CREATE TABLE IF NOT EXISTS mybd2.emp (
    empno INT PRIMARY KEY AUTO_INCREMENT,   -- 员工号（主键，自增）
    ename VARCHAR(20),                      -- 员工姓名
    age INT,                                -- 年龄
    gender VARCHAR(20),                     -- 性别
    deptno INT,                             -- 部门号（关联dept表的deptno）
    FOREIGN KEY (deptno) REFERENCES mybd2.dept(deptno)  -- 外键关联部门表
);



INSERT INTO mybd2.dept (dname) VALUES
('研发部'),
('销售部'),
('财务部'),
('人事部'),
('行政部'),
('市场部');

INSERT INTO mybd2.emp (empno, ename, age, gender, deptno) VALUES
(10001, '沈棠', 13, '女', 1),
(10002, '祈善', 17, '男', 2),
(10003, '即墨秋', 22, '男', 1),
(10004, '顾池', 20, '男', 3),
(10005, '林风', 15, '女', 2),
(10006, '褚曜', 25, '男', 4),
(10007, '寥嘉', 24, '男', 1),
(10008, '公西仇', 23, '男', 5),
(10009, '白素', 18, '女', 6),
(10010, '宁燕', 21, '女', 2),
(10011, '奕信', 30, '男', 3),
(10012, '姜胜', 19, '女', 1),
(10013, '拓跋烈', 35, '男', 4),
(10014, '苏绾', 27, '女', 5),
(10015, '楚烈', 32, '男', 6),
(10016, '温庭', 45, '男', 2),
(10017, '叶三娘', 38, '女', 1),
(10018, '萧远', 29, '男', 3),
(10019, '阮氏', 42, '女', 4),
(10020, '孟和', 21, '男', 5),
(10021, '林伯', 55, '男', 6),
(10022, '唐妩', 23, '女', 1),
(10023, '韩章', 40, '男', 2),
(10024, '花姨', 36, '女', 3),
(10025, '卫峥', 22, '男', 4),
(10026, '秦越', 31, '男', 5),
(10027, '顾嬷嬷', 48, '女', 6),
(10028, '褚杰', 28, '男', 1),
(10029, '魏寿', 40, '男', 2),
(10030, '秦礼', 33, '男', 3),
(10031, '徐解', 36, '男', 4),
(10032, '崔孝', 42, '男', 5);

-- 查询每个部门的所属员工
select * from dept d,emp  e where d.deptno=e.deptno;
-- 查询研发部门的所属员工
select * from dept d,emp  e where d.deptno=e.deptno and d.deptno=1 ;
select * from dept d inner join emp  e on d.deptno=e.deptno where  e.deptno =1;

-- 查询研发部和销售部的所属员工
SELECT e.empno, e.ename, e.age, e.gender from emp e inner join dept d on d.deptno=e.deptno where  e.deptno in(1,2);
SELECT * from emp e inner join dept d on d.deptno=e.deptno where  e.deptno in(1,2);
-- 查询每个部门的员工数，并升序排序
select e.deptno,count(e.ename) from dept d inner join emp e on d.deptno=e.deptno group by deptno order by  count(e.ename) asc;
-- 查询人数大于等于 3 的部门，并按照人数降序排序
select e.deptno,count(e.ename) from dept d inner join emp e on d.deptno=e.deptno   group by deptno having count(e.ename)>3 order by  count(e.ename) desc;



USE mybd2;

-- 1. 临时禁用外键约束
SET FOREIGN_KEY_CHECKS = 0;

-- 2. 清空员工表
TRUNCATE TABLE emp;

-- 3. 清空部门表
TRUNCATE TABLE dept;


-- 插入部门（新增一个无员工的部门：后勤部）
INSERT INTO mybd2.dept (dname) VALUES
('研发部'),
('销售部'),
('财务部'),
('人事部'),
('行政部'),
('市场部'),
('后勤部'); -- 这个部门没有员工

-- 插入员工（新增2个无部门的员工，同时让部分部门有员工）
INSERT INTO mybd2.emp (empno, ename, age, gender, deptno) VALUES
(10001, '沈棠', 13, '女', 1),
(10002, '祈善', 17, '男', 2),
(10003, '即墨秋', 22, '男', 1),
(10004, '顾池', 20, '男', 3),
(10005, '林风', 15, '女', 2),
(10006, '褚曜', 25, '男', 4),
(10007, '寥嘉', 24, '男', 1),
(10008, '公西仇', 23, '男', 5),
(10009, '白素', 18, '女', 6),
(10010, '宁燕', 21, '女', 2),
(10011, '奕信', 30, '男', 3),
(10012, '姜胜', 19, '女', 1),
(10013, '拓跋烈', 35, '男', 4),
(10014, '苏绾', 27, '女', 5),
(10015, '楚烈', 32, '男', 6),
(10016, '温庭', 45, '男', 2),
(10017, '叶三娘', 38, '女', 1),
(10018, '萧远', 29, '男', 3),
(10019, '阮氏', 42, '女', 4),
(10020, '孟和', 21, '男', 5),
(10021, '林伯', 55, '男', 6),
(10022, '唐妩', 23, '女', 1),
(10023, '韩章', 40, '男', 2),
(10024, '花姨', 36, '女', 3),
(10025, '卫峥', 22, '男', 4),
(10026, '秦越', 31, '男', 5),
(10027, '顾嬷嬷', 48, '女', 6),
(10028, '褚杰', 28, '男', 1),
(10029, '魏寿', 40, '男', 2),
(10030, '秦礼', 33, '男', 3),
(10031, '徐解', 36, '男', 4),
(10032, '崔孝', 42, '男', 5),
-- 新增2个无部门的员工（deptno为NULL）
(10033, '赵六', 25, '男', NULL),
(10034, '孙七', 30, '女', NULL);

-- 查询哪些部门有员工
select * from dept d left outer join emp e  on e.deptno=d.deptno;
-- 哪些部门没有员工查询员工有对应的部门，哪些没有
select * from emp e left outer join  dept d on e.deptno=d.deptno;
-- 使用union关键字实现左外连接和右外连接的并集
select * from emp e full outer join  dept d on e.deptno=d.deptno;
-- 版本问题，不能实现
select * from dept d left outer join emp e  on e.deptno=d.deptno 
union select * from dept d right outer join emp e  on e.deptno=d.deptno;

-- 查询年龄大于40的员工
select * from emp where age>40;                                                                                                                   







