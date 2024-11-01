USE [BTHS4]
GO
/****** Object:  Table [dbo].[classes]    Script Date: 10/21/2024 10:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classes](
	[classid] [int] NOT NULL,
	[classname] [nvarchar](50) NULL,
 CONSTRAINT [PK_classes] PRIMARY KEY CLUSTERED 
(
	[classid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[classtudent]    Script Date: 10/21/2024 10:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classtudent](
	[studentid] [int] NULL,
	[classid] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Marks]    Script Date: 10/21/2024 10:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marks](
	[mark] [int] NULL,
	[subjectid] [int] NULL,
	[studentid] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[students]    Script Date: 10/21/2024 10:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students](
	[studentid] [int] NOT NULL,
	[studentname] [nvarchar](50) NULL,
	[age] [int] NULL,
	[email] [nvarchar](100) NULL,
 CONSTRAINT [PK_students] PRIMARY KEY CLUSTERED 
(
	[studentid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[subjects]    Script Date: 10/21/2024 10:23:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subjects](
	[subjectid] [int] NOT NULL,
	[subjectname] [nvarchar](50) NULL,
 CONSTRAINT [PK_subjects] PRIMARY KEY CLUSTERED 
(
	[subjectid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[classes] ([classid], [classname]) VALUES (1, N'C0706L')
INSERT [dbo].[classes] ([classid], [classname]) VALUES (2, N'C0708G')
INSERT [dbo].[classtudent] ([studentid], [classid]) VALUES (1, 1)
INSERT [dbo].[classtudent] ([studentid], [classid]) VALUES (2, 1)
INSERT [dbo].[classtudent] ([studentid], [classid]) VALUES (3, 1)
INSERT [dbo].[classtudent] ([studentid], [classid]) VALUES (4, 2)
INSERT [dbo].[classtudent] ([studentid], [classid]) VALUES (5, 2)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (8, 1, 1)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (4, 2, 1)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (9, 1, 1)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (7, 1, 3)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (3, 1, 4)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (5, 2, 5)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (8, 3, 3)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (1, 3, 5)
INSERT [dbo].[Marks] ([mark], [subjectid], [studentid]) VALUES (3, 2, 4)
INSERT [dbo].[students] ([studentid], [studentname], [age], [email]) VALUES (1, N'Nguyen Quang An', 18, N'an@yahoo.com')
INSERT [dbo].[students] ([studentid], [studentname], [age], [email]) VALUES (2, N'Nguyen Cong Vinh', 20, N'vinh@gmail.com')
INSERT [dbo].[students] ([studentid], [studentname], [age], [email]) VALUES (3, N'Nguyen Van Quyen', 19, N'quyen')
INSERT [dbo].[students] ([studentid], [studentname], [age], [email]) VALUES (4, N'Pham Thanh Binh', 25, N'binh@com')
INSERT [dbo].[students] ([studentid], [studentname], [age], [email]) VALUES (5, N'Nguyen Van Tai Em', 30, N'taiem@sport.vn')
INSERT [dbo].[subjects] ([subjectid], [subjectname]) VALUES (1, N'SQL')
INSERT [dbo].[subjects] ([subjectid], [subjectname]) VALUES (2, N'Java')
INSERT [dbo].[subjects] ([subjectid], [subjectname]) VALUES (3, N'C')
INSERT [dbo].[subjects] ([subjectid], [subjectname]) VALUES (4, N'Visual Basic')
ALTER TABLE [dbo].[classtudent]  WITH CHECK ADD  CONSTRAINT [FK_classtudent_classes] FOREIGN KEY([classid])
REFERENCES [dbo].[classes] ([classid])
GO
ALTER TABLE [dbo].[classtudent] CHECK CONSTRAINT [FK_classtudent_classes]
GO
ALTER TABLE [dbo].[classtudent]  WITH CHECK ADD  CONSTRAINT [FK_classtudent_students] FOREIGN KEY([studentid])
REFERENCES [dbo].[students] ([studentid])
GO
ALTER TABLE [dbo].[classtudent] CHECK CONSTRAINT [FK_classtudent_students]
GO
ALTER TABLE [dbo].[Marks]  WITH CHECK ADD  CONSTRAINT [FK_Marks_students] FOREIGN KEY([studentid])
REFERENCES [dbo].[students] ([studentid])
GO
ALTER TABLE [dbo].[Marks] CHECK CONSTRAINT [FK_Marks_students]
GO
ALTER TABLE [dbo].[Marks]  WITH CHECK ADD  CONSTRAINT [FK_Marks_subjects] FOREIGN KEY([subjectid])
REFERENCES [dbo].[subjects] ([subjectid])
GO
ALTER TABLE [dbo].[Marks] CHECK CONSTRAINT [FK_Marks_subjects]
GO
