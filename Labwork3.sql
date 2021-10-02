
/* Task1 */
--a
select * from course where credits>3;

--b
select * from classroom where building='Watson' or building='Packard';

--c
select * from course where dept_name='Comp. Sci.';

--d
select * from course,section where course.course_id=section.course_id and semester='Fall';

--e
select * from student where tot_cred between 45 and 90;

--f
select * from student where name similar to '%(a|e|i|o|u|y)';

--g
select * from course,prereq where course.course_id=prereq.course_id and prereq.prereq_id='CS-101';

/* Task2 */
--a
select dept_name , avg(salary) as avg_salary from instructor group by dept_name order by avg_salary;

--b
select building,count(*) from department,course
where course.dept_name=department.dept_name
group by building having count(*)=
                         (select max(cource_count)
                          from (select count(*) as cource_count
                                from department,
                                     course
                                where department.dept_name = course.dept_name
                                group by building) as building_count
                          );

--c
select dept_name,count(*) from course
group by dept_name having count(*)=
                          (select min(cource_count)
                          from (select count(*) as cource_count
                              from course group by dept_name) as dept_count
                          );

--d
select student.name,takes.id,count(takes.course_id)
from course,takes,student
where course.course_id=takes.course_id and  student.id=takes.id and course.dept_name='Comp. Sci.'
group by student.name, takes.id having count(takes.course_id)>3;

--e
select * from instructor
where dept_name='Music' or dept_name='Biology' or dept_name=' Philosophy';

--f
select instructor.ID,name,dept_name from instructor,teaches
where instructor.ID=teaches.ID and year=2018
except
select instructor.ID,name,dept_name from instructor,teaches
where instructor.ID=teaches.ID and year=2017;

/* Task3 */
--a
select student.*
from student,course,takes
where takes.course_id=course.course_id
  and student.ID=takes.ID
  and course.dept_name='Comp. Sci.'
  and (takes.grade='A' or takes.grade='A-')
order by name;

--b
select instructor.* from student,takes,advisor,instructor
where instructor.id = advisor.i_id
  and student.id = advisor.s_id
  and takes.id = student.id
  and (takes.grade = 'B-' or takes.grade = 'C+' or takes.grade = 'C' or takes.grade = 'C-' or takes.grade = 'F');

--c
select distinct department.* from student,takes,department
where student.ID=takes.ID and student.dept_name=student.dept_name
  and department.dept_name not in (select department.dept_name from student,takes,department
                                   where student.id = takes.id and department.dept_name = student.dept_name
                                     and (takes.grade = 'F' or takes.grade = 'C'));

--d
select instructor.* from instructor,teaches,takes
where instructor.ID=teaches.ID and takes.course_id=teaches.course_id
  and takes.grade!='A'
group by instructor.id;

--e
select distinct course.* from course,section,time_slot
where time_slot.time_slot_id = section.time_slot_id and course.course_id = section.course_id
  and  (time_slot.end_hr <= 11 and time_slot.end_min <= 50);