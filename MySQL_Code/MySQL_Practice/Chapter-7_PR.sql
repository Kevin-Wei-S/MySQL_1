# 第07章_单行函数
# 讲师：尚硅谷-宋红康（江湖人称：康师傅）
# 官网： http://www.atguigu.com
# 答案：
# 【题目】

# 1.显示系统时间(注：日期+时间)
SELECT NOW(), SYSDATE(), CONCAT(CURDATE(), " ", CURTIME()), CURRENT_TIMESTAMP(), 
LOCALTIME(), LOCALTIMESTAMP()
FROM DUAL;

# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
SELECT employee_id, last_name, salary, salary * 1.2 "new salary"
FROM employees;

# 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT last_name, CHAR_LENGTH(last_name) "length"
FROM employees
ORDER BY last_name;
#order by `length`;

# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
SELECT CONCAT_WS('_', employee_id, last_name, salary) "OUT_PUT"
FROM employees;

# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
SELECT employee_id, last_name, TRUNCATE(DATEDIFF(NOW(), hire_date) / 365, 0) "worked_years", 
DATEDIFF(NOW(), hire_date) "worked_days", TO_DAYS(NOW()) - TO_DAYS(hire_date) "to_days"
FROM employees
ORDER BY worked_years DESC, worked_days DESC;

# 6.查询员工姓名，hire_date , department_id，满足以下条件：雇用时间在1997年之后，department_id
#   为80 或 90 或110, commission_pct不为空
SELECT last_name, hire_date, department_id
FROM employees
#where hire_date >= '1997-01-01' # 存在著隱式轉換
#where date_format(hire_date, '%Y-%m-%d') >= '1997-01-01' # 格式化: 日期 ---> 格式化 (顯示轉換)
#where date_format(hire_date, '%Y') >= '1997' # 格式化: 優化寫法
#where hire_date >= str_to_date('1997-01-01', '%Y-%m-%d') # 解析: 字符串 ---> 日期 (顯示轉換)
WHERE hire_date >= STR_TO_DATE('1997', '%Y') # 優雅寫法: 解析: 減少比較且避免隱式轉換
AND department_id IN (80, 90, 110)
AND commission_pct IS NOT NULL
ORDER BY hire_date;

# 7.查询公司中入职超过10000天的员工姓名、入职时间
SELECT last_name, hire_date
FROM employees
WHERE DATEDIFF(NOW(), hire_date) > 10000;

# 8.做一个查询，产生下面的结果
#   <last_name> earns <salary> monthly but wants <salary*3>
SELECT CONCAT_WS(' ', last_name, 'earns', TRUNCATE(salary, 0), 'monthly but wants', TRUNCATE(salary * 3, 0)) "Dream Salary"
FROM employees; 

# 9.使用case-when，按照下面的条件：
/*
    job 	 grade
  AD_PRES	   A
  ST_MAN 	   B
  IT_PROG 	   C
  SA_REP 	   D
  ST_CLERK     E
  产生下面的结果:
*/
SELECT last_name "Last_name", job_id "Job_id", CASE job_id
			           WHEN 'AD_PRES' THEN 'A'
			           WHEN 'ST_MAN' THEN 'B'
			           WHEN 'IT_PROG' THEN 'C'
			           WHEN 'SA_REP' THEN 'D'
			           WHEN 'ST_CLERK' THEN 'E'
			           ELSE 'undefined' END "Grade"
FROM employees;		 


