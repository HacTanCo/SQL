--a. Viết hàm dùng để lấy ra danh sách các học viên.
create function fc_Student_HienThi_DanhSachSinhVien()
returns table
as
	return(
			select * from students
		  )
select * from dbo.fc_Student_HienThi_DanhSachSinhVien()
--b. Viết hàm với tham số truyền vào là Họ, hàm dùng để lấy danh sách các học viên có họ
--giống với họ truyền vào.
create function fc_Student_HienThi_GiongHoVoi@Ho(@Ho nvarchar(50))
returns table
as
	return(
			select * 
			from students
			where studentname like @Ho + '%'
		  )
select * from dbo.fc_Student_HienThi_GiongHoVoi@Ho('Nguyen')
--c. Viết hàm với tham số truyền vào là mã môn học, hàm dùng để lấy ra số học viên đăng
--ký học môn học này.
create function fc_StudentAndSubject_HienThi_HocVienHocMonHoc(@mmh int)
returns int
as
begin
	return(
			select count(distinct studentid) as SoHocVien
			from Marks
			where subjectid = @mmh
		  )
end
select dbo.fc_StudentAndSubject_HienThi_HocVienHocMonHoc(1) as SoHocVien
--d. Viết hàm hiển thị danh sách và điểm của các học viên ứng với các môn học.
create function fc_StudentAndMark_HienThi_SinhVienVaDiem()
returns table
as
	return(
			select students.studentid,studentname,subjects.subjectid,subjectname,mark
			from students join Marks on students.studentid=Marks.studentid
						  join subjects on Marks.subjectid=subjects.subjectid
		  )
select * from dbo.fc_StudentAndMark_HienThi_SinhVienVaDiem()
--e. Viết hàm lấy ra số học viên hiện có.
create function fc_Student_HienThi_SoHocVienHienCo()
returns int
as
begin
	return(
			select count(studentid)
			from students
		  )
end
select dbo.fc_Student_HienThi_SoHocVienHienCo() as SoHocVienHienCos
--f. Viết hàm với tham số truyền vào là tuổi 1 đến tuổi 2, hàm dùng để lấy ra danh sách các
--học viên có độ tuổi từ tuổi 1 đến tuổi 2.
create function fc_Student_HienThi_Tuoi1DenTuoi2(@a int,@b int)
returns table
as
	return(
			select *
			from students
			where age>=@a and age<=@b
			--where age between @a and @a
		  )
select * from dbo.fc_Student_HienThi_Tuoi1DenTuoi2(1,29)
--g. Viết hàm tính điểm trung bình của các học viên
alter function fc_StudentAndMark_MarkAvg()
returns table
as
	return(
			select students.studentid,studentname,avg(cast(mark as float)) as AVG
			from students join Marks on students.studentid=Marks.studentid
			group by students.studentid,studentname
		  )
select * from dbo.fc_StudentAndMark_MarkAvg()
--h. Viết hàm lấy ra điểm trung bình lớn nhất của các học viên
alter function fc_StudentAndMark_Top1MarkAvg()
returns float
as
begin
	return(
			select max(avg)
			from fc_StudentAndMark_MarkAvg()
		  )
end
select dbo.fc_StudentAndMark_Top1MarkAvg() AS TOP1AVG
--i. Viết hàm hiển thị danh sách các học viên chưa thi môn nào
create function fc_StudentAndMark_HienThi_HocVienChuaThiMonNao() 
returns table
as
	return(
			select students.*
			from students left join Marks on students.studentid=Marks.studentid
			where Marks.studentid is NULL

			/*select *
			from students
			where students.studentid not in ( select studentid from Marks)*/
		  )
select * from dbo.fc_StudentAndMark_HienThi_HocVienChuaThiMonNao()
--j. Viết hàm với tham số truyền vào là điểm trung bình, hàm dùng để lấy ra danh sách các
--học viên có điểm trung bình lớn hơn điểm trung bình truyền vào.
create function fc_StudentAndMark_HienThi_@aLonHonMarkAVG(@a float)
returns table
as
	return(
			select *
			from dbo.fc_StudentAndMark_MarkAvg()
			where AVG > @a
		  )
select * from dbo.fc_StudentAndMark_HienThi_@aLonHonMarkAVG(4.44)
--k. Giả sử điểm (mark) của sinh viên từ 0, 1, 2, …, 9, 10. Hãy viết hàm với tham số truyền
--vào là mã môn học, hàm dùng để thống kê mỗi mức điểm này có bao nhiêu sinh viên
--đạt trong môn học này. (Ví dụ: điểm 0 có 2 người, điểm 1 có 0 người, …, điểm 10 có 2
--người).
create function fc_Mark_ThongKe_SoDiemTu0Toi10TungMon(@mmh int)
returns @BangDiem table (Diem int,SoSV int)
as
	begin
		declare @BangPhu table (Diem int)
		declare @a int = 0
		while @a < 11
		begin
			insert into @BangPhu
			values(@a)
			set @a += 1
		end

		insert into @BangDiem
		select tb1.Diem,ISNULL(tb2.SoSV,0)
		from @BangPhu as tb1 left join (
										select mark,count(studentid) as SoSV
										from Marks
										where subjectid = @mmh
										group by mark
										) as tb2 on tb1.Diem=tb2.mark
		return
	end
select * from fc_Mark_ThongKe_SoDiemTu0Toi10TungMon(1)
select * from fc_Mark_ThongKe_SoDiemTu0Toi10TungMon(2)
select * from fc_Mark_ThongKe_SoDiemTu0Toi10TungMon(3)
select * from fc_Mark_ThongKe_SoDiemTu0Toi10TungMon(4)

--l. Viết hàm lấy ra những sinh viên có điểm trung bình cao nhất.
create function fc_StudentAndMark_HienThi_SinhVienDiemAvgCaoNhat()
returns table
as
	return(
			select *
			from dbo.fc_StudentAndMark_MarkAvg()
			where AVG = dbo.fc_StudentAndMark_Top1MarkAvg()
		  )
select * from dbo.fc_StudentAndMark_HienThi_SinhVienDiemAvgCaoNhat()
--m. Viết hàm dùng để thống kê mỗi môn học có bao nhiêu học viên đăng kí thi.
create function fc_MarkAndSubject_ThongKe_MoiMonDangKiThiBaoNhieu()
returns table
as
	return(
			select subjects.subjectid,subjectname,count(studentid) as SoSVDangKyThi
			from Marks right join subjects on Marks.subjectid=subjects.subjectid
			group by subjects.subjectid,subjectname
		  )
select * from dbo.fc_MarkAndSubject_ThongKe_MoiMonDangKiThiBaoNhieu()
--n. Viết hàm với tham số truyền vào là SoSV, hãy lấy ra danh sách các môn học có số học
--viên đăng ký thi là nhỏ hơn SoSV truyền vào.
alter function fc_MarkAndSubjec_ThongKe_SoSvDkThinhohon@sosv(@a int)
returns table
as
	return(
			select *
			from dbo.fc_MarkAndSubject_ThongKe_MoiMonDangKiThiBaoNhieu()
			where SoSVDangKyThi < @a
		  )
select * from dbo.fc_MarkAndSubjec_ThongKe_SoSvDkThinhohon@sosv(3)
--o. Viết hàm để lấy ra danh sách học viên cùng với điểm trung bình của các học viên. Nếu
--học viên nào chưa có điểm thì ghi 0.
create function fc_StudentAndMark_HienThi_AvgOfAllStudent()
returns table
as
	return(
			select students.studentid,students.studentname,isnull(AVG,0) as AVG
			from students left join dbo.fc_StudentAndMark_MarkAvg() as a on students.studentid=a.studentid
		  )
select * from dbo.fc_StudentAndMark_HienThi_AvgOfAllStudent()

select * from students
select * from Marks
select * from subjects
select * from classes
select * from classtudent

backup database BTHS4 to disk = 'C:\Users\Administrator\Desktop\HTC\SQL\Backup and Scrip\ExHam.bak'
drop database BTHS4
create database BTHS4

USE master;
ALTER DATABASE BTHS4 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE BTHS4;
restore database BTHS4 from disk = 'C:\Users\Administrator\Desktop\HTC\SQL\Backup and Scrip\ExHam-BTHS4.bak'