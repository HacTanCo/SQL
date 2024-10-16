-- Hàm trả về 1 giá trị
alter function fc_KhachHang_ThongKe_SoLuongDenMuaHang()
returns int
as
	begin	
		return(select count(distinct MaKH)
			   from tbl_HoaDon
			   )
	end
select dbo.fc_KhachHang_ThongKe_SoLuongDenMuaHang() as SoLuong

alter function fc_CTHD_ThongKe_ThongKe_DoanhThu(@month int,@year int)
returns int
as
	begin
		return(
				select sum(SL*DonGia)
				from tbl_HoaDon join tbl_CTHD on tbl_HoaDon.MaHD=tbl_CTHD.MaHD
				where month(NgayLap) = @month and year(NgayLap) = @year
			  )
	end

select dbo.fc_CTHD_ThongKe_ThongKe_DoanhThu(2,2022) as Total
select dbo.fc_CTHD_ThongKe_ThongKe_DoanhThu(1,2022) as Total

alter function fc_Hang_Select_Top1banduoc(@month int,@year int)
returns nvarchar(50)
as
	begin
		return(
				select top 1 TenHang
				from tbl_Hang join tbl_CTHD on tbl_Hang.MaHang=tbl_CTHD.MaHang
							  join tbl_HoaDon on tbl_CTHD.MaHD=tbl_HoaDon.MaHD
				where month(NgayLap) = @month and year(NgayLap) = @year
				group by TenHang
				order by sum(tbl_CTHD.SL) desc
			  )
	end
select dbo.fc_Hang_Select_Top1banduoc(1,2022) as TenHang
select dbo.fc_Hang_Select_Top1banduoc(2,2022) as TenHang

-- Hàm trả về 1 bảng giá trị
create function fc_Hang_ThongKe_ChuaBanLanNao()
returns table
as
return(
		select tbl_Hang.*
		from tbl_Hang left join tbl_CTHD on tbl_Hang.MaHang=tbl_CTHD.MaHang
		where tbl_CTHD.MaHang is NULL

		/*select *
		from tbl_Hang
		where MaHang not in (select MaHang from tbl_CTHD)*/
		)
select * from dbo.fc_Hang_ThongKe_ChuaBanLanNao()

create function fc_CTHD_ThongKe_DoanhThuMonthInYear(@year int)
returns table
as
	return(
			select month(NgayLap) AS MONTH,sum(tbl_CTHD.Sl *tbl_CTHD.DonGia)  as Total
			from tbl_Hang join tbl_CTHD on tbl_Hang.MaHang=tbl_CTHD.MaHang
						  join tbl_HoaDon on tbl_CTHD.MaHD=tbl_HoaDon.MaHD
			where YEAR(NgayLap) = @year
			group by month(NgayLap)
		  )

select * from fc_CTHD_ThongKe_DoanhThuMonthInYear(2022)
          
alter function fc_KhachHang_ThongKe_KhachHangMuaBaoNhieuLan(@year int)
returns table
as
	return(
			select tbl_KhachHang.MaKH,TenKH,count(tbl_HoaDon.MaKH) as SoLanMuaHang
			from tbl_KhachHang left join tbl_HoaDon on tbl_KhachHang.MaKH=tbl_HoaDon.MaKH
			where year(NgayLap) = @year
			group by tbl_KhachHang.MaKH,TenKH
		  )
select * from dbo.fc_KhachHang_ThongKe_KhachHangMuaBaoNhieuLan(2022)

alter function fc_KhachHang_Select_Top1MuaHang(@year int)
returns table
as
	return(

			select *
			from dbo.fc_KhachHang_ThongKe_KhachHangMuaBaoNhieuLan(2022)
			where SoLanMuaHang =(select max(SoLanMuaHang) from dbo.fc_KhachHang_ThongKe_KhachHangMuaBaoNhieuLan(2022))

			/*select tbl_KhachHang.MaKH,TenKH,count(tbl_HoaDon.MaKH) as SoLanMuaHang
			from tbl_KhachHang left join tbl_HoaDon on tbl_KhachHang.MaKH=tbl_HoaDon.MaKH
			where year(NgayLap) = @year
			group by tbl_KhachHang.MaKH,TenKH
			having count(tbl_HoaDon.MaKH) >= all (
													select count(tbl_HoaDon.MaKH) as SoLanMuaHang
													from tbl_KhachHang left join tbl_HoaDon on tbl_KhachHang.MaKH=tbl_HoaDon.MaKH
													where year(NgayLap) = @year
													group by tbl_KhachHang.MaKH,TenKH
												 )*/
		  ) 
select * from dbo.fc_KhachHang_Select_Top1MuaHang(2022)

-- Hàm trả về bảng giá trị bằng nhiều câu lệnh 
create function fc_CTHD_ThongKe_DoanhThuMoiMonthInYear(@year int)
returns @Month table (Thang int,DoanhThu int)
as
	begin
		declare @Thang table(Thang int)
		declare @a int = 1
		while @a < 13
		begin
			insert into @Month
			values (@a)
			set @a += 1
		end
		insert into @Thang
		select t1.Thang,isnull(t2.Total,0) as Total
		from @Thang as t1 left join (
								select month(NgayLap) as Month,sum( SL*DonGia) as Total
								from tbl_HoaDon join tbl_CTHD on tbl_HoaDon.MaHD=tbl_CTHD.MaHD
								group by month(NgayLap)
							  ) as t2 on t1.Thang=t2.Month
		
		return

		
	end