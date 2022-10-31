# Chapter7_單行函數

#7.1. 數值函數
# 基本操作:
SELECT ABS(-56465), SIGN(0), PI(), CEIL(5.4654654), CEILING(-43.23), FLOOR(-43.23), CEILING(78.5645646),
FLOOR(78.5645646), LEAST(465465,456,456,45,45,123,1,456,465), GREATEST(456,4,7,645,9,7,798,10010,79,78,98,8),
MOD(10000,33), 12 MOD 7, 12 % 6, SQRT(65536)
FROM DUAL;

# 取隨機數:
SELECT RAND(), RAND(465), RAND(-100), RAND(-100)
FROM DUAL;

# 四捨五入、截斷操作:
SELECT ROUND(5.5464564), ROUND(6.465956,3), TRUNCATE(102.14645646546556,12), TRUNCATE(193.456, -2),
TRUNCATE(465465.456465,0), ROUND(123.456,-2)
FROM DUAL;

# 單行函數嵌套:
SELECT TRUNCATE(RAND() * 100, 0)
FROM DUAL;

# 角度與弧度的轉換:

# 角度 -> 弧度:
SELECT RADIANS(30), RADIANS(45), RADIANS(60), RADIANS(90), RADIANS(180)
FROM DUAL;

# 弧度 -> 角度:
SELECT DEGREES(RADIANS(30)), DEGREES(RADIANS(45)), DEGREES(RADIANS(60)), DEGREES(RADIANS(90)), 
DEGREES(PI()), DEGREES(PI()/2), DEGREES(PI()/3),DEGREES(PI()/4),DEGREES(PI()/6)
FROM DUAL;

# 三角函數: SIN: 0, COS: -1, TAN: 0, ASIN: 90, ACOS: 0, ATAN: 45, ATAN2(可根據座標): 45, COT: null(+INFINITY||-INFINITY)
SELECT SIN(RADIANS(180)), COS(RADIANS(180)), TAN(RADIANS(180)), 
DEGREES(ASIN(1)), DEGREES(ACOS(1)), DEGREES(ATAN(1)), DEGREES(ATAN2(1)), COT(RADIANS(180))
FROM DUAL;

# 指數與對數:
SELECT POW(2, 10), POWER(3, 10), EXP(1), LN(EXP(101)), LOG(EXP(100)), LOG10(POW(10,18.5)),
LOG2(POW(2, 5.2))
FROM DUAL;

# 進制間的轉換:
SELECT BIN(10), OCT(32), HEX(178), CONV(1010, 8, 16)
FROM DUAL;

#7.2. 字符串函數
SELECT ASCII('HelloWorld'), CHAR_LENGTH('HelloWorld'), LENGTH('JustDoIt'),
CONCAT('Take','My','Breath','Away'), CONCAT_WS(' ','Take','my','breath','away!'),
INSERT('sdfsdJaxffsfs', 6, 4, 'Fizz'), REPLACE('dsfddLuxsfsdfs', 'Lux', 'Katarina'),
UPPER('vi'), UCASE('jinx'), LOWER('THE'), LCASE('AN'), 
LEFT('Nothing\'sGonnaChangeMyLoveForYou', 14), 
RIGHT('Nothing\'sGonnaChangeMyLoveForYou',12),
LPAD('Something', 20, '-!-'), RPAD('Puppy',10,'!-!')
FROM DUAL;

# CHAR_LENGTH: 字符長度; LENGTH: 字節長度;
SELECT CHAR_LENGTH('HowDoYouDo'), CHAR_LENGTH('最近如何'), LENGTH('HowDoYouDo'),
LENGTH('最近如何')
FROM DUAL;

# xxx worked for yyy
SELECT CONCAT(emp.last_name, ' work for ', mgr.last_name) "details"
FROM employees emp LEFT JOIN employees mgr
ON emp.manager_id = mgr.employee_id;

# 字符串的索引是從1開始的!
SELECT INSERT('helloworld', 2, 3, 'ddddd')
FROM DUAL;

SELECT last_name, salary
FROM employees
WHERE LOWER(last_name) = 'king';

SELECT RIGHT('hello', 2), LEFT('hello', 3), RIGHT('hello', 12)
FROM DUAL;

# LPAD: 實現右對齊效果
# RPAD: 實現左對齊效果
SELECT employee_id, last_name, LPAD(salary, 10, ' ')
FROM employees;

SELECT LTRIM('     past'), RTRIM('future     '), TRIM('     tranquil    '),
TRIM('*' FROM '***fdsfsdffs*********'), TRIM(LEADING '*' FROM '***fdsfsdffs*********'),
TRIM(TRAILING '*' FROM '***fdsfsdffs*********')
FROM DUAL;

SELECT REPEAT('GJJ!',12), LENGTH(SPACE(20)), 
STRCMP('z','a'), STRCMP('a','z'), STRCMP('z','z'), STRCMP('Z','z'),
ASCII('Z'), ASCII('z')
FROM DUAL;

SELECT SUBSTR('RollingInTheDeep', 8, 5), LOCATE('Jax', 'dsadasdasdsadaJaxfsdfdsfdsJax'),
INSTR('dsfdsffdsfsdfFizzfdsffsfFizz', 'Fizz')
FROM DUAL;

SELECT ELT(2, '1st', '2nd', '3rd', '4th', '5th', '6th', '7th'),
FIELD('Anivia', 'Jax', 'Fizz', 'Lux', 'Anivia', 'Jinx', 'Vi', 'Anivia', 'Cassiopeia'),
FIND_IN_SET('Yasuo', 'dda,sdsa,das,das,Yasuo,sda'),
REVERSE('!tIoDtsuJ'), NULLIF('QWERT', 'QWERTT')
FROM DUAL;

SELECT CONCAT('---', TRIM('        h e    l l o       '), '---')
FROM DUAL;

SELECT STRCMP('qwe','qwr')
FROM DUAL;

SELECT employee_id, NULLIF(LENGTH(first_name), LENGTH(last_name)) "compare"
FROM employees;

SELECT first_name, last_name
FROM employees;

# 7.3. 日期及時間函數

# 7.3.1. 獲取日期、時間
SELECT CURDATE(), CURRENT_DATE(), CURTIME(), CURRENT_TIME(),
NOW(), SYSDATE(), CURRENT_TIMESTAMP(), LOCALTIME(), LOCALTIMESTAMP(),
UTC_DATE(), UTC_TIME(), UTC_DATE() + 0, UTC_TIME() + 0
FROM DUAL;

# 7.3.2. 日期與時間戳的轉換
SELECT UNIX_TIMESTAMP(), FROM_UNIXTIME(3423423442), 
UNIX_TIMESTAMP('2050-10-10 12:00:00'), FROM_UNIXTIME(2548987200)
FROM DUAL;

# 7.3.3. 獲取月份、星期、星期數、天數等函數
SELECT FROM_UNIXTIME(4565464645), YEAR(FROM_UNIXTIME(4565464645)), 
MONTH(FROM_UNIXTIME(4565464645)), DAY(FROM_UNIXTIME(4565464645)),
HOUR(FROM_UNIXTIME(4565464645)), MINUTE(FROM_UNIXTIME(4565464645)),
SECOND(FROM_UNIXTIME(4565464645))
FROM DUAL;

# W1: 0; W2: 1; W3: 2; W4: 3; W5: 4; W6: 5; W7: 6;
SELECT FROM_UNIXTIME(4565464645), MONTHNAME(FROM_UNIXTIME(4565464645)),
DAYNAME(FROM_UNIXTIME(4565464645)), WEEKDAY(FROM_UNIXTIME(4565464645))
FROM DUAL;

SELECT FROM_UNIXTIME(4565464645), QUARTER(FROM_UNIXTIME(4565464645)),
WEEK(FROM_UNIXTIME(4565464645)), WEEKOFYEAR(FROM_UNIXTIME(4565464645))
FROM DUAL;

# 247; 4; 3;
SELECT FROM_UNIXTIME(4565464645), DAYOFYEAR(FROM_UNIXTIME(4565464645)),
DAYOFMONTH(FROM_UNIXTIME(4565464645)), DAYOFWEEK(FROM_UNIXTIME(4565464645))
FROM DUAL;

# 7.3.4. 日期的操作函數
SELECT FROM_UNIXTIME(4565464645), EXTRACT(YEAR FROM FROM_UNIXTIME(4565464645)),
EXTRACT(MONTH FROM FROM_UNIXTIME(4565464645)), EXTRACT(DAY FROM FROM_UNIXTIME(4565464645)),
EXTRACT(QUARTER FROM FROM_UNIXTIME(4565464645)), EXTRACT(MICROSECOND FROM FROM_UNIXTIME(4565464645.24)),
EXTRACT(WEEK FROM FROM_UNIXTIME(4565464645)), EXTRACT(HOUR FROM FROM_UNIXTIME(4565464645)),
EXTRACT(MINUTE FROM FROM_UNIXTIME(4565464645)), EXTRACT(SECOND FROM FROM_UNIXTIME(4565464645))
FROM DUAL;
                          
SELECT FROM_UNIXTIME(4565464645), EXTRACT(HOUR_SECOND FROM FROM_UNIXTIME(4565464645)),
EXTRACT(HOUR_MINUTE FROM FROM_UNIXTIME(4565464645)), EXTRACT(DAY_MICROSECOND FROM FROM_UNIXTIME(4565464645)),
EXTRACT(YEAR_MONTH FROM FROM_UNIXTIME(4565464645))
FROM DUAL;

# 7.3.5. 時間與秒鐘的轉換
# 18000 + 1800 + 12 = 19812; 10:02:02;
SELECT TIME_TO_SEC('05:30:12'), SEC_TO_TIME(36122), SEC_TO_TIME(108000), SEC_TO_TIME(86400)
FROM DUAL;

# 7.3.6. 計算日期和時間的函數
SELECT FROM_UNIXTIME(4565464645), DATE_ADD(FROM_UNIXTIME(4565464645), INTERVAL 5 DAY),
ADDDATE(FROM_UNIXTIME(4565464645), INTERVAL 1 QUARTER),
DATE_ADD(FROM_UNIXTIME(4565464645), INTERVAL 2 YEAR)
FROM DUAL;

SELECT FROM_UNIXTIME(4565464645), DATE_SUB(FROM_UNIXTIME(4565464645), INTERVAL 15 YEAR),
SUBDATE(FROM_UNIXTIME(4565464645), INTERVAL 2 WEEK),
DATE_SUB(FROM_UNIXTIME(4565464645), INTERVAL '5:31:02.88' HOUR_MICROSECOND) # 03:06:22.12000
FROM DUAL;

SELECT FROM_UNIXTIME(4565464645), ADDDATE(FROM_UNIXTIME(4565464645), INTERVAL '1-1' YEAR_MONTH),
DATE_ADD(FROM_UNIXTIME(4565464645), INTERVAL -2 YEAR)
FROM DUAL;

SELECT FROM_UNIXTIME(4565464645), ADDTIME(FROM_UNIXTIME(4565464645), '05:30:12'),
SUBTIME(FROM_UNIXTIME(4565464645), '12:05:10'), DATEDIFF(FROM_UNIXTIME(4565464645), NOW()),
TIMEDIFF('12:12:12', '8:12:5'), FROM_DAYS(732), TO_DAYS(NOW()), LAST_DAY(NOW())
FROM DUAL;

SELECT MAKEDATE(2100,101), MAKETIME(312,35,52), NOW(), UNIX_TIMESTAMP(NOW()),
FROM_UNIXTIME(4565464645), PERIOD_ADD(19000101010101, 1010)
FROM DUAL;                            #末兩位為12進制 1-12(沒有0; 13進位; 意義不明!)

SELECT NOW(), NOW() + 0
FROM DUAL;

# 7.3.7. 日期的格式化與解析

# 格式化: 日期 ---> 字串串
# 解析: 字符串 ---> 日期

# 之前隱式的格式化或解析:
# EX: 隱式轉換
SELECT *
FROM employees
WHERE hire_date = '1989-09-21';

# 日期顯示格式化和解析:
# 格式化:
SELECT DATE_FORMAT(CURDATE(), '%m(%M)/%d(%D)/%Y'), TIME_FORMAT(CURTIME(),'%p<%T>%k(%l).%i.%s'),
DATE_FORMAT(NOW(), '%Y-%m-%d'), TIME_FORMAT(NOW(), '%H:%i:%s'),
DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s %a %w %T %r')
FROM DUAL;

# 解析: 格式化的逆過程
SELECT STR_TO_DATE("12@@25##2500 20.32.22", '%m@@%d##%Y %s.%i.%H'),
STR_TO_DATE('2022-10-26 19:52:02 Wed 3 19:52:02 07:52:02 PM', '%Y-%m-%d %H:%i:%s %a %w %T %r')
FROM DUAL;

SELECT GET_FORMAT(TIME, 'USA')
FROM DUAL;

SELECT DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'USA')), DATE_FORMAT(NOW(), GET_FORMAT(TIME, 'USA')), DATE_FORMAT(NOW(), GET_FORMAT(TIME, 'ISO')),
DATE_FORMAT(NOW(), CONCAT(GET_FORMAT(DATE, 'ISO'), " ",GET_FORMAT(TIME, 'ISO'))),
DATE_FORMAT(NOW(), GET_FORMAT(DATETIME, 'INTERNAL')),
DATE_FORMAT(NOW(), GET_FORMAT(DATETIME, 'ISO'))
FROM DUAL;

#7.4. 流程控制函數
# 7.4.1. IF(VALUE, VALUE1, VALUE2)
SELECT IF(0 = 0, 'SS', 'S')
FROM DUAL;

SELECT employee_id, last_name, salary, IF(salary >= 12000, 'GJJ!', 'Ready!') "S-L"
FROM employees;

SELECT employee_id, last_name, salary,commission_pct, 
IF(commission_pct IS NULL, 0, commission_pct) "details",
salary * 12 * (1 + IF(commission_pct IS NULL, 0, commission_pct)) "annual_sal"
FROM employees;

# 7.4.2. IFNULL(VALUE1, VALUE2): 可以看做是一個 IF(VALUE, VALUE1, VALUE2) 的特殊情況
# IFNULL(VALUE1, VALUE2) = IF(VALUE1 IS NOT NULL, VALUE1, VALUE2)
SELECT IFNULL('R-Case', 'S-Case'), IFNULL(NULL, 'S-Case')
FROM DUAL;

SELECT employee_id, last_name , commission_pct,
salary * 12 * (1 + IFNULL(commission_pct,0)) "annual_pct"
FROM employees;

SELECT employee_id, last_name, commission_pct, IFNULL(commission_pct, 0) "detail"
FROM employees;

# 7.4.3. CASE WHEN <Condition1> THEN <Result1> WHEN <Condition2> THEN <Result2> ...
#        WHEN <ConditionN> THEN <ResultN> (ELSE <ResultE>) END
# 類似於 Java 中 if ... else if ... else

SELECT CASE
  WHEN 50 = 100
  THEN 'GJJ!'
  WHEN 50 >= 85
  THEN 'Beautiful!'
  WHEN 50 >= 60
  THEN 'Great!'
  ELSE 'Potential!'
  END
FROM DUAL;

SELECT employee_id, commission_pct, CASE
  WHEN commission_pct >= 0.35
  THEN 'Top-Sales'
  WHEN commission_pct >= 0.25
  THEN 'Ready-Sales'
  WHEN commission_pct >= 0
  THEN 'Potential-Sales'
  ELSE 'Life-Sales' END "Sales-Type", department_id
FROM employees;

# 7.4.4. CASE <Condition> WHEN <VALUE1> THEN <Result1> WHEN <VALUE2> THEN <Result2> ...
#        WHEN <VALUEN> THEN <ResultN> (ELSE <ResultE>) END
# 類似於 Java 中的 switch ... case

SELECT employee_id , department_id, CASE department_id
  WHEN 90
  THEN 'Executive'
  WHEN 50
  THEN 'Shipping'
  WHEN 80
  THEN 'Sales'
  WHEN 60
  THEN 'IT'
  ELSE 'Else'
  END "department"
FROM employees
ORDER BY employee_id;

SELECT *
FROM departments;

# PR1: 查询部门号为 10,20, 30 的员工信息, 若部门号为 10, 则打印其工资的 1.1 倍, 20 号部门, 
#     则打印其工资的 1.2 倍, 30 号部门打印其工资的 1.3 倍数, 其他部門為 1.4 倍數。
SELECT employee_id, last_name, salary, department_id, CASE department_id
  WHEN 10 THEN salary * 1.1
  WHEN 20 THEN salary * 1.2
  WHEN 30 THEN salary * 1.3
  ELSE salary * 1.4 END "weighted_sal"
FROM employees;			  

# PR1: 查询部门号为 10,20, 30 的员工信息, 若部门号为 10, 则打印其工资的 1.1 倍, 20 号部门, 
#     则打印其工资的 1.2 倍, 30 号部门打印其工资的 1.3 倍数, 其他部門為 1.4 倍數。
SELECT employee_id, last_name, salary, department_id, CASE department_id
  WHEN 10 THEN salary * 1.1
  WHEN 20 THEN salary * 1.2
  WHEN 30 THEN salary * 1.3
  END "weighted_sal"
FROM employees
WHERE department_id IN (10, 20, 30);

#7.5. 加密與解密的函數

# 7.5.1 PASSWORD(), 此函數在MySQL 8.0棄用;
SELECT MD5('mysql'), SHA('mysql'), LENGTH(MD5('mysql')), LENGTH(SHA('mysql')),
MD5('81c3b080dad537de7e10e0987a4bf52e'), SHA('f460c882a18c1304d88854e902e11b85d71e7e1b')
FROM DUAL;

#ENCODE()、DECODE(), 這些函數在MySQL 8.0也被棄用;
/*
SELECT ENCODE('mysql', 'qwerLol'), DECODE(ENCODE('mysql','qwerLol'), 'qwerLol')
FROM DUAL;
*/

#7.6. MySQL訊息函數

SELECT VERSION(), CONNECTION_ID(), DATABASE(), SCHEMA()
FROM DUAL;

SELECT USER(), CURRENT_USER(), SYSTEM_USER(), SESSION_USER()
FROM DUAL;

SELECT CHARSET('英雄聯盟qwerLol'), COLLATION('英雄聯盟werLol')
FROM DUAL;

#7.7. 其他函數
SELECT FORMAT(6165.5655165, 2), CONV(239, 10, 16), 
# (192 * 256 ^ 3) + (168 * 256 ^ 2) + (1 * 256 ^ 1) + (108 * 256 ^ 0)
INET_ATON('192.168.1.108'),
INET_NTOA(3232235884),
CONVERT('阿彌陀佛' USING 'UTF8')
FROM DUAL;

# BENCHMARK(): 此函數用於測試表達式執行的效率
SELECT BENCHMARK(100000, SHA('mysql'))
FROM DUAL;

# 實現字符集的轉換
SELECT CHARSET('阿彌陀佛'), 
CONVERT('阿彌陀佛' USING 'BIG5'), CONVERT('阿彌陀佛' USING 'GBK'), 
CONVERT('阿彌陀佛' USING 'ASCII'), CONVERT('阿彌陀佛' USING 'Latin5'),
CONVERT('阿彌陀佛' USING 'UTF8'), CONVERT('阿彌陀佛' USING 'UTF8MB4')
FROM DUAL;

SELECT CHARSET('阿彌陀佛'), 
CHARSET(CONVERT('阿彌陀佛' USING 'BIG5')), CHARSET(CONVERT('阿彌陀佛' USING 'GBK')), 
CHARSET(CONVERT('阿彌陀佛' USING 'ASCII')), CHARSET(CONVERT('阿彌陀佛' USING 'Latin5')),
CHARSET(CONVERT('阿彌陀佛' USING 'UTF8')), CHARSET(CONVERT('阿彌陀佛' USING 'UTF8MB4'))
FROM DUAL;

# 10000 22B8 NULL
SELECT CONV(16, 10, 2), CONV(8888, 10, 16), CONV(NULL, 10, 2)
FROM DUAL;



