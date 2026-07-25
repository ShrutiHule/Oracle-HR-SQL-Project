
--1  Display countries whose name ends with 'a'.

Select  country_name  from countries  
where  country_name like '%a';

 
--2 Display employees whose phone number starts with 515.

Select  *  from employees  
where   phone_number like '515%' ;

 
--3 Find employees who have no dependents.

Select   e.employee_id,e.first_name 
from employees e 
left join  dependents d on e.employee_id=d.employee_id 
where  d.employee_id  is NULL;

 
--4	Rank employees based on salary.

Select  first_name, salary, rank()  over(order by salary desc) as rank_no 
from employees ;

  
--5 Display employees name and manager name.

Select  e.first_name as employee_name , m.first_name as  manager_name 
from employees e 
join employees m on e.manager_id=m.employee_id;


--6 Display all departments with the number of employees in each department.

select d.department_name , count(employee_id) as total_employee  
from departments d 
join employees e  on  e.department_id  = d.department_id
group by d.department_name;

 
--7 Find total salary paid in each department.

select  d.department_name  ,sum(salary) as Total_salary from  employees e
join  departments d on e.department_id = d.department_id 
group by  d.department_name;

 

--8 Find job title with more than 2 employees.

select job_title , count(employee_id) as number_of_employe 
from jobs  j join employees e on e.job_id=j.job_id 
group by  job_title  having count(employee_id)>2;

 

--9 Find employee working in departments located in the London

select e.first_name, d.department_name, l. city
from employees e join departments d    on e.department_id=d.department_id
join locations l on d. location_id = l. location_id  where l. city='London';

                           

--10 Display departments having more than 3 employees.

select  j. job_title,  count(employee_id) as Number_of_employees
from employees e  join jobs j on e.job_id=j.job_id 
group by j. job_title
having count(employee_id)>3;

 
--11 Find the maximum and minimum salary offered for each job.

select  j. job_title, max(salary) as maximum_salary , min(salary) as minimum_salary from employees e  join jobs j  on e.job_id= j.job_id 
group by job_title;

 
--12 Display the oldest employee.

select first_name, to_char (hire_date,'dd-mm-yyyy')  as hired_date 
from employees 
where hire_date =
      (select  min(hire_date)  from employees);

 


--13 Display employees working in departments whose name contain 'Sales'.

select e.first_name , d.department_name as employee_name 
from employees e   join departments d on e.department_id=d.department_id 
where d.department_id=
         (select department_id  from departments where department_name ='Sales');

 


--14 Display no of employees hired in each year.

Select  to_char(hire_date,'YYYY') as year  ,count(employee_id) as total_employee from  employees 
 group by  to_char(hire_date,'YYYY') order by year;


 --15 Display employees who joined in the month of June.

select first_name, hire_date 
from employees 
where to_char(hire_date,'Mon') ='Jun';

 

--16 Display employees working in the city seattle.

select first_name 
from employees where department_id IN
                             (select  department_id  from departments where location_id IN
                                                   (select location_id from locations where city='Seattle'));

 

--17 Display countries where the average salary is greater than 7000.

select c. country_name ,Round(avg(salary),2) as average_salary
from employees e join departments d on e.department_id=d.department_id
join locations l on d. location_id = l .location_id
join countries c on l. country_id = c .country_id 
group by c. country_name having avg(salary) >7000;


 
--18 Display departments name and the different job titles available in each department.

Select DISTINCT d.department_name , j .job_title 
from  departments  d  join  employees e on  e.department_id=d.department_id 
join  jobs  j on  e.job_id=  j.job_id  order by d.department_name;

 

--19 Display employee name with there dependent using union.

Select first_name from employees  UNION  
select first_name  from dependents;

   


--20 Find the highest paid salary in each city.

Select  l. city , Max (Salary) as maximum_salary 
from employees e join departments d on e. department_id=  d.department_id
join locations l on d. location_id=l. location_id
group by l. city;

 


--21 Find the total number of employees in each country.

Select c. country_name , count(employee_id) as total_no_employees
from employees e join departments d on e. department_id=d. department_id
join locations l on d. location_id=l. location_id 
join countries c on l. country_id=c. country_id 
group by c . country_name;

 

--22 Find employees who earn more than the average salary of their department.

select e. first_name, e. salary, d.department_name 
from employees e join departments d on e.department_id=d.department_id 
where e. salary> 
             (select avg(salary)  from employees where department_id=e.department_id);

 
--23 Find employees who earn the highest salary in their department.

select e. first_name ,d.department_name ,e. salary 
from employees e  join  departments d on e.department_id=d.department_id 
where e. salary=
             (select max(salary) from employees 
                        where department_id=e.department_id);

 

--24 find the 2nd highest salary .

Using Window _function
   select salary from
     (select salary, DENSE_RANK() over(order by salary desc)  as  rnk from      employees) where rnk=2;

Using  SubQuery

     select  max(salary) as "2nd highest salary "
     from employees
      where  salary< 
              (select max(salary) from employees);

 
 --25 Display regions having more than 5 departments.

select r. region_name  ,count(department_id) as departments
from regions r join countries c on r. region_id = c. region_id 
join locations l on l. country_id =c. country_id
join departments d on l. location_id=d. location_id  
group by r. region_name having count(department_id)>5;

 
