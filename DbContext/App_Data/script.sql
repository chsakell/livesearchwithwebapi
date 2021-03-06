USE [master]
GO
/****** Object:  Database [MovieStore]    Script Date: 9/7/2013 8:53:58 PM ******/
CREATE DATABASE [MovieStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MovieStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\MovieStore.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MovieStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\MovieStore_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MovieStore] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MovieStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MovieStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MovieStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MovieStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MovieStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MovieStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [MovieStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MovieStore] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MovieStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MovieStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MovieStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MovieStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MovieStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MovieStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MovieStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MovieStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MovieStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MovieStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MovieStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MovieStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MovieStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MovieStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MovieStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MovieStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MovieStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MovieStore] SET  MULTI_USER 
GO
ALTER DATABASE [MovieStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MovieStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MovieStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MovieStore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MovieStore', N'ON'
GO
USE [MovieStore]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 9/7/2013 8:53:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhotoAlbum]    Script Date: 9/7/2013 8:53:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhotoAlbum](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_PhotoAlbum] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Picture]    Script Date: 9/7/2013 8:53:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Picture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](300) NOT NULL,
	[ToolTip] [nvarchar](50) NOT NULL,
	[ImageUrl] [nvarchar](200) NOT NULL,
	[PhotoAlbumId] [int] NOT NULL,
 CONSTRAINT [PK_Picture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Review]    Script Date: 9/7/2013 8:53:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Summary] [nvarchar](200) NOT NULL,
	[Body] [nvarchar](max) NULL,
	[GenreId] [int] NOT NULL,
	[Authorized] [bit] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[UpdateDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[vWGetReviewsByGenre]    Script Date: 9/7/2013 8:53:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vWGetReviewsByGenre]
AS
select g.Name, r.Title, r.Summary
from Genre as g
join Review as r
on g.Id = r.GenreId
GO
SET IDENTITY_INSERT [dbo].[Genre] ON 

INSERT [dbo].[Genre] ([Id], [Name], [SortOrder]) VALUES (1, N'Action', 3)
INSERT [dbo].[Genre] ([Id], [Name], [SortOrder]) VALUES (2, N'Comedy', 5)
INSERT [dbo].[Genre] ([Id], [Name], [SortOrder]) VALUES (3, N'Fantasy', 1)
INSERT [dbo].[Genre] ([Id], [Name], [SortOrder]) VALUES (4, N'Drama', 2)
INSERT [dbo].[Genre] ([Id], [Name], [SortOrder]) VALUES (5, N'Sci-Fiction', 4)
INSERT [dbo].[Genre] ([Id], [Name], [SortOrder]) VALUES (6, N'Romance', 6)
INSERT [dbo].[Genre] ([Id], [Name], [SortOrder]) VALUES (7, N'Horror', 7)
INSERT [dbo].[Genre] ([Id], [Name], [SortOrder]) VALUES (8, N'Adventure', 9)
SET IDENTITY_INSERT [dbo].[Genre] OFF
SET IDENTITY_INSERT [dbo].[PhotoAlbum] ON 

INSERT [dbo].[PhotoAlbum] ([Id], [Name]) VALUES (1, N'Elysium')
INSERT [dbo].[PhotoAlbum] ([Id], [Name]) VALUES (2, N'The Hunger Games')
SET IDENTITY_INSERT [dbo].[PhotoAlbum] OFF
SET IDENTITY_INSERT [dbo].[Picture] ON 

INSERT [dbo].[Picture] ([Id], [Description], [ToolTip], [ImageUrl], [PhotoAlbumId]) VALUES (5, N'a man takes on a mission that could bring equality to the polarized worlds. ', N'Elysium', N'~/GigPics/3cb52838-3e31-41e3-965c-9500adb03599.jpg', 1)
INSERT [dbo].[Picture] ([Id], [Description], [ToolTip], [ImageUrl], [PhotoAlbumId]) VALUES (8, N'Katniss Everdeen', N'Hunger Games..', N'~/GigPics/31e028f7-e201-4ccf-a308-60ee6f948432.jpg', 2)
INSERT [dbo].[Picture] ([Id], [Description], [ToolTip], [ImageUrl], [PhotoAlbumId]) VALUES (9, N'Katniss Everdeen', N'Hunger Games..', N'~/GigPics/1d62f932-8244-4fad-b6ab-82ec4ca2c5f1.jpg', 2)
INSERT [dbo].[Picture] ([Id], [Description], [ToolTip], [ImageUrl], [PhotoAlbumId]) VALUES (10, N'Katniss Everdeen', N'Hunger Games..', N'~/GigPics/15888161-1f7f-495b-ba62-168490286790.jpg', 2)
INSERT [dbo].[Picture] ([Id], [Description], [ToolTip], [ImageUrl], [PhotoAlbumId]) VALUES (11, N'Katniss Everdeen', N'Hunger Games..', N'~/GigPics/9cfb29a8-e89f-4f9c-9656-75b0c4a3792f.jpg', 2)
INSERT [dbo].[Picture] ([Id], [Description], [ToolTip], [ImageUrl], [PhotoAlbumId]) VALUES (12, N'a man takes on a mission that could bring equality to the polarized worlds.', N'Elysium', N'~/GigPics/5cfe1458-d67e-45d4-9261-eef66ee9f229.jpg', 1)
SET IDENTITY_INSERT [dbo].[Picture] OFF
SET IDENTITY_INSERT [dbo].[Review] ON 

INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (1, N'Kick-Ass', N'The costumed high-school hero Kick-Ass joins with a group of normal citizens who have been inspired to fight crime in costume.', N'The costumed high-school hero Kick-Ass joins with a group of normal citizens who have been inspired to fight crime in costume. Meanwhile, the Red Mist plots an act of revenge that will affect everyone Kick-Ass knows.', 1, 1, CAST(0x0000A227016C6F3E AS DateTime), CAST(0x0000A229014769F5 AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (2, N'X-Men: Days of Future Past', N'The X-Men send Wolverine to the past to change a major historical event that could globally impact man and mutant kind.', N'The X-Men send Wolverine to the past to change a major historical event that could globally impact man and mutant kind.', 3, 1, CAST(0x0000A227016CD960 AS DateTime), CAST(0x0000A227016CD960 AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (3, N'The Amazing Spider-Man', N'Spider-Man squares off against the Rhino and the powerful Electro while struggling to keep his promise to leave Gwen Stacey out of his dangerous life.', N'Spider-Man squares off against the Rhino and the powerful Electro while struggling to keep his promise to leave Gwen Stacey out of his dangerous life.', 3, 1, CAST(0x0000A227016D05AE AS DateTime), CAST(0x0000A227016D05AE AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (5, N'Silver Linings Playbook', N'After a stint in a mental institution, former teacher Pat Solitano moves back in with his parents and tries to reconcile with his ex-wife.', N'After a stint in a mental institution, former teacher Pat Solitano moves back in with his parents and tries to reconcile with his ex-wife. Things get more challenging when Pat meets Tiffany, a mysterious girl with problems of her own.', 6, 1, CAST(0x0000A227016D956A AS DateTime), CAST(0x0000A227016D956A AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (6, N'The Lifeguard', N'A former valedictorian quits her reporter job in New York and returns to the place she last felt happy: her childhood home in Connecticut.', N'A former valedictorian quits her reporter job in New York and returns to the place she last felt happy: her childhood home in Connecticut. She gets work as a lifeguard and starts a dangerous relationship with a troubled teenager.', 6, 1, CAST(0x0000A227016DD4CD AS DateTime), CAST(0x0000A227016DD4CD AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (7, N'Wolverine', N'When Wolverine is summoned to Japan by an old acquaintance, he is embroiled in a conflict that forces him to confront his own demons.', N'When Wolverine is summoned to Japan by an old acquaintance, he is embroiled in a conflict that forces him to confront his own demons.', 5, 1, CAST(0x0000A227016E1C9F AS DateTime), CAST(0x0000A227016E1C9F AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (8, N'Iron Man', N'When Tony Stark''s world is torn apart by a formidable terrorist called the Mandarin, he starts an odyssey of rebuilding and retribution.', N'When Tony Stark''s world is torn apart by a formidable terrorist called the Mandarin, he starts an odyssey of rebuilding and retribution.', 5, 1, CAST(0x0000A227016E3A16 AS DateTime), CAST(0x0000A227016E3A16 AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (9, N'We''re the Millers', N'A veteran pot dealer creates a fake family as part of his plan to move a huge shipment of weed into the U.S. from Mexico.', N'A veteran pot dealer creates a fake family as part of his plan to move a huge shipment of weed into the U.S. from Mexico.', 2, 1, CAST(0x0000A227016E9AEA AS DateTime), CAST(0x0000A227016E9AEA AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (10, N'The Place Beyond the Pines', N'A motorcycle stunt rider turns to robbing banks as a way to provide for his lover and their newborn child', N'A motorcycle stunt rider turns to robbing banks as a way to provide for his lover and their newborn child, a decision that puts him on a collision course with an ambitious rookie cop navigating a department ruled by a corrupt detective.', 4, 1, CAST(0x0000A227016EF8EF AS DateTime), CAST(0x0000A227016EF8EF AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (12, N'The Hunger Games: Catching Fire', N'Katniss Everdeen and Peeta Mellark become targets of the Capitol after their victory in the 74th Hunger Games sparks a rebellion in the Districts of Panem.', N'Katniss Everdeen and Peeta Mellark become targets of the Capitol after their victory in the 74th Hunger Games sparks a rebellion in the Districts of Panem.', 8, 1, CAST(0x0000A22800C3460D AS DateTime), CAST(0x0000A22800000000 AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (13, N'The Lone Ranger', N'Native American warrior Tonto recounts the untold tales that transformed John Reid, a man of the law, into a legend of justice.', NULL, 8, 1, CAST(0x0000A22800CF897B AS DateTime), CAST(0x0000A22800CF895F AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (16, N'Olympus Has Fallen', N'Disgraced former Presidential guard Mike Banning finds himself trapped inside the White House in the wake of a terrorist attack', N'Disgraced former Presidential guard Mike Banning finds himself trapped inside the White House in the wake of a terrorist attack', 1, 1, CAST(0x0000A22901463994 AS DateTime), CAST(0x0000A22901817A81 AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (35, N'Percy Jackson: Sea of Monsters', N'In order to restore their dying safe haven, the son of Poseidon and his friends embark on a quest.', N'In order to restore their dying safe haven, the son of Poseidon and his friends embark on a quest to the Sea of Monsters to find the mythical Golden Fleece while trying to stop an ancient evil from rising.', 8, 1, CAST(0x0000A22901826194 AS DateTime), CAST(0x0000A22901826194 AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (36, N'Man of Steel', N'A young itinerant worker is forced to confront his secret extraterrestrial heritage when Earth is invaded by members of his race.', N'A young itinerant worker is forced to confront his secret extraterrestrial heritage when Earth is invaded by members of his race.', 5, 1, CAST(0x0000A22A0112F5EC AS DateTime), CAST(0x0000A22A0112F5EC AS DateTime))
INSERT [dbo].[Review] ([Id], [Title], [Summary], [Body], [GenreId], [Authorized], [CreateDateTime], [UpdateDateTime]) VALUES (1016, N'Titanic', N'A seventeen-year-old aristocrat, expecting to be married to a rich claimant by her mother, falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.', N'A seventeen-year-old aristocrat, expecting to be married to a rich claimant by her mother, falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.', 6, 1, CAST(0x0000A23201360985 AS DateTime), CAST(0x0000A23201360985 AS DateTime))
SET IDENTITY_INSERT [dbo].[Review] OFF
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_CreateDateTime]  DEFAULT (getdate()) FOR [CreateDateTime]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_UpdateDateTime]  DEFAULT (getdate()) FOR [UpdateDateTime]
GO
ALTER TABLE [dbo].[Picture]  WITH CHECK ADD  CONSTRAINT [FK_Picture_PhotoAlbum] FOREIGN KEY([PhotoAlbumId])
REFERENCES [dbo].[PhotoAlbum] ([Id])
GO
ALTER TABLE [dbo].[Picture] CHECK CONSTRAINT [FK_Picture_PhotoAlbum]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Genre] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genre] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Genre]
GO
USE [master]
GO
ALTER DATABASE [MovieStore] SET  READ_WRITE 
GO
