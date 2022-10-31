#Chapter5_排序與分頁

#5.1 排序

# 如果沒有使用排序操作, 默認情況下查詢返回的數據是按照添加數據的順序顯示的.
SELECT * FROM employees;

# 5.1.1. 基本使用
# PR: 按照salary從高到低的順序, 來顯示員工的訊息;
# 使用ORDER BY 對查詢到的數據進行排序操作
# 升序: ASC (ascend)(ORDER BY 默認)
# 降序: DESC (descend)
SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary DESC;

# PR: 按照salary從低到高的順序, 來顯示員工的訊息;
SELECT employee_id, last_name, salary
FROM employees
#ORDER BY salary asc;
ORDER BY salary; # 如果在ORDER BY之後沒有指名排序方式的話, 則默認按照升序.

# 5.1.2. 使用欄位的別名, 進行排序.
SELECT employee_id, last_name, salary, commission_pct, salary * 12 * (1 + IFNULL(commission_pct, 0)) annual_sal
FROM employees
ORDER BY annual_sal DESC;

# annual_sal是根據搜尋結果後再進行運算, 只要是原有欄位以外的別名數據, 
# 皆為WHERE查詢後才產生, 故WHERE篩選時, 不知此別名.
# 如下操作會報錯!
SELECT employee_id, last_name, salary, commission_pct, salary * 12 * (1 + IFNULL(commission_pct, 0)) annual_sal
FROM employees
WHERE annual_sal > 100000;

# 5.1.3. MySQL執行順序: 補充-WHERE必須聲明在FROM後, ORDER BY之前;
SELECT employee_id, last_name, salary, department_id # 3
FROM employees # 1
WHERE department_id IN (50, 60, 70) # 2
ORDER BY salary DESC; # 4

# 5.1.4. 多列排序(包含二、三、四、...級排序)
# PR: 顯示員工訊息, 按照部門編號降序排列, 如部門編號相同則按照salary升序排列;
SELECT employee_id, last_name, salary, department_id
FROM employees
ORDER BY department_id DESC, salary, employee_id DESC;

#5.2 分頁
# 5.2.1. MySQL使用LIMIT實現數據的分頁顯示
# PR1: 每頁顯示20條紀錄, 此時顯示第1頁.
SELECT employee_id, last_name, salary
FROM employees
# (pageNo - 1) * pageSize, pageSize
LIMIT 100, 20;

# PR2: 每頁顯示20條紀錄, 此時顯示第2頁.
SELECT employee_id, last_name, salary
FROM employees
# (pageNo - 1) * pageSize, pageSize
LIMIT 20, 20;

# PR3: 每頁顯示20條紀錄, 此時顯示第3頁.
SELECT employee_id, last_name, salary
FROM employees
# (pageNo - 1) * pageSize, pageSize
LIMIT 40, 20;

# PR: 每頁顯示pageSize條紀錄, 此時顯示第pageNo頁.
# 公式: limit (pageNo - 1) * pageSize, pageSize;

# 5.2.2. WHERE ... ORDER BY ... LIMIT 聲明順序如下:
# LIMIT的格式: 嚴格來說: LIMIT 位置偏移量, 條目數.
# 結構 "LIMIT 0, 條目數" 等價於 "LIMIT 條目數"
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > 6000
ORDER BY salary DESC, employee_id
#limit 0, 10;
LIMIT 10;

# PR: 表裡有107條數據, 我們只想要顯示32、33條數據, 如何處理呢?
SELECT employee_id, last_name, salary
FROM employees
LIMIT 31, 2;

# 5.2.3. MySQL8.0新特性: 結構: "LIMIT 條目數 OFFSET 位置偏移量"
SELECT employee_id, last_name, salary
FROM employees
LIMIT 2 OFFSET 31;

# PR: 查詢員工表中, 薪資最高的員工訊息
SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary DESC
#limit 0, 1;
LIMIT 1;

# 5.2.4 LIMIT可以用在MySQL、PostgreSQL、
#       MariaDB、SQLite(手機等移動端 - 輕量級數據庫)等數據庫中使用, 表示分頁;
# 不能使用在: Oracle、SQL Server、DB2(可於MySQL-Photo參照Oracle版本的分頁結構表示)












