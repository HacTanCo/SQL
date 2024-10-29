--a. Viết thủ tục/hàm với tham số truyền vào là ngày A(dd/mm/yyyy), thủ tục/hàm dùng để
--lấy danh sách các trận đấu diễn ra vào ngày ngày A, danh sách được sắp xếp theo
--MaTD, Sân đấu.
CREATE proc sp_TranDau_HienThi_TranDauDienRaVaoNgayA(@A datetime)
as
	begin
		select *
		from TranDau
		where Ngay = @A
		order by MaTD,SanDau desc
	end
sp_TranDau_HienThi_TranDauDienRaVaoNgayA '10-2-2023'

create function fc_TranDau_HienThi_TranDauDienRaVaoNgayA(@A datetime)
returns table
as
	return(
			select *
			from TranDau
			where Ngay = @A
			
		  )
select * from dbo.fc_TranDau_HienThi_TranDauDienRaVaoNgayA ('10-2-2023')
--b. Viết thủ tục/ hàm với tham số truyền vào là tên A, thủ tục/hàm dùng để lấy ra danh sách
--các cầu thủ có tên tương tự với tên A truyền vào này.
CREATE proc sp_CauThu_HienThi_SameNameA(@A nvarchar(50))
as
	begin
		select *
		from CauThu
		where TenCT like N'%' + @A + N'%'
	end
sp_CauThu_HienThi_SameNameA A

CREATE function fc_CauThu_HienThi_SameNameA(@A nvarchar(50))
returns table
as
	return(
			select *
			from CauThu
			where TenCT like '%' + @A + '%'
		  )
select * from dbo.fc_CauThu_HienThi_SameNameA('A')
--c. Tạo thủ tục/hàm có tham số truyền vào là MaTD. Thủ tục/hàm này dùng để lấy danh
--sách các cầu thủ đã thi đấu trong trận đấu đó. Danh sách gồm có MaCT, TenCT, SoTrai
create proc sp_CauThuAndThamGiaAndTranDau_HienThi_CacCauThuDaThiDauTrongTranDau(@matd varchar(20))
as
	begin
		select CauThu.MaCT,TenCT,MaDB
		from CauThu join ThamGia on CauThu.MaCT=ThamGia.MaCT
		where MaTD = @matd
	end
sp_CauThuAndThamGiaAndTranDau_HienThi_CacCauThuDaThiDauTrongTranDau TD01

create function fc_CauThuAndThamGia_HienThi_CacCauThuDaThiDauTrongTranDau(@matd varchar(20))
returns table
as
	return(
			select CauThu.MaCT,TenCT,MaDB
			from CauThu join ThamGia on CauThu.MaCT=ThamGia.MaCT
			where MaTD = @matd
		  )
select * from dbo.fc_CauThuAndThamGia_HienThi_CacCauThuDaThiDauTrongTranDau('TD01')
--d. Tạo thủ tục/hàm dùng để thống kê mỗi trọng tài đã điều khiển bao nhiêu trận đấu.
create proc sp_TranDau_ThongKe_TrongTaiDieuKhienMayTran
as
	begin
		select MaTD,TrongTai,count(MaTD) as SoTran
		from TranDau 
		group by MaTD,TrongTai
	end
sp_TranDau_ThongKe_TrongTaiDieuKhienMayTran

create function fc_TranDau_ThongKe_TrongTaiDieuKhienMayTran()
returns table
as
	return(
			select MaTD,TrongTai,count(MaTD) as SoTran
			from TranDau 
			group by MaTD,TrongTai
		  )
select * from dbo.fc_TranDau_ThongKe_TrongTaiDieuKhienMayTran()
--e. Tạo thủ tục/hàm với tham số truyền vào là ngay1(dd/mm/yyyy) và
--ngay2(dd/mm/yyyy), thủ tục/hàm dùng để thống kê số trận đấu của các đội bóng (làm
--chủ nhà) đã thi đấu trong các ngày từ ngay1 đến ngay2.
alter proc sp_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran(@A datetime,@B datetime)
	
as
	begin
		select TranDau.MaDB1,TenDB,count(MaTD) as SoTran
		from TranDau join DoiBong on TranDau.MaDB1=DoiBong.MaDB
		where Ngay between @A and @B 
		group by TranDau.MaDB1,TenDB
	end
sp_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran '10-1-2023','10-4-2023'

create function fc_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran(@A datetime,@B datetime)
returns table
as
	return(
			select TranDau.MaDB1,TenDB,count(MaTD) as SoTran
			from TranDau join DoiBong on TranDau.MaDB1=DoiBong.MaDB
			where Ngay between @A and @B 
			group by TranDau.MaDB1,TenDB
		  )
select * from dbo.fc_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran ('1-1-2023','10-4-2023')
--f. Viết thủ tục dùng để thêm mới 1 dòng dữ liệu vào bảng đội bóng, bảng cầu thủ, bảng
--trận đấu, và bảng tham gia.

--g. Viết thủ tục dùng để cập nhật dữ liệu của một cầu thủ, với thông tin cầu thủ là tham số
--truyền vào và tham số @ketqua sẽ trả về chuỗi rỗng nếu cập nhật cầu thủ thành công,
--ngược lại tham số này trả về chuỗi cho biết lý do không cập nhật được.
create proc sp_CauThu_Update(@MaCT varchar(20),@TenCT nvarchar(50),@MaDB int,@kq nvarchar(255) output)
as
	begin
		if(not exists (select * from CauThu where MaCT = @MaCT))
			set @kq = 'Player code not exists'
		else
			begin
				update CauThu
				set TenCT = @TenCT,MaDB = @MaDB
				where MaCT = @MaCT

				if(@@ERROR<>0) set @kq = 'Error when you update player: '+ ERROR_MESSAGE()
				else set @kq = 'Successful'
			end
	end
declare @kq nvarchar(255)
execute sp_CauThu_Update CT06,Nigger,1,@kq output
select @kq as Result
--h. Viết hàm với tham số truyền vào là năm, hàm dùng để lấy ra số trọng tài đã tham gia
--điều khiển các trận đấu trong năm truyền vào.
create function fc_TranDau_HienThi_TrongTaiDaDieuKhienTrongNam(@Year int)
returns int
as
	begin
		return(
				select count(TrongTai)
				from TranDau
				where year(Ngay) = @Year
			  )
	end
select dbo.fc_TranDau_HienThi_TrongTaiDaDieuKhienTrongNam(2023) as SoLuongTrongTai
--i. Viết thủ tục vào tham số truyền vào là mã cầu thủ, thủ tục dùng để xóa cầu thủ này.
--Gợi ý: nếu cầu thủ này đã từng tham gia ít nhất một trận đấu thì phải xóa dữ liệu ở
--bảng ThamGia trước rồi tiến hành xóa cầu thủ này)
alter proc sp_CauThuAndThamGia_Delete(@MaCT varchar(20),@kq nvarchar(255) output)
as
	begin
		if(not exists(select * from CauThu where MaCT = @MaCT))
			set @kq = 'Player code not exists'
		else
			begin
				if(exists (select * from ThamGia where MaCT = @MaCT))
					begin
						delete from ThamGia where MaCT = @MaCT
						delete from CauThu where MaCT = @MaCT
					end
				else 
					begin
						delete from CauThu where MaCT = @MaCT
					end

				if(@@ERROR<>0) set @kq = 'Error when you delete player: ' + ERROR_MESSAGE()
				else set @kq = 'Successful' 
			end
	end
declare @kq nvarchar(255)
execute sp_CauThuAndThamGia_Delete CT06,@kq output
select @kq as Result
--j. Viết hàm với tham số truyền vào là macauthu, hàm dùng để lấy ra tổng bàn thắng của
--cầu thủ này.
create function fc_CauThuAndThamGia_BanThangCua1CauThu(@MaCT varchar(20))
returns int
as
	begin
		return(
				select sum(SoTrai)
				from ThamGia 
				where MaCT = @MaCT
			  )
	end
select dbo.fc_CauThuAndThamGia_BanThangCua1CauThu('CT05') as SoTrai
--k. Viết một hàm trả về tổng bàn thắng mà mỗi cầu thủ ghi được trong tất cả các trận.
create function fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
returns table
as
	return(
			select CauThu.MaCT,TenCT,sum(SoTrai) as SoTrai
			from CauThu left join ThamGia on CauThu.MaCT=ThamGia.MaCT
			group by CauThu.MaCT,TenCT
		  )
select * from fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
--. Viết thủ tục/hàm lấy danh sách các cầu thủ ghi nhiều bàn thắng nhất.
create proc sp_CauThuAndThamGia_CauThuGhiBanNhieuNhat
as
	begin
		select MaCT,TenCT,SoTrai
		from dbo.fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
		where SoTrai = (select max(SoTrai) from fc_CauThuAndThamGia_TongBanCuaMoiCauThu())

		select CauThu.MaCT,TenCT,sum(SoTrai) as SoTrai
		from CauThu join ThamGia on CauThu.MaCT = ThamGia.MaCT
		group by CauThu.MaCT,TenCT
		having sum(SoTrai) >= all (
										select sum(SoTrai) as SoTrai
										from CauThu join ThamGia on CauThu.MaCT = ThamGia.MaCT
										group by CauThu.MaCT,TenCT
								  )
	end
sp_CauThuAndThamGia_CauThuGhiBanNhieuNhat

create function fc_CauThuAndThamGia_CauThuGhiBanNhieuNhat()
returns table
as
	return(
			select MaCT,TenCT,SoTrai
			from dbo.fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
			where SoTrai = (select max(SoTrai) from fc_CauThuAndThamGia_TongBanCuaMoiCauThu())

		  )
select * from dbo.fc_CauThuAndThamGia_CauThuGhiBanNhieuNhat()
--m. Viết thủ tục/hàm với tham số truyền vào số A, thủ tục/hàm dùng để lấy ra danh sách các
--cầu thủ ghi số bàn thắng lớn hơn số A này.
create proc sp_CauThuAndThamGia_CacCauThuGhiNhieuHonSoBanA(@A int)
as
	begin
		select *
		from fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
		where SoTrai > @A
	end
sp_CauThuAndThamGia_CacCauThuGhiNhieuHonSoBanA 2

create function fc_CauThuAndThamGia_CacCauThuGhiNhieuHonSoBanA(@A int)
returns table
as
	return(
			select *
			from fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
			where SoTrai > @A
		  )
select * from dbo.fc_CauThuAndThamGia_CacCauThuGhiNhieuHonSoBanA(-1)
--n. Viết thủ tục/hàm với tham số truyền vào là @nam. Thủ tục/hàm dùng để thống kê mỗi
--tháng trong năm truyền vào có bao nhiêu trận đấu được diễn ra. Nếu tháng nào không
--có trận đấu nào tổ chức thì ghi là 0.
create proc sp_TranDau_ThongKeMoiThangTrongNamCoBaoNhieuTran(@Year int)
as
	begin
		declare @Thang table (Thang int)
		declare @a int = 1
		while @a < 13
			begin
				insert into @Thang
				values (@a)
				set @a += 1
			end

		select a1.Thang,isnull(SoTran,0) as SoTran
		from @Thang as a1 left join (
									select month(Ngay)as Thang,count(MaTD) as SoTran
									from TranDau
									where year(Ngay) = @Year
									group by month(Ngay)
									) as a2 on a1.Thang=a2.Thang
	end
sp_TranDau_ThongKeMoiThangTrongNamCoBaoNhieuTran 2023

create function fc_TranDau_ThongKeMoiThangTrongNamCoBaoNhieuTran(@Year int)
returns @ThongKe table (Thang int, SoTran int)
as
	begin
		declare @BangPhu table (Thang int)
		declare @a int = 1
		while @a < 13
			begin
				insert into @BangPhu
				values (@a)
				set @a += 1
			end
		insert into @ThongKe
		select a1.Thang,isnull(SoTran,0) as SoTran
		from @BangPhu as a1 left join (
									select month(Ngay)as Thang,count(MaTD) as SoTran
									from TranDau
									where year(Ngay) = @Year
									group by month(Ngay)
									) as a2 on a1.Thang=a2.Thang
		return
	end
select * from fc_TranDau_ThongKeMoiThangTrongNamCoBaoNhieuTran(2023)
--o. Viết một thủ tục dùng để tạo ra một bảng mới có tên CauThu_BanThang, bảng này
--chứa tổng số bàn thắng mà mỗi cầu thủ ghi được. Nếu cầu thủ nào chưa ghi bàn thắng
--nào thì ghi số bàn thắng là 0.
alter proc sp_CreateTable_CauThu_BanThang
as
	begin
		declare @CauThu_BanThang table (MaCT varchar(20),TenCT nvarchar(50),SoTrai int)
		
		insert into @CauThu_BanThang
		select *
		from fc_CauThuAndThamGia_TongBanCuaMoiCauThu()

		select * from @CauThu_BanThang
	end
sp_CreateTable_CauThu_BanThang


--p. Viết một trigger, trigger này dùng để cập nhật tổng bàn thắng của cầu thủ ở bảng
--CauThu_BanThang mỗi khi có cập nhật hoặc thêm mới số bàn thắng của cầu thủ ở
--bảng ThamGia.

backup database QLDB to disk = 'C:\Users\Administrator\Desktop\HTC\SQL\Backup and Scrip\QLDB'
create trigger 
select * from DoiBong
select * from CauThu
select * from ThamGia
select * from TranDau




INSERT INTO ThamGia (MaTD, MaCT, SoTrai)
VALUES


SELECT 
    OBJECT_NAME(object_id) AS ObjectName, 
    definition AS Code
FROM sys.sql_modules;
