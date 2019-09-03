-- select 기본
select first_name,
		last_name
        gender,
        hire_date
from employees;
-- concat
select concat(first_name, ' ', last_name),
	   gender,
	   hire_date
  from employees;
  
-- alias -> as
-- 생략 가능
select concat(first_name, ' ', last_name) as name,-- 여깄는 as를 없애도 됨 한글도 됨 띄어쓰기는 ''를 넣어야함
	   gender as 성별,
	   hire_date as '입사 날짜'
  from employees;
  
  
-- 중복제거 distinct()
select distinct(title) from titles;

-- order by

select concat(first_name, ' ', last_name) as name,
	   gender as 성별,
	   hire_date as '입사 날짜'
  from employees
  order by hire_date desc;
  
-- where(조건절)
-- ex2) salaries 테이블에서 2001년 월급을 가장 높은순으로 사번, 월급순으로 출력
select emp_no, salary 
from salaries 
where from_date like '2001%'
order by salary desc;

-- employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select concat(first_name, ' ', last_name) as '이름',
		gender,
        hire_date
from employees
where hire_date < '1991-01-01'
order by hire_date desc;

-- employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
select concat(first_name, ' ', last_name) as '이름',
		gender,
        hire_date
from employees
where hire_date < '1991-01-01'
and gender ='f'
order by hire_date desc;

-- ex3) dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
select emp_no, dept_no
from dept_emp
where dept_no = 'd005'
or dept_no = 'd009'
-- where dept_no in('d005', 'd009');

-- like 검색 ex4) employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력  
select concat(first_name, ' ', last_name) as '이름',
		hire_date
from employees
where hire_date like '1989%'
order by hire_date desc;
