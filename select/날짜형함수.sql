-- curdate()-함수, current_date => yyyy-mm-dd
select curdate(), current_date;

-- curtime(), current_time = hh, mm, ss
select curtime(), current_time;

-- now(), sysdate(), current_timestamp()
select now(), sysdate(), current_timestamp();

-- now() : 쿼리실행하기 전에 와 sysdate() : 쿼리가 실행되면서 의 차이 : now는 쿼리가 들어갈떄 시간 sys는 2초후의 시간 그니까 now는 앞에now가 출력 sys는 뒤에sys가 출력
select now(), sleep(2), now();
select sysdate(), sleep(2), sysdate();

-- date_format
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초');
select date_format(sysdate(), '%y-%c-%e %h:%i:%s:%f');

-- period_diff(p1, p2)
-- : YYMM, YYYYMM으로 표기되는 p1과 p2의 차이의 개월을 반환
-- ex) 직원들의 근무 개월수 구하기
select concat(first_name, ' ', last_name) as name,
period_diff(date_format(curdate(), '%Y%m'),
date_format(hire_date, '%Y%m'))
from employees;

-- date_add, adddate
-- date_sub, subdate
-- (date, INTERVAL expr type)
-- : 날짜 date에 type 형식으로 지정한 expr값을 더하거나 뺸다
-- ex) 각 직원들의 6개월 후 근무 평가일
SELECT 
    CONCAT(first_name, ' ', last_name) AS name,
    hire_date,
    DATE_ADD(hire_date, INTERVAL 6 MONTH)
FROM
    employees;
    
-- cast
select now(), cast(now() as date), cast(now() as datetime);
select 1-2, cast(1-2 as unsigned);
select 1-2, cast(cast(1-2 as unsigned) as signed);