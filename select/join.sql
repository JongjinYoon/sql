-- ANSI JOIN 1999

-- 1. join ~ on (ANSI SQL 1999)
-- SELECT 
--      a.emp_no, a.first_name, c.dept_name
-- FROM
--      employees a
-- JOIN dept_emp b 
-- ON a.emp_no = b.emp_no
-- JOIN departments c
-- ON b.dept_no = c.dept_no;

-- 2. natural join
select a.first_name, b.title
from employees a
natural join titles b;

-- 2-1. natural join의 문제점
select count(*)
from salaries a
natural join titles b;

-- 2-2. natural join의 문제점 => join ~ using으로 natural join의 문제점 해결
select count(*)
from salaries a
join titles b using(emp_no);
