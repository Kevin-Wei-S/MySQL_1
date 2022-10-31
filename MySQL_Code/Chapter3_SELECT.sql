#Chapter3_基本的SELECT語句

-- 1. SQL的分類
/*
 DDL(Data Definition Language): 數據定義語言
  - CREATE、ALTER、DROP、RENAME、TRUNCATE(清空表)
 DML(Data Manipulation Language): 數據操作語言
  - INSERT、DELETE、UPDATE、SELECT(重中之重)
 DCL(Data Control Language): 數據控制語言
  - COMMIT、ROLLBACK、SAVEPOINT、GRANT(權限賦予)、REVOKE(權限回收)

 學習技巧: 大處著眼, 小處著手.
*/

/*
 1. SQL的規則(必須要遵守):
   參考筆記
 2. SQL的規範(建議遵守):
   參考筆記
 3. MySQL的三種註釋:
   3.1. # 單行註釋
   3.2. -- 單行註釋(-- 後記得加上一個空格)
   3.3. 多行註釋(最外層包住這些文字的, 即為多行註釋)
*/

USE dbtest1;

INSERT INTO employees 
VALUES(5005, '低頭便見水中天', 'M');

# 字符串、日期時間類型的變量需要使用一對單引號(ANSI-SQL規格為單引號, MySQL雙引號也可, 要求較為鬆散)
# 但還是建議養成良好習慣, 爾後使用不同SQL(EX: Oracle)時能規避問題.

# 這是一個查詢語句
SELECT * FROM employees;

#在SQLyog不起作用, 可使用cmd查看結果.
#select * from employees\g
SHOW CREATE TABLE employees;

/*
  4. 導入現有的數據表、表的數據.
   方式一(cmd):
     source 文件的全路徑名	
   方式二:
     基於DBMS-GUI操作, 導入數據
     Tools->Execute SQL Script
*/

#5. 最基本的SELECT語句: SELECT 欄位1,欄位2,... FROM 表名
SELECT 1 + 5, 3 * 5;
#下述語句如同上述語句
SELECT 7 + 3, 18.5 * 5.2
FROM DUAL; #daul: 偽表

SELECT 18.5 * 5.2;
SELECT TRUE;
SELECT FALSE;
SELECT '2022/10/20'

# *: 表中的所有的欄位(Column、字段)
SELECT * FROM employees;

# commission_pct: 績效獎金%數
SELECT employee_id, last_name, salary, commission_pct
FROM employees;

#6. 欄位的別名
#ResultSet(結果集): 根據條件搜尋返回的所有結果
SELECT employee_id 員工編號, last_name 員工姓氏, salary 薪水, commission_pct 績效獎金率, department_id 部門編號
FROM employees;

# as: 全稱: alias(別名), 可以省略.
# 欄位的別名也可以使用一對""(雙引號)引起來, 如果別名中有空格, 需用雙引號才能判定含空格為別名.
# 承上, 別名不要使用單引號('')引起來, 根據ANSI-SQL規格應使用單引號, 唯MySQL在此處限制較為寬鬆.
# ANSI: American National Standars Institude
SELECT employee_id emp_id, last_name AS lname, salary * 12 AS "annual sal", commission_pct 績效獎金率, department_id "部門id"
FROM employees;

#7. 去除重複行
# 查詢員工表中一共有哪些部門id呢?
# 錯誤的: 沒有去重的情況
SELECT department_id
FROM employees;
# 正確的: 有去重的情況
SELECT DISTINCT department_id
FROM employees;

#錯誤的 (如此沒辦法判斷, salary要留哪一個)
SELECT salary,DISTINCT department_id
FROM employees;

# DISTINCT放在最前面: 表示Column組合不重複, 而非將第一欄位去重.
# 僅是沒有報錯, 結果無實際意義.
SELECT DISTINCT department_id, salary
FROM employees;

#8. 空值參與運算
# 8.1. 空值: null
# 8.2. null不等同於0、''、'null'.

SELECT * FROM employees;

# 8.3.空值參與運算: 結果一定也為空(null).
SELECT employee_id, salary "月薪", (salary * 12) * (1 + commission_pct)  "年薪", commission_pct
FROM employees;

# 實際問題的解決方案: 引入IFNULL
SELECT employee_id, salary "月薪", (salary * 12) * (1 + IFNULL(commission_pct, 0))  "年薪", commission_pct
FROM employees;

#9. 著重號(``): 表名或欄位名與關鍵字重名, 可用著重號著起來, 使MySQL可將其視為命名.
SELECT * FROM `order`;

#10. 查詢常數
SELECT '楷瑞集團', employee_id, last_name
FROM employees;

#11. 顯示表的結構
DESCRIBE employees; # 顯示表中各欄位的詳細訊息
#如同DESCRIBE
DESC employees;
DESC departments;

#12. 過濾數據
# Q1: 查詢90號部門的員工訊息
SELECT * 
FROM employees
# 過濾條件, 聲明在FROM結構的後面.
WHERE department_id = 90;

# Q2: 查詢last_name為'King'的員工訊息
# 在Windows系統, 表名、欄位名大小寫不敏感. 但在Linux系統, 大小寫是敏感的.
# 旦在字符串內按照ANSI-SQL規則, 必須是大小寫敏感. 而MySQL在這部分相對不敏感(不區分大小寫)
SELECT * 
FROM employees
WHERE last_name = 'King';



