USE [QuanLyThuVien]
GO
/****** Object:  Table [dbo].[DocGia]    Script Date: 9/16/2024 9:34:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocGia](
	[sothe] [char](10) NOT NULL,
	[hoten] [nvarchar](50) NULL,
	[diachi] [nvarchar](50) NULL,
	[dienthoai] [char](10) NULL,
 CONSTRAINT [PK_DocGia_1] PRIMARY KEY CLUSTERED 
(
	[sothe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Muon]    Script Date: 9/16/2024 9:34:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Muon](
	[sothe] [char](10) NOT NULL,
	[masach] [char](10) NOT NULL,
	[ngaymuon] [date] NOT NULL,
	[ngaytra] [date] NULL,
 CONSTRAINT [PK_DocGia] PRIMARY KEY CLUSTERED 
(
	[sothe] ASC,
	[masach] ASC,
	[ngaymuon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhaXuatBan]    Script Date: 9/16/2024 9:34:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhaXuatBan](
	[manhaxb] [char](10) NOT NULL,
	[tennhaxb] [nvarchar](50) NULL,
	[diachi] [nvarchar](50) NULL,
	[dienthoai] [char](10) NULL,
 CONSTRAINT [PK_NhaXuatBan] PRIMARY KEY CLUSTERED 
(
	[manhaxb] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sach]    Script Date: 9/16/2024 9:34:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sach](
	[masach] [char](10) NOT NULL,
	[tensach] [nvarchar](50) NULL,
	[manhaxb] [char](10) NULL,
 CONSTRAINT [PK_Sach] PRIMARY KEY CLUSTERED 
(
	[masach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SangTac]    Script Date: 9/16/2024 9:34:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SangTac](
	[masach] [char](10) NOT NULL,
	[matg] [char](10) NOT NULL,
 CONSTRAINT [PK_SangTac] PRIMARY KEY CLUSTERED 
(
	[masach] ASC,
	[matg] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TacGia]    Script Date: 9/16/2024 9:34:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TacGia](
	[matg] [char](10) NOT NULL,
	[tentg] [nvarchar](50) NULL,
	[namsinh] [date] NULL,
	[gioitinh] [bit] NULL,
 CONSTRAINT [PK_TacGia] PRIMARY KEY CLUSTERED 
(
	[matg] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[DocGia] ([sothe], [hoten], [diachi], [dienthoai]) VALUES (N'TTV001    ', N'Bùi Xuân Trường', N'Hà Nội', NULL)
INSERT [dbo].[DocGia] ([sothe], [hoten], [diachi], [dienthoai]) VALUES (N'TTV002    ', N'Nguyễn Quang Trung', N'Hồ Chí Minh', NULL)
INSERT [dbo].[DocGia] ([sothe], [hoten], [diachi], [dienthoai]) VALUES (N'TTV003    ', N'Nguyễn Thị Hội', N'Huế', NULL)
INSERT [dbo].[DocGia] ([sothe], [hoten], [diachi], [dienthoai]) VALUES (N'TTV004    ', N'Phan Đa Phúc', N'Hà Nội', NULL)
INSERT [dbo].[DocGia] ([sothe], [hoten], [diachi], [dienthoai]) VALUES (N'TTV005    ', N'Hàn Minh Phương', N'Đà Nẵng', NULL)
INSERT [dbo].[Muon] ([sothe], [masach], [ngaymuon], [ngaytra]) VALUES (N'TTV001    ', N'KH001     ', CAST(N'2008-05-04' AS Date), NULL)
INSERT [dbo].[Muon] ([sothe], [masach], [ngaymuon], [ngaytra]) VALUES (N'TTV002    ', N'KH001     ', CAST(N'2008-04-03' AS Date), NULL)
INSERT [dbo].[Muon] ([sothe], [masach], [ngaymuon], [ngaytra]) VALUES (N'TTV003    ', N'KH002     ', CAST(N'2008-05-05' AS Date), CAST(N'2008-07-05' AS Date))
INSERT [dbo].[Muon] ([sothe], [masach], [ngaymuon], [ngaytra]) VALUES (N'TTV004    ', N'KH001     ', CAST(N'2008-05-04' AS Date), NULL)
INSERT [dbo].[NhaXuatBan] ([manhaxb], [tennhaxb], [diachi], [dienthoai]) VALUES (N'XB001     ', N'Lao động', N'Hà Nội', NULL)
INSERT [dbo].[NhaXuatBan] ([manhaxb], [tennhaxb], [diachi], [dienthoai]) VALUES (N'XB002     ', N'Thanh niên', N'Hà Nội', NULL)
INSERT [dbo].[NhaXuatBan] ([manhaxb], [tennhaxb], [diachi], [dienthoai]) VALUES (N'XB003     ', N'Phụ nữ', N'Hồ Chí Minh', NULL)
INSERT [dbo].[Sach] ([masach], [tensach], [manhaxb]) VALUES (N'GT001     ', N'Giáo trình mạng', N'XB002     ')
INSERT [dbo].[Sach] ([masach], [tensach], [manhaxb]) VALUES (N'KH001     ', N'Thế giới quanh ta', N'XB003     ')
INSERT [dbo].[Sach] ([masach], [tensach], [manhaxb]) VALUES (N'KH002     ', N'101 Câu hỏi tại sao', N'XB001     ')
INSERT [dbo].[Sach] ([masach], [tensach], [manhaxb]) VALUES (N'KH003     ', N'Thế giới các vì sao', N'XB001     ')
INSERT [dbo].[SangTac] ([masach], [matg]) VALUES (N'GT001     ', N'TG002     ')
INSERT [dbo].[SangTac] ([masach], [matg]) VALUES (N'KH001     ', N'TG001     ')
INSERT [dbo].[SangTac] ([masach], [matg]) VALUES (N'KH002     ', N'TG001     ')
INSERT [dbo].[TacGia] ([matg], [tentg], [namsinh], [gioitinh]) VALUES (N'TG001     ', N'Trần Duy Nghĩa', CAST(N'1950-01-01' AS Date), 1)
INSERT [dbo].[TacGia] ([matg], [tentg], [namsinh], [gioitinh]) VALUES (N'TG002     ', N'Phan Ngọc Diệp', CAST(N'1949-01-02' AS Date), 0)
INSERT [dbo].[TacGia] ([matg], [tentg], [namsinh], [gioitinh]) VALUES (N'TG003     ', N'Nguyễn Xuân Huy', CAST(N'1984-05-05' AS Date), 1)
INSERT [dbo].[TacGia] ([matg], [tentg], [namsinh], [gioitinh]) VALUES (N'TG004     ', N'Phạm Thị Hiền', CAST(N'1980-08-02' AS Date), 0)
ALTER TABLE [dbo].[Muon]  WITH CHECK ADD  CONSTRAINT [FK_Muon_DocGia] FOREIGN KEY([sothe])
REFERENCES [dbo].[DocGia] ([sothe])
GO
ALTER TABLE [dbo].[Muon] CHECK CONSTRAINT [FK_Muon_DocGia]
GO
ALTER TABLE [dbo].[Muon]  WITH CHECK ADD  CONSTRAINT [FK_Muon_Sach] FOREIGN KEY([masach])
REFERENCES [dbo].[Sach] ([masach])
GO
ALTER TABLE [dbo].[Muon] CHECK CONSTRAINT [FK_Muon_Sach]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [FK_Sach_NhaXuatBan] FOREIGN KEY([manhaxb])
REFERENCES [dbo].[NhaXuatBan] ([manhaxb])
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [FK_Sach_NhaXuatBan]
GO
ALTER TABLE [dbo].[SangTac]  WITH CHECK ADD  CONSTRAINT [FK_SangTac_Sach] FOREIGN KEY([masach])
REFERENCES [dbo].[Sach] ([masach])
GO
ALTER TABLE [dbo].[SangTac] CHECK CONSTRAINT [FK_SangTac_Sach]
GO
ALTER TABLE [dbo].[SangTac]  WITH CHECK ADD  CONSTRAINT [FK_SangTac_TacGia] FOREIGN KEY([matg])
REFERENCES [dbo].[TacGia] ([matg])
GO
ALTER TABLE [dbo].[SangTac] CHECK CONSTRAINT [FK_SangTac_TacGia]
GO
