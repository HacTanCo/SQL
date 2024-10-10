--a. Viết thủ tục với tham số truyền vào là mã giảng viên $magv, haừy cho biết danh sách
--các môn học (tenmh) mà giảng viên này đã giảng dạy.
create proc sp_Monhoc_Select_GiangVienDaDay
	@magv nvarchar(50)
as
	begin
		select Monhoc.mamh,tenmh,Giangvien.magv,hoten
		from Giangvien join Day on Giangvien.magv=Day.magv
					   join Monhoc on Day.mamh=Monhoc.mamh
		where Giangvien.magv = @magv
	end
sp_Monhoc_Select_GiangVienDaDay GV01

select * from Giangvien
select * from Day
select * from Monhoc



--b. Viết thủ tục với tham số truyền vào là mã môn học $mamh , hãy cho biết họ tên các
--giảng viên giảng dạy môn học này.
create proc sp_Giangvien_Select_GiangVienDayMon
	@mamh nvarchar(50)
as
	begin
		select Giangvien.magv,hoten,Monhoc.mamh,tenmh
		from Giangvien join Day on Giangvien.magv=Day.magv
					   join Monhoc on Day.mamh=Monhoc.mamh
		where Monhoc.mamh = @mamh
	end
sp_Giangvien_Select_GiangVienDayMon MH01

select * from Giangvien
select * from Day
select * from Monhoc
--c. Viết thủ tục lấy ra tên giảng viên và tổng số đề án mà họ tham gia.
create proc sp_GiangVien_ThongKe_DeAnGiaoVienDaThamGia
as
	begin
		select Giangvien.magv,hoten,count(Dean.magv) as SoLanThamGiaDeAn
		from Giangvien left join Dean on Giangvien.magv=Dean.magv
		group by Giangvien.magv,hoten
	end	
sp_GiangVien_ThongKe_DeAnGiaoVienDaThamGia
select * from Giangvien
select * from Dean

--d. Viết thủ tục lấy ra tên bộ môn và tổng số môn học mà bộ môn này quản lý.
create proc sp_Bomon_ThongKe_SoMonHocBoMonQuanLy
as
	begin
		select Bomon.mabm,tenbm,count(Monhoc.mamh) as SoMonQuanLy
		from Bomon left join Monhoc on Bomon.mabm=Monhoc.mabm
		group by Bomon.mabm,tenbm	
	end
sp_Bomon_ThongKe_SoMonHocBoMonQuanLy
select * from Bomon
select * from Monhoc

--e. Viết thủ tục dùng để thống kê mỗi giáo viên dạy bao nhiêu môn.
alter proc sp_GiaoVien_ThongKe_GVDayBaoNhieuMon
as
	begin
		select Giangvien.magv,hoten,count(Day.mamh) as SoMonDay
		from Giangvien left join Day on Giangvien.magv=Day.magv
		group by Giangvien.magv,hoten
	end
sp_GiaoVien_ThongKe_GVDayBaoNhieuMon
select * from Giangvien
select * from Day
--f. Viết thủ tục với tham số truyền vào là tên giảng viên, hãy cho biết các giảng viên có họ
--tên tương tự với tên truyền vào này.
create proc sp_Giangvien_Select_SameName
	@ten nvarchar(50)
as
	begin
		select magv,hoten
		from Giangvien
		where hoten like '%'+@ten
	end
sp_Giangvien_Select_SameName d 
select * from Giangvien

--g. Viết thủ tục lấy ra tên của các giảng viên không tham gia bất cứ một đề án nào.
create proc sp_Giangvien_ThongKe_KhongLamDeAn
as
	begin
		select Giangvien.magv,hoten
		from Giangvien left join Dean on Giangvien.magv=Dean.magv
		where mada is null

		/*select magv,hoten
		from Giangvien 
		where Giangvien.magv not in (select Dean.magv from Dean)*/
	end
sp_Giangvien_ThongKe_KhongLamDeAn
select * from Giangvien
select * from Dean

--h. Viết thủ tục với tham số truyền vào là số @A, và số dòng @sodong, hãy cho biết danh
--sách các giảng viên dạy có số môn trên số A truyền vào này. Tham số @sodong trả về
--số dòng thống kê được theo đúng yêu cầu.
create proc sp_GiangVien_ThongKe_DayNhieuHon@A
	@a int, @sodong int output
as
	begin
		select Giangvien.magv,hoten,count(day.mamh) as SoMonDay
		from Giangvien left join Day on Giangvien.magv=Day.magv
		group by Giangvien.magv,hoten
		having count(day.mamh) > @a
		set @sodong = @@ROWCOUNT
	end
declare @sodong int
execute sp_GiangVien_ThongKe_DayNhieuHon@A 1,@sodong output 
select @sodong as SoDong

select * from Giangvien
select * from Day
--i. Viết thủ tục dùng để lấy danh sách các giảng viên dạy nhiều môn nhất.
create proc sp_GiangVien_ThongKe_Top1DiLamNoLe
as
	begin
		select Giangvien.magv,hoten,count(day.mamh) as SoMonDay
		from Giangvien left join Day on Giangvien.magv=Day.magv
		group by Giangvien.magv,hoten
		having count(day.mamh) >=all (
										select count(day.mamh) as SoMonDay
										from Giangvien left join Day on Giangvien.magv=Day.magv
										group by Giangvien.magv,hoten
									 )
	end
sp_GiangVien_ThongKe_Top1DiLamNoLe
select * from Giangvien
select * from Day

--j. Viết thủ tục với tham số truyền vào mã mên học $mamh , hãy cho biết họ tên các giảng
--viên giảng dạy môn học này, mà các giảng viên này không cùng bộ môn với môn học.
create proc sp_GiangVien_ThongKe_DayKhacNganh
	@mamh nvarchar(50)
as
	begin
		select Giangvien.magv,hoten
		from Giangvien join Day on Giangvien.magv=day.magv
		where Day.mamh = @mamh and GiangVien.mabm not in (select mabm
														  from MonHoc
														  where mamh = @mamh)	
		/*select Giangvien.magv,hoten
		from Giangvien join Day on Giangvien.magv=day.magv
					   join Monhoc on day.mamh=Monhoc.mamh
		where Monhoc.mamh = @mamh and Giangvien.mabm <> Monhoc.mabm	*/									  
				   
	end 
sp_GiangVien_ThongKe_DayKhacNganh MH01
--k. Viết thủ tục để lập danh sách các giảng viên với số đề án họ tham gia. Nếu giáo viên
--nào chưa tham gia đề án nào thỡ ghi số đề án của họ bằng 0.
create proc sp_GiangVien_ThongKe_ThamGiaDeAn
as
	begin
		select Giangvien.magv,hoten,count(Dean.magv) as SoLanTHamGIaDeAn
		from Giangvien left join Dean on Giangvien.magv=Dean.magv
		group by Giangvien.magv,hoten
	end
sp_GiangVien_ThongKe_ThamGiaDeAn
--l. Viết thủ tục để cho biết có bao nhiêu giảng viên dạy ít nhất 2 môn học.
create proc sp_GiangVien_ThongKe_Dayitnhat2mon
as
	begin
		select Giangvien.magv,hoten,count(Day.magv) as SoMonDay
		from Giangvien join Day on Giangvien.magv=Day.magv
		group by Giangvien.magv,hoten
		having count(day.magv) >= 2
	end
sp_GiangVien_ThongKe_Dayitnhat2mon
--m. Viết thủ tục dùng để thêm mới 1 một giáo viên. Thủ tục có các tham số là các thông tin
--của giáo viên và một tham số @ketqua sẽ trả về chuỗi rỗng nếu thêm mới giáo viên
--thành công, ngược lại tham số này trả về chuỗi cho biết lý do không thêm mới được.
create proc sp_GiangVien_AddTeacher
	@magv nvarchar(50),@hoten nvarchar(50),@tuoi int,@mabm nvarchar(50),@kq nvarchar(255) output
as
	if(exists (select * from Giangvien where magv = @magv))
		set @kq = 'Mã giảng viên đã tồn tại'
	else
		begin
			insert into Giangvien
			values (@magv,@hoten,@tuoi,@mabm)
			if(@@ERROR <> 0)
				set @kq = 'Error when you add teacher: '+ERROR_MESSAGE()
			else
				set @kq = ''
		end
declare @kq nvarchar(255)
execute sp_GiangVien_AddTeacher GV05,Fuckup,99,BM02,@kq output
select @kq as 'Kết quả'
--n. Viết thủ tục dùng để cập nhật 1 một giáo viên. Với các thông tin của giáo viên cần cập
--nhật là tham số truyền vào.
create proc sp_GiangVien_UpdateTeacher
	@magv nvarchar(50),@hoten nvarchar(50),@tuoi int,@mabm nvarchar(50),@kq nvarchar(255)  output
as
	if(not exists (select * from Giangvien where magv = @magv))
		set @kq = 'Mã giảng viên không tồn tại'
	else
		begin
			update Giangvien
			set hoten = @hoten, tuoi = @tuoi, mabm = @mabm
			where magv = @magv
			if(@@ERROR<>0) set @kq = 'Error when you update teacher: '+ ERROR_MESSAGE()
			else set @kq = 'Successful'
		end
declare @kq nvarchar(255)
execute sp_GiangVien_UpdateTeacher GV05,DontCry3b,2,BM01,@kq output
select @kq as 'Kết quả'
--o. Viết thủ tục dùng để xóa một giáo viên. Với mã giáo viên cần xóa là tham số truyền vào.
create proc sp_GiangVien_DeleteTeacher
	@magv nvarchar(50),@kq nvarchar(255) output
as
	if(not exists (select * from Giangvien where magv = @magv))
		set @kq = 'Mã giảng viên không tồn tại'
	else
		begin
			delete Giangvien
			where magv = @magv
			if(@@ERROR<>0) set @kq = 'Error when you delete teacher: '+ ERROR_MESSAGE()
			else set @kq = 'Successful'
		end
declare @kq nvarchar(255)
execute sp_GiangVien_DeleteTeacher GV05,@kq output
select @kq as 'Kết quả'

select * from Giangvien
select * from Day
select * from Monhoc
select * from Bomon

backup database QLGV to disk = 'C:\Users\Administrator\Desktop\HTC\SQL\Backup and Scrip\ExThuTucTiep.bak'
Drop database QLGV

create database QLGV
restore database QLGV from disk = 'C:\Users\Administrator\Desktop\HTC\SQL\Backup and Scrip\ExThuTucTiep.bak'
RESTORE VERIFYONLY FROM DISK = 'C:\Users\Administrator\Desktop\HTC\SQL\Backup and Scrip\ExThuTucTiep.bak';

USE master;
ALTER DATABASE QLGV SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE QLGV;




