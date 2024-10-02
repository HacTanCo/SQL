--a. Đưa ra tuổi trung bình của các học viên
select avg(cast(Age as float))  as avgage
from Student
--b. Tính xem mỗi học viên đã thi được bao nhiêu ngày rồi
select Student.RN,Name,StudentTest.TestID,DATEDIFF(dd,Date,GETDATE()) as SNDT
from Student join StudentTest on Student.RN = StudentTest.RN
--c. Lấy ra những sinh viên không phải thi lại
select Student.RN,Name,Mark
from Student join StudentTest on Student.RN = StudentTest.RN
where mark >= 5

select Student.RN,Name,Mark
from Student join StudentTest on Student.RN = StudentTest.RN
where mark < 5

select Student.RN,name
from Student join StudentTest on Student.RN = StudentTest.RN
where Student.RN not in (
							select Student.RN
							from Student join StudentTest on Student.RN = StudentTest.RN
							where mark < 5
						)
group by Student.RN,name
--d. Đưa ra điểm của học viên dưới dạng 4 chữ số, 2 chữ số sau dấu phảy
select Student.RN,name,cast(Mark as decimal(4,2)) as mark
from Student join StudentTest on Student.RN = StudentTest.RN
--e. Hiển thị danh sách các học viên đã tham gia thi, các môn thi được thi bởi các học viên đó,
--điểm thi và ngày thi giống như hình sau:
select Student.RN,Student.Name,Test.Name,Mark,Date
from Student join StudentTest on Student.RN = StudentTest.RN
			 join Test on StudentTest.TestID = Test.testID
--f. Hiển thị danh sách các bạn học viên chưa thi môn nào như hình sau:
select Student.RN,Name,Age
from Student
where Student.RN not in(
					    select StudentTest.RN
					    from StudentTest
				        )

select Student.RN,Name,Age
from Student left join StudentTest on Student.RN = StudentTest.RN
where Mark is null
--g. Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. Danh sách
--phải sắp xếp theo thứ tự điểm trung bình giảm dần như sau:
select Student.rn,name,avg(Mark) as Avg
from Student join StudentTest on Student.RN = StudentTest.RN
group by Student.rn,name
order by avg(Mark) desc
--h. Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất như sau:			  
select  Student.rn,name,avg(Mark) as Avg
from Student join StudentTest on Student.RN = StudentTest.RN
group by Student.rn,name
having avg(mark) >= all (
							select  avg(Mark)
							from Student join StudentTest on Student.RN = StudentTest.RN
							group by Student.rn,name
						)
--i. Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn
--học như sau:
select Name,max(Mark) as maxmark
from Test join StudentTest on Test.testID=StudentTest.TestID
group by Name
order by name asc
--j. Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi nếu học viên
--chưa thi môn nào thì phần tên môn học để Null như sau:
select Student.rn,Student.Name,Test.name
from Student left join StudentTest on Student.RN = StudentTest.RN
			 left join Test on StudentTest.TestID = Test.testID
--k. Hiển thị danh sách sinh viên và số môn mà họ bị thi lại. Nếu học viên nào không bị thi lại
-- môn nào thì cột số môn ghi là 0.
select Student.RN,Name,count(mark) as SLTL
from Student join StudentTest on Student.RN = StudentTest.RN
where mark < 5
group by Student.RN,Name
union
select Student.RN,name,0 as STLT
from Student join StudentTest on Student.RN = StudentTest.RN
where Student.RN not in (
							select Student.RN
							from Student join StudentTest on Student.RN = StudentTest.RN
							where mark < 5
						)
group by Student.RN,name


--l. Hãy viết câu lệnh dùng đểm thêm mới 1 học viên
select * from Student

insert into Student
values (6,'b',12)
--m. Hãy xóa học viên vừa mới thêm vào.
delete from Student
where rn = 6
--n. Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi.
update Student
set Age += 1
--o. Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student. Hãy cập nhật(Update)
--trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’, trường hợp
--còn lại nhận giá trị ‘Old’ sau đó hiển thị toàn bộ nội dung bảng Student lên như sau:
alter table Student
add Status varchar(10)

update Student
set Status = case
				when Age < 30 then 'Young'
				else 'old'
			 end


