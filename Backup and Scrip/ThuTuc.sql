USE [BTHS3]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/2/2024 1:02:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[cID] [int] NOT NULL,
	[cName] [varchar](50) NULL,
	[cAge] [int] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[cID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Order]    Script Date: 10/2/2024 1:02:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[oID] [int] NOT NULL,
	[cID] [int] NULL,
	[oDate] [datetime] NULL,
	[oTotalPrice] [int] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[oID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 10/2/2024 1:02:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[oID] [int] NOT NULL,
	[pID] [int] NOT NULL,
	[odQTY] [int] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[oID] ASC,
	[pID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 10/2/2024 1:02:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[pID] [int] NOT NULL,
	[pName] [varchar](50) NULL,
	[pPrice] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[pID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customer] ([cID], [cName], [cAge]) VALUES (1, N'Minh Quan', 10)
INSERT [dbo].[Customer] ([cID], [cName], [cAge]) VALUES (2, N'Ngoc Oanh', 20)
INSERT [dbo].[Customer] ([cID], [cName], [cAge]) VALUES (3, N'Hong Ha', 50)
INSERT [dbo].[Order] ([oID], [cID], [oDate], [oTotalPrice]) VALUES (1, 1, CAST(N'2006-03-21 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Order] ([oID], [cID], [oDate], [oTotalPrice]) VALUES (2, 2, CAST(N'2006-03-23 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Order] ([oID], [cID], [oDate], [oTotalPrice]) VALUES (3, 1, CAST(N'2006-03-16 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[OrderDetail] ([oID], [pID], [odQTY]) VALUES (1, 1, 3)
INSERT [dbo].[OrderDetail] ([oID], [pID], [odQTY]) VALUES (1, 3, 7)
INSERT [dbo].[OrderDetail] ([oID], [pID], [odQTY]) VALUES (1, 4, 2)
INSERT [dbo].[OrderDetail] ([oID], [pID], [odQTY]) VALUES (2, 1, 1)
INSERT [dbo].[OrderDetail] ([oID], [pID], [odQTY]) VALUES (2, 3, 3)
INSERT [dbo].[OrderDetail] ([oID], [pID], [odQTY]) VALUES (2, 5, 4)
INSERT [dbo].[OrderDetail] ([oID], [pID], [odQTY]) VALUES (3, 1, 8)
INSERT [dbo].[Product] ([pID], [pName], [pPrice]) VALUES (1, N'May Giat', 3)
INSERT [dbo].[Product] ([pID], [pName], [pPrice]) VALUES (2, N'Tu Lanh', 5)
INSERT [dbo].[Product] ([pID], [pName], [pPrice]) VALUES (3, N'Dieu Hoa', 7)
INSERT [dbo].[Product] ([pID], [pName], [pPrice]) VALUES (4, N'Quat', 1)
INSERT [dbo].[Product] ([pID], [pName], [pPrice]) VALUES (5, N'Bep Dien', 2)
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([cID])
REFERENCES [dbo].[Customer] ([cID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([oID])
REFERENCES [dbo].[Order] ([oID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([pID])
REFERENCES [dbo].[Product] ([pID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
