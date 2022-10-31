#第03章_基本的SELECT语句
#讲师：尚硅谷-宋红康（江湖人称：康师傅）
#官网： http://www.atguigu.com

#1.查询员工12个月的工资总和，并起别名为ANNUAL SALARY
SELECT employee_id, last_name, salary, salary * 12 * (1 + IFNULL(commission_pct, 0)) "ANNUAL SALARY", commission_pct 
FROM employees;

#2.查询employees表中去除重复的job_id以后的数据
SELECT DISTINCT job_id
FROM employees;

#3.查询工资大于12000的员工姓名和工资
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 12000; 

#4.查询员工号为176的员工的姓名和部门号
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE employee_id = 176;

#5.显示表 departments 的结构，并查询其中的全部数据
DESCRIBE departments;

SELECT *
FROM departments;

SELECT *
FROM locations;
