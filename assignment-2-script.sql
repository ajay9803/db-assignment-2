-- students enrolled in math course
select student_id, student_name from students s 
where student_id in
(select student_id from enrollments e where e.course_id = 
(select course_id from courses c where c.course_name = 'Math'));

-- courses taken by Bob
select
	course_id,
	course_name
from
	courses c
where
	course_id in 
(
	select
		course_id
	from
		enrollments e
	where
		e.student_id = 
(
		select
			student_id
		from
			students s
		where
			s.student_name = 'Bob')
);

-- names of students enrolled in more than 1 course
select student_name from students s 
where student_id in 
(select student_id from enrollments e group by e.student_id having count(e.student_id) > 1);

-- students who are in grade A (grade_id = 1)
select student_id, student_name from students s 
where student_grade_id = 
(select grade_id from grades g where g.grade_id = 1);

-- number of students enrolled in each course
select course_id, count(course_id) from enrollments e 
group by (course_id)
order by e.course_id asc;

-- course with highest number of enrollments 
select course_name
from courses
where course_id in (
    select course_id
    from enrollments
    group by course_id
    having count(course_id) = (
        select max(course_count)
        from (
            select course_id, count(course_id) as course_count
            from enrollments
            group by course_id
        )
    )
);

-- students enrolled in all available courses
select
	student_name
from
	students s
where
	student_id in 
(
	select
		student_id
	from
		enrollments e
	group by
		student_id
	having
		count(distinct course_id) =
(
		select
			count(distinct course_id)
		from
			courses c)
);

-- students not enrolled in any courses
select student_id, student_name from students s
where s.student_id not in 
(select e.student_id from enrollments e);

-- average age of students enrolled in science course
select avg(student_age) from students s 
where s.student_id  in (
select student_id from enrollments e 
where e.course_id = (
select c.course_id from courses c where c.course_name = 'Science'
));

-- grade of students enrolled in the history course
select grade_name from grades where grade_id in (
select student_grade_id from students s 
where student_id in (
select student_id from enrollments e 
where course_id =
(select c.course_id from courses c where c.course_name = 'History')));





















