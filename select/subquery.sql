-- 단일행 연산alter
-- ex) 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요.

-- sol1-1) 
select b.emp_no, a.dept_no
from dept_emp a, employees b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and concat(b.first_name, ' ', b.last_name) = 'Fai Bale';


-- sol1-2)
select b.emp_no, concat(b.first_name, ' ', b.last_name) = 'Fai Bale'
from dept_emp a, employees b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and a.dept_no = 'd004';

-- sol subquery를 사용
SELECT b.emp_no, CONCAT(b.first_name, ' ', b.last_name) 
FROM dept_emp a, employees b
WHERE a.emp_no = b.emp_no
  AND a.dept_no = (SELECT a.dept_no
					FROM dept_emp a, employees b
				   WHERE a.emp_no = b.emp_no
					 AND a.to_date = '9999-01-01'
					 AND CONCAT(b.first_name, ' ', b.last_name) = 'Fai Bale')
  AND a.to_date = '9999-01-01'
  AND a.dept_no = 'd004';
  
  -- 서브쿼리는 괄호로 묶어야 함
  -- 서브쿼리는 오더바이 금지 오더바이는 결과가 다 나왔을 떄 하는거
  -- group by절 외에 거의 모든 절에서 사용가능(특히, from, where에 많이 사용)
  -- where 절인경우,
  --    1) 단일행 연산자 : =, >, <, <=, >=, <>(같지 않다)
  
  
  -- 실습문제1) 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요.
select CONCAT(a.first_name, ' ', a.last_name), b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.salary < (select avg(salary) from salaries where to_date = '9999-01-01')
order by b.salary desc;
select avg(salary) from salaries where to_date = '9999-01-01';

-- 실습문제1) 현재 가장적은 평균 급여를 받고 있는 직책에해서 평균 급여를 구하세요

-- TOP-K를 사용
select avg(a.salary)
from titles b, salaries a
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title
order by avg(a.salary) asc
limit 0, 1; -- 맨위에거만 뽑아내기

-- 57317.5736
select b.title, avg(a.salary)
from titles b, salaries a
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title
having round(avg(a.salary)) = 
	(select round(avg(a.salary))
	 from titles b, salaries a
	 where a.emp_no = b.emp_no
	 and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
	 group by b.title
	 order by avg(a.salary) asc -- order by를 할 수 없이 씀
	 limit 0, 1)
order by avg(a.salary) asc;

-- sol2) from절 서브쿼리 및 집계 min함수 사용
select min(a.avg_salary)
from (select round(avg(a.salary)) as avg_salary
from titles b, salaries a
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title) a;

-- 방법3 : join으로만 풀기(굳이 서브쿼리를 쓸 필요가 없다)
select b.title, round(avg(a.salary))
from titles b, salaries a
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title
order by avg(a.salary) asc
limit 0, 1;

-- where 절인경우
-- 2) 다중(복수)행 연산자 : in, not in, any, all
--   2-1) any 사용법
--       1. =any : in과 완전 동일
--       2. >any, >=any : 최소값
--       3. <any, <=any : 최대값
--       4. <>any, !=any : !=all 과 동일
--   2-2) all 사용법
--       1. =all
--       2. >all, >=all : 최대값
--       3. <all, <=all : 최소값

-- 1) 현재 급여가 50000 이상인 직원 이름 출력

-- 방법1) join으로 해결

select concat(a.first_name, ' ', a.last_name), b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.salary > '50000';

-- 방법2) subquery로 해결 (in)

select first_name
from employees a
where a.emp_no in (
	select emp_no
	from salaries
	where to_date = '9999-01-01'
	and salary > 50000);
    
-- 방법3) subquery로 해결 (=any)

select first_name
from employees a
where a.emp_no =any (
	select emp_no
	from salaries
	where to_date = '9999-01-01'
	and salary > 50000);
    
-- 2) 각 부서별로 최고 월급을 받는 직원의 이름과 월급 출력
-- dept_no, first_name, max_salary
select b.dept_no,c.first_name, max(a.salary) as max_salary
from salaries a, dept_emp b, employees c
where a.emp_no = b.emp_no
and   c.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.dept_no;

select c.dept_no, b.first_name, a.max_salary
from (select max(a.salary) as max_salary, a.emp_no
        from salaries a, dept_emp b
	   where a.emp_no = b.emp_no
		 and a.to_date = '9999-01-01'
		 and b.to_date = '9999-01-01'
	group by b.dept_no) a, 
	employees b, 
	dept_emp c 
where b.emp_no = c.emp_no
and b.emp_no = a.emp_no
and c.to_date = '9999-01-01'
order by a.max_salary;



-- ===================================================
select c.dept_no, max(b.salary) as max_salary
  from employees a, salaries b, dept_emp c
 where a.emp_no = b.emp_no
   and a.emp_no = c.emp_no
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
group by c.dept_no;

-- 방법1 : where절에 서브쿼리 사용
select a.first_name, c.dept_no, b.salary
  from employees a, salaries b, dept_emp c
 where a.emp_no = b.emp_no
   and a.emp_no = c.emp_no
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
   and (c.dept_no, b.salary) =any (
	   select c.dept_no, max(b.salary) as max_salary
	  from employees a, salaries b, dept_emp c
	 where a.emp_no = b.emp_no
	   and a.emp_no = c.emp_no
	   and b.to_date = '9999-01-01'
	   and c.to_date = '9999-01-01'
	group by c.dept_no);
    
-- 방법2 : from절에 서브쿼리 사용
select a.first_name, c.dept_no, d.max_salary
  from employees a, 
	   salaries b, 
       dept_emp c,
		   (select c.dept_no, max(b.salary) as max_salary
		  from employees a, salaries b, dept_emp c
		 where a.emp_no = b.emp_no
		   and a.emp_no = c.emp_no
		   and b.to_date = '9999-01-01'
		   and c.to_date = '9999-01-01'
		group by c.dept_no) d
 where a.emp_no = b.emp_no
   and a.emp_no = c.emp_no
   and c.dept_no = d.dept_no
   and b.salary = d.max_salary
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
   order by d.max_salary;
   
   
   
