-- 절대값
select abs(2), abs(-2);

-- mod 연산
select mod(7,2), mod(15,4);

-- floor
select floor(3.14), floor(-3.14);

-- ceiling
select ceiling(3.14), ceiling(-3.14);

-- round(x) : x에 가장 근접한 정수
select round(1.298), round(1.5111);

-- round(x, d) : d자리에 가장 근접한 실수
select round(1.298, 1), round(1.5111, 3);

-- 제곱승 
select power(2, 10), pow(10, 5);

-- sign(x) : x가 음수이면 -1, 양수이면1 0이면 0
select sign(-2), sign(2), sign(0);

-- 가장 큰 값, 가장 작은 값
SELECT GREATEST(10, 2, 4, 9), least(10, 2, 4, 9),
greatest('Abc', 'Abc1', 'ABcd');
