-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?

select count(emp_no)
from salaries
where to_date = '9999-01-01'
and salary > (
	select avg(salary)
	from salaries
	where to_date = '9999-01-01');
    
-- 문제2.
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단
-- 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다.

select a.emp_no, concat(a.first_name, ' ', a.last_name), d.dept_name, e.max_salary
from employees a, 
	 salaries b, 
     dept_emp c, 
     departments d, 
		 (select c.dept_no, max(b.salary) as max_salary
			from employees a, salaries b, dept_emp c
		   where a.emp_no = b.emp_no
			 and a.emp_no = c.emp_no
			 and b.to_date = '9999-01-01'
			 and c.to_date = '9999-01-01'
		group by c.dept_no) e
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and c.dept_no = d.dept_no
and c.dept_no = e.dept_no
and b.salary = e.max_salary
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
order by e.max_salary desc;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요

select c.dept_no, avg(b.salary)
from employees a, 
	 salaries b, 
     dept_emp c
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01' 
group by c.dept_no
order by c.dept_no;

select a.emp_no, concat(a.first_name, ' ', a.last_name), b.salary, c.dept_no
	from employees a, 
		 salaries b, 
         dept_emp c,
		 (select c.dept_no, avg(b.salary) as avg_salary
			from employees a, 
				 salaries b, 
				 dept_emp c
			where a.emp_no = b.emp_no
			and a.emp_no = c.emp_no
			and b.to_date = '9999-01-01'
			and c.to_date = '9999-01-01' 
			group by c.dept_no
			order by c.dept_no) d
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and c.dept_no = d.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and d.avg_salary < b.salary;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.

select concat(a.first_name, ' ', a.last_name), d.dept_name
from employees a, titles b, dept_emp c, departments d
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and c.dept_no = d.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and title = 'manager'
group by d.dept_name;

select a.emp_no, concat(a.first_name, ' ', a.last_name), d.m_name, c.dept_name
from employees a, 
	 dept_emp b, 
     departments c,
		 (select concat(a.first_name, ' ', a.last_name) as m_name, d.dept_name
			from employees a, titles b, dept_emp c, departments d
		   where a.emp_no = b.emp_no
			 and a.emp_no = c.emp_no
			 and c.dept_no = d.dept_no
			 and b.to_date = '9999-01-01'
			 and c.to_date = '9999-01-01'
			 and title = 'manager'
		group by d.dept_name) d
where a.emp_no = b.emp_no
and c.dept_no = b.dept_no
and c.dept_name = d.dept_name
and b.to_date = '9999-01-01'
order by a.emp_no;

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로
-- 출력하세요.

		  select c.dept_no, max(b.salary)
			from employees a, salaries b, dept_emp c
		   where a.emp_no = b.emp_no
			 and a.emp_no = c.emp_no
			 and b.to_date = '9999-01-01'
			 and c.to_date = '9999-01-01'
		group by c.dept_no
		order by max(b.salary) desc
           limit 0, 1;
           
select a.emp_no, concat(a.first_name, ' ', a.last_name), c.title, b.salary
from employees a, 
	 salaries b, 
     titles c, 
     dept_emp d,
	     (select c.dept_no
			from employees a, salaries b, dept_emp c
		   where a.emp_no = b.emp_no
			 and a.emp_no = c.emp_no
			 and b.to_date = '9999-01-01'
			 and c.to_date = '9999-01-01'
		group by c.dept_no
		order by max(b.salary) desc
           limit 0, 1) e
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and a.emp_no = d.emp_no
  and d.dept_no = e.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and d.to_date = '9999-01-01'
order by b.salary desc;
  
-- 문제6.
-- 평균 연봉이 가장 높은 부서는?

          select d.dept_name, max(b.salary)
			from employees a, salaries b, dept_emp c, departments d
		   where a.emp_no = b.emp_no
			 and a.emp_no = c.emp_no
             and c.dept_no = d.dept_no
			 and b.to_date = '9999-01-01'
			 and c.to_date = '9999-01-01'
		group by c.dept_no
		order by max(b.salary) desc
           limit 0, 1;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?

		  select c.title, avg(b.salary)
			from employees a, salaries b, titles c
		   where a.emp_no = b.emp_no
			 and a.emp_no = c.emp_no
			 and b.to_date = '9999-01-01'
			 and c.to_date = '9999-01-01'
		group by c.title
		order by avg(b.salary) desc
           limit 0, 1;
           
-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

select concat(a.first_name, ' ', a.last_name), e.salary
from employees a, titles b, dept_emp c, departments d, salaries e
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and a.emp_no = e.emp_no
and c.dept_no = d.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and e.to_date = '9999-01-01'
and title = 'manager'
group by d.dept_name;

select d.dept_name, concat(a.first_name, ' ', a.last_name), b.salary, e.m_name, e.salary 
from employees a, 
     salaries b, 
     dept_emp c, 
     departments d,
	 (select a.emp_no, concat(a.first_name, ' ', a.last_name) as m_name, e.salary
		from employees a, titles b, dept_emp c, departments d, salaries e
		where a.emp_no = b.emp_no
		and a.emp_no = c.emp_no
		and a.emp_no = e.emp_no
		and c.dept_no = d.dept_no
		and b.to_date = '9999-01-01'
		and c.to_date = '9999-01-01'
        and e.to_date = '9999-01-01'
		and title = 'manager'
		group by d.dept_name) e
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and c.dept_no = d.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and b.salary > e.salary
order by d.dept_name;


