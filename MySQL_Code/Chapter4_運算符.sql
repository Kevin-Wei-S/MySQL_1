# Chapter4-運算符

#1. 算術運算符: + - * /(DIV) %(MOD)
#符點型
SELECT 100, 100 + 1000 , 100 * 100, 10000 / 5, 99999 % 5
FROM DUAL;

SELECT 100, 100 + 1000.01 , 100 * 100, 10000 DIV 5, 99999 MOD 5
FROM DUAL;

SELECT 500 + 100 * 30
FROM DUAL;
# 在Java語言中100 + "200"(+號一種功能為算術運算符, 另一種為連接符), 結果為: 100200;
# 在SQL中+號沒有連接符的作用, 此時會將字符串轉換為數值(隱式轉換);
SELECT 100 + '200' 
FROM DUAL;

# 如果再SQL中需要連接符, 可以使用CONCAT()函數.
SELECT CONCAT(100, '200')
FROM DUAL;

# 如字符串無法轉換為有效數值, 將被轉換為0.
SELECT 10001 + 'Hi';
FROM DUAL;

# null值參與運算, 結果皆為null.
SELECT 1001 + NULL
FROM DUAL;

# 預設除法為除不進, 故開始DIV時, 預先轉為浮點型.
# 分母如果為0, 結果為null.
SELECT 100 * 1, 100 * 1.0, 100 DIV 1.0, 100 / 1.0, 100 / 2, 100 / 3, 100 / 0
FROM DUAL;

# 取模運算: %、MOD
SELECT 12 MOD 1, 12 MOD 5, 12 MOD -5, -12 % 5, -12 % -5
FROM DUAL;

#PR: 查詢員工id為偶數的員工訊息
SELECT *
FROM employees
WHERE employee_id % 2 = 0;

#2. 比較運算符
# 2.1. =、<=>(安全等於)、<>(不等於,也可以是: !=)、>、<、>=、<= 

# = : 等於

# 1 1 0 1 1 0 1 0 null 1 0 1
SELECT 101 > 100, 100 <=> 100, 100 <> 100, 100 != 101, 101 > 100, 101 < 100, 
101 >= 100, 101 <= 100, 0 = NULL, 1 = '1', 1 = 'z', 0 = 'z'
FROM DUAL; 

# 如果同為字符串, 將以字符串(ANSI)進行比較, 只有當字符串與數值進行運算時, 
# 字符串才會進行隱式轉換.
SELECT 'z' = 'dfsdfs', 'z' = 'z', 'sada' = 'sada'
FROM DUAL;

# 只要有null參與的判斷皆為null
SELECT 1 = NULL, 1 <> NULL, NULL <=> NULL, NULL <> NULL, 'Hi' <> NULL, 'Hi' = NULL
FROM DUAL;

SELECT employee_id, last_name, salary, commission_pct
FROM employees
#遍歷每一條數據如果下述結果為1, 則返回該條數據.
#where salary = 6000;
#commission_pct = NULL, 如果結果為1將返回, 但這比較運算結果為null, 故無相應結果返回.
WHERE commission_pct = NULL; # 此時執行, 不會有任何結果.

# <=> : 安全等於(為NULL而生)

SELECT 1 <=> 1, 1 <=> 2, 1 <=> 'Hi', 0 <=> 'Hi', 2 <=> '2'
FROM DUAL; 

SELECT NULL <=> NULL, NULL <=> 0, NULL <=> 'Hi'
FROM DUAL;

SELECT NULL > 1, NULL < 1, NULL >= 1, NULL <= 1, NULL <> 1
FROM DUAL;

# PR: 查詢表中欄位commission_pct為null的員工訊息
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE commission_pct <=> NULL;

SELECT 1 <> 2, '4' <> NULL, '' != NULL, NULL != NULL
FROM DUAL;

# 2.2. 非符號運算符
# IS NULL、IS NOT NULL、LEAST、GREATEST、BETWEEN AND、ISNULL、LIKE、IN、NOT IN、REGEXP、RLIKE

# 2.2.1. IS NULL、IS NOT NULL、ISNULL
# PR: 查詢表中欄位commission_pct為null的員工訊息
# M1:
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NULL;
# M2:
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE ISNULL(commission_pct);

# PR: 查詢表中欄位commission_pct非null的員工訊息
# M1:
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;
# M2:
SELECT employee_id, last_name, salary, commission_pct
FROM employees
# commission_pct <=> NULL 返回的結果, 遇到前綴的NOT, 原本 1->0, 而0->1.
WHERE NOT commission_pct <=> NULL;

# 2.2.2 LEAST()、GREATEST()
SELECT LEAST(5464, 465, 456, 15615, 4, 4654, 6)
FROM DUAL;

SELECT GREATEST(5464, 465, 456, 15615, 4, 4654, 6)
FROM DUAL;

SELECT LEAST('z', 'e', 'f', 't', 'h', 'g', 'f'),
GREATEST('z', 'e', 'f', 't', 'h', 'g', 'f')
FROM DUAL;

SELECT first_name, last_name
FROM employees;

SELECT LEAST(first_name, last_name), LEAST(LENGTH(first_name), LENGTH(last_name))
FROM employees;

# 2.2.3 BETWEEN d1(條件下界) AND d2(條件上界) (搜尋條件包含d1及d2) 
# PR: 查詢工資在6000到8000之間的員工訊息
SELECT employee_id, last_name, salary
FROM employees
# M1:
WHERE salary BETWEEN 6000 AND 8000;
# M2:
#where salary >= 6000 && salary <= 8000;

# 6000與8000不能互調, 因特定位置關係到條件上下界.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary BETWEEN 8000 AND 6000;

# PR: 查詢工資'不'在6000到8000之間的員工訊息
# M1:
SELECT employee_id, last_name, salary
FROM employees
WHERE salary NOT BETWEEN 6000 AND 8000;
# M2:
SELECT employee_id, last_name, salary
FROM employees
WHERE salary < 6000 || salary > 8000;

# 2.2.4 IN(SET)、NOT IN(SET)
# PR: 查詢部門為10、20、30的員工訊息
SELECT * 
FROM employees
# M1:
WHERE department_id IN (10, 20, 30);
# M2:
#where department_id = 10 || department_id = 20 || department_id = 30;

# PR: 查詢工資非6000、7000、8000的員工訊息
SELECT *
FROM employees
# M1:
WHERE salary NOT IN (6000, 7000, 8000);
# M2:
#where salary <> 8000 && salary <> 7000 && salary <> 6000;

# 2.2.5 LIKE: 模糊查詢
# PR: 查詢員工last_name中包含'a'的員工訊息
# %: 任意個數的字符(0個到多個)
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name LIKE '%a%';

# PR: 查詢員工last_name開頭為字符'a'的員工訊息
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name LIKE 'a%';

# PR: 查詢員工last_name結尾為字符'a'的員工訊息
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name LIKE '%a';

# PR: 查詢員工last_name包含字符'a'且'e'的員工訊息
# M1:
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';
# M2:
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name LIKE '%a%e%' OR last_name LIKE '%e%a%';

# PR: 查詢員工last_name第三個字符為'a'的員工訊息
# _ : 一個任意字符
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name LIKE '__a%';

# PR: 查詢員工last_name第二個字符為'_'且第三個字符為'a'的員工訊息
# 如果要使用'_'本身, 得使用'\_'來跳脫字元(轉義字符:\);
# M1:
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name LIKE '_\_a%';
# M2:
SELECT employee_id, last_name, salary
FROM employees
# 將ESCAPE後面的字符視為轉義字符
WHERE last_name LIKE '_!_a%' ESCAPE '!';

# 2.2.6 REGEXP、RLIKE: 正則表達式
SELECT 'wjkamitofo' REGEXP '^w', 'wjkamitofo' REGEXP 'o$', 'wjkamitofo' REGEXP 'amitofo'
FROM DUAL;

# . : 一個任意字符
SELECT 'atguigu' REGEXP 'gu.gu', 'atguigu' REGEXP '[abc]'
FROM DUAL;

#3. 邏輯運算符
# 或: OR、||; 且: AND、&&; 非: NOT、!; 異或: XOR

# OR、||; AND、&&;
SELECT * 
FROM employees
#where department_id = 10 || department_id = 20;
WHERE department_id = 50 AND salary > 6000;

# NOT、!
SELECT *
FROM employees
#where salary not between 6000 and 8000;
#where not commission_pct <=> null;
#where commission_pct is not null;
WHERE NOT commission_pct IS NULL;

# XOR(異或: 兩邊為一對正負, 結果為true, 其餘為false;)
# 即相同條件下OR集合中不包含相同條件AND集合
SELECT * 
FROM employees
#where department_id = 50 or salary > 6000;
WHERE department_id = 50 XOR salary > 6000;

# AND優先級高於OR
SELECT *
FROM employees
WHERE department_id = 20 AND salary > 10000 OR department_id = 90 AND salary > 20000; 

#4. 位運算符
# &(與) 、 |(或) 、 ^(異或) 、 ~(取反) 、 >>(右移) 、 <<(左移)
# & | ^
SELECT 12 & 5, 12 | 5, 12 ^ 5
FROM DUAL;

# ~
SELECT 10 & ~1
FROM DUAL;

# 在位元範圍內, 滿足位移後結果. 即: 每向左移動一位, 相當於乘以2; 每向右移動一位, 相當於除以2;
# >> <<
SELECT 4 << 2, 4 >> 2
FROM DUAL;
 



