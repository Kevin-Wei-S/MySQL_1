# Chapter8_聚合函數

#8.1. 常見的聚合函數

# 8.1.1. AVG、SUM: 只適用於數值類型的欄位(或變量)
SELECT AVG(salary), SUM(salary), AVG(salary) * 107
FROM employees;

# 如下的操作意義不大
SELECT AVG(last_name), SUM(last_name),SUM(hire_date), AVG(hire_date)
FROM employees;

# 8.1.2. MAX、MIN: 適用於數值類型、字符串類型、日期時間類型的欄位(或變量);
SELECT MAX(salary), MIN(salary), MAX(last_name), MIN(last_name),
MAX(hire_date), MIN(hire_date)
FROM employees;

# 8.1.3. COUNT
#  作用: 計算指定欄位在查詢結構中出現的個數(如果此欄位值為NULL, 不予累加)
SELECT COUNT(employee_id), COUNT(salary), COUNT(2 * salary), 
COUNT(commission_pct), COUNT(1), COUNT(2), COUNT(*)
FROM employees;

# 此邊常量有代數的概念, 假設一條數據為1 ,總共有幾個1;
SELECT 1
FROM employees;

# 搜尋欄位僅查詢一個常量, 則會在數據列表顯示過濾後總筆數個數的常量;
SELECT 1, 0, 100, 'GJJ!', TRUE, '2001-10-20'
FROM employees;

# 如果需計算表中有多少條紀錄, 將如何實現?
#  方式1: COUNT(*)
#  方式2: COUNT(1)
#  方式3: COUNT(具體欄位), 不一定對, 需此欄位沒有任何NULL的內容, 才成立;

# 計算指定欄位非NULL值的個數累加
SELECT COUNT(commission_pct)
FROM employees;

SELECT commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

# 公式: AVG(欄位n) = SUM(欄位n) / COUNT(欄位n)
# AVG(): 僅計算非空值的平均
# SUM(): 僅累加非空值的數值
SELECT AVG(salary), SUM(salary) / COUNT(salary),
AVG(commission_pct), SUM(commission_pct) / COUNT(commission_pct),
SUM(commission_pct) / COUNT(1)
FROM employees;

# PR: 查詢公司平均的獎金率(有別於有獎金的人其平均獎金率)

# 錯誤的: 需考慮到沒有獎金的人, 而非僅想到有獎金的人;
SELECT AVG(commission_pct)
FROM employees;

# 正確的:
SELECT SUM(commission_pct) / COUNT(1), 
SUM(commission_pct) / COUNT(IFNULL(commission_pct, 0)),
AVG(commission_pct) * COUNT(commission_pct) / COUNT(1),
AVG(IFNULL(commission_pct, 0))
FROM employees;

# 如果需要統計表中的紀錄數, 使用COUNT(*)、COUNT(1)、COUNT(具體欄位)何者效率更高?
# 如果使用的是 MyISAM 存儲引擎, 則三者效率相同, 算法複雜度都是O(1)級別的;
# 如果使用的是 InnoDB 存儲引擎, 則三者效率: COUNT(*) = COUNT(1) > COUNT(欄位) 

# 其他: 方差(開根號以後即標準差)、標準差(衡量數據的穩定性)、中位數

#8.2. GROUP BY的使用
# PR: 查詢各個部門的平均工資、最高工資 ?
SELECT department_id, AVG(salary), MAX(salary)
FROM employees
GROUP BY department_id;

# PR: 查詢各個job_id的平均工資?
SELECT job_id, AVG(salary), MAX(salary)
FROM employees
GROUP BY job_id;

# PR: 查詢各部門中各job_id的平均工資及最高工資?
# M1: (如同 5 * 18 = 18 * 5)(或 (帥、男、平靜) = (平靜、帥、男))
SELECT department_id, job_id, AVG(salary), MAX(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

# M2: 
SELECT job_id, department_id, AVG(salary), MAX(salary)
FROM employees
GROUP BY job_id, department_id
ORDER BY department_id;

# 錯誤的!
SELECT department_id, job_id, AVG(salary)
FROM employees 
GROUP BY department_id 
ORDER BY department_id;

# 結論1: SELECT當中非聚合函數的欄位, 在GROUP BY當中都必需聲明;
#        反之GROUP BY當中聲明的欄位, 未必得列在SELECT當中;

# 結論2: GROUP BY聲明在FROM(WHERE)之後, 及ORDER BY(LIMIT)之前;

# 結論3: MySQL中的新特性WITH ROLLUP: 每個分組都會有一條總結分組紀錄;
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id WITH ROLLUP;

# 小心WITH ROLLUP會加入排序, 需謹慎使用;
SELECT department_id, job_id, AVG(salary) "AVG"
FROM employees
GROUP BY department_id, job_id WITH ROLLUP
ORDER BY `AVG`;

# PR: 查詢各個部門的平均工資, 且平均工資呈升序排列;
# 正確的
SELECT department_id, AVG(salary) avg_sal
FROM employees
GROUP BY department_id
ORDER BY avg_sal ASC;

# 錯誤的: WITH ROLLUP的補充訊息不該加入排序;
SELECT department_id, AVG(salary) avg_sal
FROM employees
GROUP BY department_id WITH ROLLUP
ORDER BY avg_sal ASC;

#8.3. HAVING的使用
SELECT department_id, job_id, AVG(salary) "AVG"
FROM employees
GROUP BY department_id, job_id
HAVING `AVG` >= 5000
ORDER BY department_id;

#8.4. SQL底層的執行原理





