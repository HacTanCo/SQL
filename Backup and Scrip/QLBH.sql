--a. Viết thủ tục/hàm với tham số truyền vào là ngày A(dd/mm/yyyy), thủ tục/hàm dùng để
--lấy danh sách các trận đấu diễn ra vào ngày ngày A, danh sách được sắp xếp theo
--MaTD, Sân đấu.
alter proc sp_TranDau_HienThi_TranDauDienRaVaoNgayA(@A datetime)
as
	begin
		select *
		from TranDau
		where Ngay = @A
		order by MaTD,SanDau desc
	end
sp_TranDau_HienThi_TranDauDienRaVaoNgayA '10-1-2023'

create function fc_TranDau_HienThi_TranDauDienRaVaoNgayA(@A datetime)
returns table
as
	return(
			select *
			from TranDau
			where Ngay = @A
			
		  )
select * from dbo.fc_TranDau_HienThi_TranDauDienRaVaoNgayA('10-2-2023')
order by MaTD,SanDau desc
--b. Viết thủ tục/ hàm với tham số truyền vào là tên A, thủ tục/hàm dùng để lấy ra danh sách
--các cầu thủ có tên tương tự với tên A truyền vào này.
alter proc sp_CauThu_HienThi_SameNameA(@A nvarchar(50))
as
	begin
		select *
		from CauThu
		where TenCT like N'%' + @A + N'%'
	end
sp_CauThu_HienThi_SameNameA Nguyễn
alter function fc_CauThu_HienThi_SameNameA(@A nvarchar(50))
returns table
as
	return(
			select *
			from CauThu
			where TenCT like '%' + @A + '%'
		  )
select * from dbo.fc_CauThu_HienThi_SameNameA('Lê')
--c. Tạo thủ tục/hàm có tham số truyền vào là MaTD. Thủ tục/hàm này dùng để lấy danh
--sách các cầu thủ đã thi đấu trong trận đấu đó. Danh sách gồm có MaCT, TenCT, SoTrai
create proc sp_CauThuAndThamGiaAndTranDau_HienThi_CacCauThuDaThiDauTrongTranDau(@matd varchar(20))
as
	begin
		select CauThu.MaCT,TenCT,MaDB
		from CauThu join ThamGia on CauThu.MaCT=ThamGia.MaCT
		where MaTD = @matd
	end
sp_CauThuAndThamGiaAndTranDau_HienThi_CacCauThuDaThiDauTrongTranDau 'TD01'
create function fc_CauThuAndThamGia_HienThi_CacCauThuDaThiDauTrongTranDau(@matd varchar(20))
returns table
as
	return(
			select CauThu.MaCT,TenCT,MaDB
			from CauThu join ThamGia on CauThu.MaCT=ThamGia.MaCT
			where MaTD = @matd
		  )
select * from dbo.fc_CauThuAndThamGia_HienThi_CacCauThuDaThiDauTrongTranDau('TD02')
--d. Tạo thủ tục/hàm dùng để thống kê mỗi trọng tài đã điều khiển bao nhiêu trận đấu.
create proc sp_TranDau_ThongKe_TrongTaiDieuKhienMayTran
as
	begin
		select MaTD,TrongTai,count(MaTD) as SoTran
		from TranDau 
		group by MaTD,TrongTai
	end
sp_TranDau_ThongKe_TrongTaiDieuKhienMayTran

create function fc_sp_TranDau_ThongKe_TrongTaiDieuKhienMayTran()
returns table
as
	return(
			select MaTD,TrongTai,count(MaTD) as SoTran
			from TranDau 
			group by MaTD,TrongTai
		  )
select * from dbo.fc_sp_TranDau_ThongKe_TrongTaiDieuKhienMayTran()
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
sp_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran '10-1-2023','20-4-2023'
create function fc_sp_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran(@A datetime,@B datetime)
returns table
as
	return(
			select TranDau.MaDB1,TenDB,count(MaTD) as SoTran
			from TranDau join DoiBong on TranDau.MaDB1=DoiBong.MaDB
			where Ngay between @A and @B 
			group by TranDau.MaDB1,TenDB
		  )
select * from dbo.fc_sp_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran('10-1-2023','20-4-202)





create proc sp_
create function fc_
create proc sp_
create function fc_
create proc sp_
create function fc_



select * from CauThu
select * from ThamGia
select * from TranDau
select * from DoiBong
