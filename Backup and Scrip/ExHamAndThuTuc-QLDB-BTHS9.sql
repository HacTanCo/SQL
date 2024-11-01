USE [QLDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fc_CauThuAndThamGia_BanThangCua1CauThu]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_CauThuAndThamGia_BanThangCua1CauThu](@MaCT varchar(20))
returns int
as
	begin
		return(
				select sum(SoTrai)
				from ThamGia 
				where MaCT = @MaCT
			  )
	end
GO
/****** Object:  UserDefinedFunction [dbo].[fc_TranDau_HienThi_TrongTaiDaDieuKhienTrongNam]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_TranDau_HienThi_TrongTaiDaDieuKhienTrongNam](@Year int)
returns int
as
	begin
		return(
				select count(TrongTai)
				from TranDau
				where year(Ngay) = @Year
			  )
	end
GO
/****** Object:  UserDefinedFunction [dbo].[fc_TranDau_ThongKeMoiThangTrongNamCoBaoNhieuTran]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_TranDau_ThongKeMoiThangTrongNamCoBaoNhieuTran](@Year int)
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
GO
/****** Object:  Table [dbo].[CauThu]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CauThu](
	[MaCT] [varchar](20) NOT NULL,
	[TenCT] [nvarchar](50) NULL,
	[MaDB] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DoiBong]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoiBong](
	[MaDB] [int] NOT NULL,
	[TenDB] [nvarchar](50) NULL,
	[MaCLB] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThamGia]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ThamGia](
	[MaTD] [varchar](20) NOT NULL,
	[MaCT] [varchar](20) NOT NULL,
	[SoTrai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTD] ASC,
	[MaCT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TranDau]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TranDau](
	[MaTD] [varchar](20) NOT NULL,
	[TrongTai] [nvarchar](50) NULL,
	[SanDau] [nvarchar](30) NULL,
	[MaDB1] [int] NULL,
	[MaDB2] [int] NULL,
	[Ngay] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fc_CauThuAndThamGia_TongBanCuaMoiCauThu]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_CauThuAndThamGia_TongBanCuaMoiCauThu]()
returns table
as
	return(
			select CauThu.MaCT,TenCT,sum(SoTrai) as SoTrai
			from CauThu left join ThamGia on CauThu.MaCT=ThamGia.MaCT
			group by CauThu.MaCT,TenCT
		  )
GO
/****** Object:  UserDefinedFunction [dbo].[fc_CauThuAndThamGia_CauThuGhiBanNhieuNhat]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_CauThuAndThamGia_CauThuGhiBanNhieuNhat]()
returns table
as
	return(
			select MaCT,TenCT,SoTrai
			from dbo.fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
			where SoTrai = (select max(SoTrai) from fc_CauThuAndThamGia_TongBanCuaMoiCauThu())

		  )
GO
/****** Object:  UserDefinedFunction [dbo].[fc_CauThuAndThamGia_CacCauThuGhiNhieuHonSoBanA]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_CauThuAndThamGia_CacCauThuGhiNhieuHonSoBanA](@A int)
returns table
as
	return(
			select *
			from fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
			where SoTrai > @A
		  )
GO
/****** Object:  UserDefinedFunction [dbo].[fc_CauThu_HienThi_SameNameA]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fc_CauThu_HienThi_SameNameA](@A nvarchar(50))
returns table
as
	return(
			select *
			from CauThu
			where TenCT like '%' + @A + '%'
		  )
GO
/****** Object:  UserDefinedFunction [dbo].[fc_CauThuAndThamGia_HienThi_CacCauThuDaThiDauTrongTranDau]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_CauThuAndThamGia_HienThi_CacCauThuDaThiDauTrongTranDau](@matd varchar(20))
returns table
as
	return(
			select CauThu.MaCT,TenCT,MaDB
			from CauThu join ThamGia on CauThu.MaCT=ThamGia.MaCT
			where MaTD = @matd
		  )
GO
/****** Object:  UserDefinedFunction [dbo].[fc_TranDau_HienThi_TranDauDienRaVaoNgayA]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_TranDau_HienThi_TranDauDienRaVaoNgayA](@A datetime)
returns table
as
	return(
			select *
			from TranDau
			where Ngay = @A
			
		  )
GO
/****** Object:  UserDefinedFunction [dbo].[fc_TranDau_ThongKe_TrongTaiDieuKhienMayTran]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_TranDau_ThongKe_TrongTaiDieuKhienMayTran]()
returns table
as
	return(
			select MaTD,TrongTai,count(MaTD) as SoTran
			from TranDau 
			group by MaTD,TrongTai
		  )
GO
/****** Object:  UserDefinedFunction [dbo].[fc_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fc_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran](@A datetime,@B datetime)
returns table
as
	return(
			select TranDau.MaDB1,TenDB,count(MaTD) as SoTran
			from TranDau join DoiBong on TranDau.MaDB1=DoiBong.MaDB
			where Ngay between @A and @B 
			group by TranDau.MaDB1,TenDB
		  )
GO
INSERT [dbo].[CauThu] ([MaCT], [TenCT], [MaDB]) VALUES (N'CT01', N'Nguyễn Văn A', 1)
INSERT [dbo].[CauThu] ([MaCT], [TenCT], [MaDB]) VALUES (N'CT02', N'Lê Văn B', 1)
INSERT [dbo].[CauThu] ([MaCT], [TenCT], [MaDB]) VALUES (N'CT03', N'Trần Văn C', 2)
INSERT [dbo].[CauThu] ([MaCT], [TenCT], [MaDB]) VALUES (N'CT04', N'Phạm Văn D', 2)
INSERT [dbo].[CauThu] ([MaCT], [TenCT], [MaDB]) VALUES (N'CT05', N'Đỗ Văn E', 3)
INSERT [dbo].[CauThu] ([MaCT], [TenCT], [MaDB]) VALUES (N'CT06', N'Nguyễn Văn F', 4)
INSERT [dbo].[DoiBong] ([MaDB], [TenDB], [MaCLB]) VALUES (1, N'Hà Nội FC', 101)
INSERT [dbo].[DoiBong] ([MaDB], [TenDB], [MaCLB]) VALUES (2, N'Hoàng Anh Gia Lai', 102)
INSERT [dbo].[DoiBong] ([MaDB], [TenDB], [MaCLB]) VALUES (3, N'Sông Lam Nghệ An', 103)
INSERT [dbo].[DoiBong] ([MaDB], [TenDB], [MaCLB]) VALUES (4, N'Thành Phố Hồ Chí Minh', 104)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD01', N'CT01', 0)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD01', N'CT02', 2)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD01', N'CT03', 1)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD02', N'CT04', 1)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD02', N'CT05', 2)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD02', N'CT06', 1)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD03', N'CT01', 0)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD03', N'CT05', 2)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD04', N'CT03', 1)
INSERT [dbo].[ThamGia] ([MaTD], [MaCT], [SoTrai]) VALUES (N'TD04', N'CT06', 2)
INSERT [dbo].[TranDau] ([MaTD], [TrongTai], [SanDau], [MaDB1], [MaDB2], [Ngay]) VALUES (N'TD01', N'Trọng Tài A', N'Sân Mỹ Đình', 1, 2, CAST(N'2023-10-01 00:00:00.000' AS DateTime))
INSERT [dbo].[TranDau] ([MaTD], [TrongTai], [SanDau], [MaDB1], [MaDB2], [Ngay]) VALUES (N'TD02', N'Trọng Tài B', N'Sân Pleiku', 3, 4, CAST(N'2023-10-02 00:00:00.000' AS DateTime))
INSERT [dbo].[TranDau] ([MaTD], [TrongTai], [SanDau], [MaDB1], [MaDB2], [Ngay]) VALUES (N'TD03', N'Trọng Tài C', N'Sân Vinh', 1, 3, CAST(N'2023-10-03 00:00:00.000' AS DateTime))
INSERT [dbo].[TranDau] ([MaTD], [TrongTai], [SanDau], [MaDB1], [MaDB2], [Ngay]) VALUES (N'TD04', N'Trọng Tài D', N'Sân Thống Nhất', 2, 4, CAST(N'2023-10-04 00:00:00.000' AS DateTime))
ALTER TABLE [dbo].[CauThu]  WITH CHECK ADD FOREIGN KEY([MaDB])
REFERENCES [dbo].[DoiBong] ([MaDB])
GO
ALTER TABLE [dbo].[ThamGia]  WITH CHECK ADD FOREIGN KEY([MaCT])
REFERENCES [dbo].[CauThu] ([MaCT])
GO
ALTER TABLE [dbo].[ThamGia]  WITH CHECK ADD FOREIGN KEY([MaTD])
REFERENCES [dbo].[TranDau] ([MaTD])
GO
ALTER TABLE [dbo].[TranDau]  WITH CHECK ADD FOREIGN KEY([MaDB1])
REFERENCES [dbo].[DoiBong] ([MaDB])
GO
ALTER TABLE [dbo].[TranDau]  WITH CHECK ADD FOREIGN KEY([MaDB2])
REFERENCES [dbo].[DoiBong] ([MaDB])
GO
/****** Object:  StoredProcedure [dbo].[sp_CauThu_HienThi_SameNameA]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_CauThu_HienThi_SameNameA](@A nvarchar(50))
as
	begin
		select *
		from CauThu
		where TenCT like N'%' + @A + N'%'
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_CauThu_Update]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_CauThu_Update](@MaCT varchar(20),@TenCT nvarchar(50),@MaDB int,@kq nvarchar(255) output)
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
GO
/****** Object:  StoredProcedure [dbo].[sp_CauThuAndThamGia_CacCauThuGhiNhieuHonSoBanA]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_CauThuAndThamGia_CacCauThuGhiNhieuHonSoBanA](@A int)
as
	begin
		select *
		from fc_CauThuAndThamGia_TongBanCuaMoiCauThu()
		where SoTrai > @A
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_CauThuAndThamGia_CauThuGhiBanNhieuNhat]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_CauThuAndThamGia_CauThuGhiBanNhieuNhat]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_CauThuAndThamGia_Delete]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_CauThuAndThamGia_Delete](@MaCT varchar(20),@kq nvarchar(255) output)
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
GO
/****** Object:  StoredProcedure [dbo].[sp_CauThuAndThamGiaAndTranDau_HienThi_CacCauThuDaThiDauTrongTranDau]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_CauThuAndThamGiaAndTranDau_HienThi_CacCauThuDaThiDauTrongTranDau](@matd varchar(20))
as
	begin
		select CauThu.MaCT,TenCT,MaDB
		from CauThu join ThamGia on CauThu.MaCT=ThamGia.MaCT
		where MaTD = @matd
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateTable_CauThu_BanThang]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_CreateTable_CauThu_BanThang]
as
	begin
		declare @CauThu_BanThang table (MaCT varchar(20),TenCT nvarchar(50),SoTrai int)
		
		insert into @CauThu_BanThang
		select *
		from fc_CauThuAndThamGia_TongBanCuaMoiCauThu()

		select * from @CauThu_BanThang
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_TranDau_HienThi_TranDauDienRaVaoNgayA]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_TranDau_HienThi_TranDauDienRaVaoNgayA](@A datetime)
as
	begin
		select *
		from TranDau
		where Ngay = @A
		order by MaTD,SanDau desc
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_TranDau_ThongKe_TrongTaiDieuKhienMayTran]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_TranDau_ThongKe_TrongTaiDieuKhienMayTran]
as
	begin
		select MaTD,TrongTai,count(MaTD) as SoTran
		from TranDau 
		group by MaTD,TrongTai
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_TranDau_ThongKe_TuAdenBDoiNhaDaMayTran](@A datetime,@B datetime)
	
as
	begin
		select TranDau.MaDB1,TenDB,count(MaTD) as SoTran
		from TranDau join DoiBong on TranDau.MaDB1=DoiBong.MaDB
		where Ngay between @A and @B 
		group by TranDau.MaDB1,TenDB
	end
GO
/****** Object:  StoredProcedure [dbo].[sp_TranDau_ThongKeMoiThangTrongNamCoBaoNhieuTran]    Script Date: 10/29/2024 10:34:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_TranDau_ThongKeMoiThangTrongNamCoBaoNhieuTran](@Year int)
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
GO
