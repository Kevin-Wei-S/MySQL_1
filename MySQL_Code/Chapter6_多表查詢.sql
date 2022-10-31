# Chapter6_多表查詢

#6.1. 熟悉常見的幾個表: employees、departments、locations
DESC employees;
DESC departments;
DESC locations;

SELECT * FROM departments;
SELECT * FROM locations;

# PR: 查詢一個員工名為'Abel'的員工在哪個城市工作?
SELECT *
FROM employees
WHERE last_name = 'Abel';

SELECT *
FROM departments
WHERE department_id = 80;

SELECT *
FROM locations
WHERE location_id = 2500;

#6.2. 出現笛卡爾積(交叉連接-CROSS JOIN)的錯誤

# 不正確的: 缺少多表的關聯條件
SELECT employee_id, department_name
FROM employees, departments; # 查詢出2889條數據, 但只有107個員工.

# 不正確的
SELECT employee_id, department_name
FROM employees CROSS JOIN departments; # 2889條件

# 根據推論: 每個員工都與每個部門匹配了一遍, 故有107 * 27 = 2889條數據;
SELECT * 
FROM employees; # 107條員工訊息

SELECT *
FROM departments; # 27條部門訊息
	
SELECT 107 * 27
FROM DUAL; # 2889條

#6.3. 多表查詢的正確方式: 需要有關聯條件
SELECT employee_id, department_name
FROM employees, departments
#兩個表的關聯條件
WHERE employees.`department_id` = departments.`department_id`; # 106條數據, 因有1位員工沒有部門.

#6.4. 如果查詢語句中出現了多個表中都存在的欄位, 則必須指明此欄位所在的表.
SELECT employees.employee_id, departments.department_name, employees.department_id
FROM employees, departments
WHERE employees.`department_id` = departments.`department_id`;

#建議: 從SQL優化的角度, 建議多表查詢時, 每個欄位前都指明其所在的表;

# 6.5.1. 可以給表起別名, 在SELECT及WHERE中使用表的別名
SELECT emps.employee_id, depts.department_name, emps.department_id
FROM employees emps, departments depts
WHERE emps.`department_id` = depts.`department_id`;

# 6.5.2. 如果給表起別名, 則在SELECT及WHERE中"必須"使用表的別名, 
#       不能使用表的原名, 否則會報錯.
#如下的操作是不正確的
SELECT emps.employee_id, departments.department_name, emps.department_id
FROM employees emps, departments depts
WHERE emps.`department_id` = depts.`department_id`;

#6.6. 結論: 如果有n個表來實現多表查詢, 則必須有至少n-1個關聯條件;
# PR: 查詢員工的employee_id、last_name、departmet_name、city
SELECT e.employee_id, e.last_name, d.department_name, l.city, d.department_id, l.location_id
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

/*
  演繹式: 提出問題1 ---> 解決問題1 ---> 提出問題2 ---> 解決問題2 ...
  
  歸納式: 總 ---> 分

*/

#6.7. 多表查詢的分類
/*
  角度1: 等值連接 vs 非等值連接
  
  角度2: 自連接 vs 非自連接
  
  角度3: 內連接 vs 外連接

*/

# 6.7.1. 等值連接 vs 非等值連接
# 非等值連接的例子:
SELECT *
FROM job_grades;

SELECT e.last_name, e.salary, j.grade_level
FROM employees e, job_grades j
#where e.salary between j.lowest_sal and j.highest_sal;
WHERE e.salary >= j.lowest_sal AND e.salary <= j.highest_sal;

# 6.7.2. 自連接 vs 非自連接
SELECT *
FROM employees;

# 自連接的例子:
# PR: 查詢員工id、員工姓名及管理者id、姓名.
# M1:
SELECT e1.employee_id, e1.last_name, e2.employee_id, e2.last_name
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id;
# M2:
SELECT e1.employee_id, e1.last_name, e1.department_id, e1.manager_id, e2.last_name "主管名稱"
FROM employees e1, employees e2
WHERE e1.manager_id = e2.employee_id;

# 6.7.3. 內連接 vs 外連接

# 內連接: 合併具有相同欄位的兩張表的條數據, 結果集內不包含兩張表中部匹配的內容.
#                     (EX: e.department_id = null, d.department_id並沒有null的欄位內容)
SELECT e.employee_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id # 只有106條數據
ORDER BY employee_id;

# 外連接: 合併具有相同欄位的兩張表的條數據, 結果集內包含匹配的內容外還囊括左表或右表中不匹配的Row.
# 外連接的分類: 左外連接、右外連接、滿外連接
# 左外連接: 兩個表在連接的過程中, 除了返回滿足連接條件的Row以外還返回左表中不滿足條件的Row, 這種連接稱為左外連接.
# 右外連接: 兩個表在連接的過程中, 除了返回滿足連接條件的Row以外還返回右表中不滿足條件的Row, 此連接則稱為右外連接.
# SQL92(SQL-2)、SQL99(SQL-3)

# PR: 查詢所有員工last_name, department_name的訊息
SELECT e.employee_id, e.last_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id; # 需要使用左外連接

# SQL92語法實現內連接: 見上, 略;
# SQL92語法實現外連接: 使用 + 號 ----- MySQL"不支持"SQL92語法中外連接的寫法
# MySQL不支持SQL92語法中的外連接寫法
SELECT e.employee_id, e.last_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

# SQL99語法中使用JOIN ... ON ... 的方式實現多表的查詢, 這種方式也能解決外連接的問題;
#      MySQL是支持此種方式的;
# SQL99語法如何實現多表的查詢: 

# SQL99語法實現內連接:
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id;

# PR-SQL99: 查詢員工的employee_id、last_name、departmet_name、city
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e INNER JOIN departments d # INNER可省略
ON e.department_id = d.department_id
JOIN locations l 
ON d.location_id = l.location_id
ORDER BY e.employee_id;

# SQL99語法實現外連接:
# PR: 查詢所有員工last_name, department_name的訊息
# 左外連接: 
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e LEFT OUTER JOIN departments d # OUTER可以省略
ON e.department_id = d.department_id
ORDER BY e.employee_id;

# 右外連接: INNER(106條) + 右外(非INNER 16條) = 122條數據
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e RIGHT OUTER JOIN departments d # OUTER可以省略
ON e.department_id = d.department_id
ORDER BY e.employee_id;

# 滿外連接: MySQL不支持SQL99的FULL OUTER JOIN(滿外)連接寫法 
# MySQL不支持SQL99: FULL OUTER JOIN
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e FULL JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id;

#6.8. UNION 及 UNION ALL 的使用
# UNION、UNION ALL(含重複交集<優先選擇, 可以少一步去重, 更加優化>);

#6.9. "7"種JOIN的實現(參考路徑: D:\Java  Learning\MySQL\MySQL_Photo\SQL-JOINS關聯圖.png)

# 路徑: 左上圖: 左外連接
SELECT employee_id, last_name, department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id; # 107條數據

# 路徑: 左中圖: 
SELECT employee_id, last_name, department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL; # 1條數據

# 路徑: 左下圖: 滿(全)外連接
# M1: 左上圖(左外連接) UNION ALL 右中圖
SELECT employee_id, last_name, department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL
UNION ALL
SELECT employee_id, last_name, department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id; # 共 123條

# M2: 左中圖 UNION ALL 右上圖(右外連接)
SELECT employee_id, last_name, department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
UNION ALL
SELECT employee_id, last_name, department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL; # 共 123條

# 路徑: 右上圖: 右外連接
SELECT employee_id, last_name, department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id; # 122條

# 路徑: 右中圖
SELECT employee_id, last_name, department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL; # 16條

# 路徑: 右下圖: 左中圖 + 右中圖	
SELECT employee_id, last_name, department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL
UNION ALL
SELECT employee_id, last_name, department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL; # 共 17條

# 路徑: 中圖: 內連接
SELECT employee_id, last_name, department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id; # 106條

# M1-1 - UNION ALL:
SELECT employee_id, last_name, department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
UNION ALL
SELECT employee_id, last_name, department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;

# M1-2 - UNION ALL:
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL
UNION ALL
SELECT employee_id, last_name, department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id;

# M2 - UNION ALL:
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL
UNION ALL
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL
UNION ALL
SELECT employee_id, last_name, department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id;

# M3 - UNION:
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
UNION 
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id;

#6.10. SQL99語法的新特性1: 自然連接(NATURAL JOIN)
SELECT employee_id, last_name, department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id
AND e.manager_id = d.manager_id;

# 同上: NATURAL JOIN: 如果兩張表有相同的欄位會全部自動等值連接
SELECT employee_id, last_name, department_name
FROM employees e NATURAL JOIN departments d;

#6.11. SQL99語法的新特性2: USING: 可以靈活選擇需等值的相同欄位.
#                                 不適合使用在"自連接".
SELECT employee_id, last_name, department_name
FROM employees e JOIN departments d
USING(department_id, manager_id);

# 拓展:
SELECT last_name, job_title, department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id
JOIN jobs j
ON e.job_id = j.job_id;

# 同上, 2種寫法都可行;
SELECT last_name, job_title, department_name
FROM employees e JOIN departments d JOIN jobs j
ON e.department_id = d.department_id
AND e.job_id = j.job_id;

