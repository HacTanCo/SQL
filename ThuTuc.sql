--			KHÔNG TRẢ VỀ

create procedure sp_KhachHang_SelectAll
as
	begin
		select *
		from tbl_KhachHang
	end

sp_KhachHang_SelectAll
-------------------------

create procedure sp_KhachHang_SelectGT
	@gt bit
as
	begin
		select *
		from tbl_KhachHang
		where GT = @gt
	end

sp_KhachHang_SelectGT 1
sp_KhachHang_SelectGT 0
---------------------------
create proc sp_KhachHang_SelectHo
	@ho nvarchar(50)
as
	begin
		select *
		from tbl_KhachHang
		where TenKH like N''+@ho+'%'
	end
sp_KhachHang_SelectHo N'Nguyễn'
sp_KhachHang_SelectHo Lê
sp_KhachHang_SelectHo N'Trần'

select * from tbl_HoaDon


create proc sp_HoaDon_SelectTongTien_DayAndYear
	@month int,@year int
as
	begin
		select tbl_HoaDon.MaHD,NgayLap,sum(SL*DonGia) as TongTien
		from tbl_HoaDon join tbl_CTHD on tbl_HoaDon.MaHD = tbl_CTHD.MaHD
		where MONTH(NgayLap) = @month and YEAR(NgayLap) = @year
		group by tbl_HoaDon.MaHD,NgayLap
	end
sp_HoaDon_SelectTongTien_DayAndYear 1,2022

create proc sp_HoaDon_ThongKe_TongTien
	@tongtien int
as
	begin
		select tbl_HoaDon.MaHD,NgayLap,sum(SL*DonGia) as TongTien
		from tbl_HoaDon join tbl_CTHD on tbl_HoaDon.MaHD = tbl_CTHD.MaHD
		group by tbl_HoaDon.MaHD,NgayLap
		having sum(SL*DonGia) > @tongtien
	end
sp_HoaDon_ThongKe_TongTien 100

select * from tbl_Hang
create proc sp_Hang_AddHang
	@mh int,@th nvarchar(50),@sl int,@dg int,@nhsx nvarchar(50),@ngsx date
as
	begin
		insert into tbl_Hang (MaHang,TenHang,Sl,DonGia,NhaSX,NgaySX)
		values (@mh,@th,@sl,@dg,@nhsx,@ngsx)
	end
sp_Hang_AddHang 6,cc,12,12,CC,'2004/4/24'


--			CÓ TRẢ VỀ
alter proc sp_Hang_UpdateHang
	@mh int,@th nvarchar(50),@sl int,@dg int,@nhsx nvarchar(50),@ngsx date,@kq nvarchar(255) output		
as
	if (not exists ( select * from tbl_Hang where MaHang = @mh))
		set @kq = N'! Mã hàng tồn tại'
	else
	begin
		update tbl_Hang
		set TenHang = @th,Sl=@sl,DonGia=@dg,NhaSX=@nhsx,NgaySX=@ngsx
		where MaHang = @mh
		if @@ERROR <> 0
			set @kq = N'Lỗi cập nhật dữ liệu'
		else
			set @kq = N'Cập nhật thành công'
	end

declare @kq nvarchar(255)
execute sp_Hang_UpdateHang 100,cccc,12,132,CC,'2004/4/24',@kq output
select @kq as N'Kết quả'
select * from tbl_Hang


create proc sp_Hang_SelectHangBanDc_MonthAndYear
	@month int,@year int,@hbd int output
as
	begin
		select tbl_Hang.MaHang,TenHang,NgayLap,tbl_CTHD.sl as SoLuongBan
		from tbl_Hang join tbl_CTHD on tbl_Hang.MaHang=tbl_CTHD.MaHang
					  join tbl_HoaDon on tbl_CTHD.MaHD=tbl_HoaDon.MaHD
		where MONTH(NgayLap) = @month and YEAR(NgayLap) = @year

		set @hbd = @@ROWCOUNT
	end
declare @hbd int
execute sp_Hang_SelectHangBanDc_MonthAndYear 1,2022,@hbd output
select @hbd as SoHangDaBanDc
select * from tbl_HoaDon


create proc sp_HoaDon_ThongKeThang_Year
	@year int
as
	begin
		select MONTH(ngaylap) as thang, sum(SL*DonGia) as DoanhThu
		from tbl_HoaDon join tbl_CTHD on tbl_HoaDon.MaHD=tbl_CTHD.MaHD
		where YEAR(ngaylap) = @year
		group by MONTH(ngaylap)
	end

sp_HoaDon_ThongKeThang_Year 2022
select * from tbl_HoaDon