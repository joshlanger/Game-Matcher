/****** Object:  Database [GameMatcherNew]    Script Date: 8/26/2019 7:50:17 AM ******/
USE master;
GO

--IF EXISTS(select * from sys.databases where name='GameMatcherNew')
--DROP DATABASE GameMatcherNew;
--GO

CREATE DATABASE GameMatcherNew;
GO
USE GameMatcherNew;
GO
ALTER DATABASE [GameMatcherNew] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GameMatcherNew] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GameMatcherNew] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GameMatcherNew] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GameMatcherNew] SET ARITHABORT OFF 
GO
ALTER DATABASE [GameMatcherNew] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GameMatcherNew] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GameMatcherNew] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GameMatcherNew] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GameMatcherNew] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GameMatcherNew] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GameMatcherNew] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GameMatcherNew] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GameMatcherNew] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [GameMatcherNew] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GameMatcherNew] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [GameMatcherNew] SET  MULTI_USER 
GO
ALTER DATABASE [GameMatcherNew] SET QUERY_STORE = ON
GO
ALTER DATABASE [GameMatcherNew] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 8/26/2019 7:50:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[board_game]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[board_game](
	[games_id] [int] NOT NULL,
	[name] [varchar](50) NULL,
	[num_players] [int] NULL,
	[image] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[friends_list]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[friends_list](
	[friends_list_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[profile_id] [int] NOT NULL,
 CONSTRAINT [PK_friends_list] PRIMARY KEY CLUSTERED 
(
	[friends_list_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[game_library]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[game_library](
	[games_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NULL,
	[style] [varchar](50) NULL,
	[min_players] [int] NULL,
	[max_players] [int] NULL,
	[genre] [varchar](50) NULL,
	[platform] [varchar](50) NULL,
	[image] [varchar](50) NULL,
 CONSTRAINT [PK_game_library] PRIMARY KEY CLUSTERED 
(
	[games_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[genre_library]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[genre_library](
	[genre_id] [int] IDENTITY(1,1) NOT NULL,
	[genre] [varchar](50) NULL,
 CONSTRAINT [PK_genre_library] PRIMARY KEY CLUSTERED 
(
	[genre_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile](
	[profile_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[user_name] [varchar](50) NOT NULL,
	[avatar_name] [varchar](50) NULL,
	[user_bio] [varchar](250) NULL,
	[gaming_experience] [varchar](50) NULL,
	[contact_preference] [varchar](50) NULL,
	[other_interests] [varchar](140) NULL,
	[is_Private] [bit] NOT NULL,
 CONSTRAINT [pk_profile] PRIMARY KEY CLUSTERED 
(
	[profile_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile_game]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile_game](
	[games_id] [int] NOT NULL,
	[profile_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile_genre]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile_genre](
	[profile_genre_id] [int] IDENTITY(1,1) NOT NULL,
	[genre_id] [int] NOT NULL,
	[profile_id] [int] NOT NULL,
 CONSTRAINT [PK_profile_genre] PRIMARY KEY CLUSTERED 
(
	[profile_genre_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rpg]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpg](
	[games_id] [int] NOT NULL,
	[name] [varchar](50) NULL,
	[num_players] [varchar](50) NULL,
	[image] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[salt] [varchar](50) NOT NULL,
	[role] [varchar](50) NULL,
	[zipcode] [varchar](10) NOT NULL,
 CONSTRAINT [pk_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[video_game]    Script Date: 8/26/2019 7:50:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[video_game](
	[games_id] [int] NOT NULL,
	[name] [varchar](50) NULL,
	[num_player] [int] NULL,
	[genre] [varchar](50) NULL,
	[platform] [varchar](50) NULL,
	[image] [varchar](50) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[game_library] ON 

INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (117, N'Destiny 2', N'Video Game', 1, NULL, N'FPS', N'PC, Xbox, PS4', N'pic3926575.png')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (118, N'EVE Online', N'Video Game', 1, NULL, N'MMO', N'PC', N'pic781124.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (119, N'Borderlands 2', N'Video Game', 1, 4, N'FPS', N'PC, Xbox, PS4', N'pic3785086.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (120, N'The Last of Us', N'Video Game', 1, NULL, N'FPS', N'PS4', N'pic1694953.png')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (121, N'World of Warcraft', N'Video Game', 1, NULL, N'MMO', N'PC', N'pic737171.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (122, N'Halo Wars', N'Video Game', 1, NULL, N'FPS', N'Xbox', N'pic3442421.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (123, N'Red Dead Redemption 2', N'Video Game', 1, NULL, N'Shooter', N'PC, Xbox, PS4', N'pic4607932.png')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (124, N'Rocket League', N'Video Game', 1, NULL, N'Sports', N'PC, Xbox, PS4', N'pic2742512.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (125, N'Fortnite', N'Video Game', 1, NULL, N'Battle Royale', N'PC, Xbox, PS4', N'pic4001933.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (126, N'Elite Dangerous', N'Video Game', 1, NULL, N'Simulation', N'PC, Xbox, PS4', N'pic3950844.png')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (127, N'Gloomhaven', N'Board Game', 1, 4, N'Strategy', NULL, N'pic2437871.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (128, N'Splendor', N'Board Game', 2, 4, N'Family', NULL, N'pic1904079.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (129, N'SuperFight', N'Board Game', 2, 10, N'Party', NULL, N'pic2429251.png')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (130, N'Dixit', N'Board Game', 3, 6, N'Party', NULL, N'pic3483909.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (131, N'Telestrations', N'Board Game', 4, 8, N'Party', NULL, N'pic2523100.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (132, N'Settlers of Catan', N'Board Game', 3, 6, N'Strategy', NULL, N'pic1248578.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (133, N'Balderdash', N'Board Game', 2, 6, N'Party', NULL, N'pic3364.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (134, N'One Night Ultimate Werewolf', N'Board Game', 3, 10, N'Party', NULL, N'pic1809823.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (135, N'Two Rooms and a Boom', N'Board Game', 6, 30, N'Party', NULL, N'pic2335221.png')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (136, N'Secret Hitler', N'Board Game', 5, 10, N'Party', NULL, N'pic2771488.png')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (137, N'Dungeons & Dragons', N'RPG', NULL, NULL, N'Fantasy', NULL, N'pic544181.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (138, N'Cyberpunk 2020', N'RPG', NULL, NULL, N'Sci-Fi', NULL, N'pic512457.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (139, N'Pathfinder', N'RPG', NULL, NULL, N'Fantasy', NULL, N'pic4878066.png')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (140, N'Warhammer', N'RPG', NULL, NULL, N'Fantasy', NULL, N'pic3868044.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (141, N'Star Wars the RPG', N'RPG', NULL, NULL, N'Sci-Fi', NULL, N'pic2494591.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (142, N'Blood!', N'RPG', NULL, NULL, N'Horror', NULL, N'pic894290.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (143, N'Shadows of Cthulhu', N'RPG', NULL, NULL, N'Horror', NULL, N'pic902584.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (144, N'Star Frontiers', N'RPG', NULL, NULL, N'Sci-Fi', NULL, N'pic2206252.jpg')
INSERT [dbo].[game_library] ([games_id], [title], [style], [min_players], [max_players], [genre], [platform], [image]) VALUES (145, N'Marvel Superheroes', N'RPG', NULL, NULL, N'Comic Book', NULL, N'pic563202.jpg')
SET IDENTITY_INSERT [dbo].[game_library] OFF
SET IDENTITY_INSERT [dbo].[genre_library] ON 

INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (1, N'MOBA')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (2, N'FPS')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (3, N'MMO')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (4, N'Strategy')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (5, N'Battle Royale')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (6, N'Puzzle')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (7, N'Simulation')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (8, N'Family')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (9, N'Party')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (10, N'Fantasy')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (11, N'Sci-Fi')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (12, N'Horror')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (13, N'Comic Book')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (14, N'Farming')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (15, N'Card')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (16, N'Platformer')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (17, N'CCG')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (18, N'Action')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (19, N'RPG')
INSERT [dbo].[genre_library] ([genre_id], [genre]) VALUES (20, N'JRPG')
SET IDENTITY_INSERT [dbo].[genre_library] OFF
SET IDENTITY_INSERT [dbo].[profile] ON 

INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (1, 1, N'reverend_G', N'0.jpg', N'I am just a happy gamer', N'Novice', N'email', N'coding', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (2, 2, N'LeoSlayer', N'0.jpg', N'I am just a happy gamer', N'Novice', N'email', N'coding', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (3, 3, N'General_Boy', N'0.jpg', N'I am just a happy gamer', N'Novice', N'email', N'coding', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (4, 4, N'Pony_Elvis', N'0.jpg', N'I am just a happy gamer', N'Novice', N'email', N'coding', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (5, 5, N'phoenixx420', N'0.jpg', N'I am just a happy gamer', N'Novice', N'email', N'coding', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (6, 6, N'IvoryUnclerico', N'0.jpg', N'I am just a happy gamer', N'Novice', N'email', N'coding', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (7, 7, N'Dragonhelm', N'0.jpg', N'Hello World! I Love to gaming!!!', N'Expert', N'email', N'spelunking', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (8, 8, N'BeattleJuice', N'0.jpg', N'I am just a happy gamer', N'Novice', N'email', N'coding', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (11, 9, N'yo_mama', N'', N'I am just a happy gamer', N'Novice', N'email', N'coding', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (21, 10, N'dekubee', N'0.jpg', N'It''s me', N'Novice', N'email', N'Donuts', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (22, 15, N'sailormoon92', N'', N'', N'', N'', N'', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (23, 16, N'yabai31', N'', N'', N'', N'', N'', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (24, 17, N'aintnosunshine', N'', N'', N'', N'', N'', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (25, 18, N'ruthless1279', N'0.jpg', N'i have been gaming since i was a young lad. it is my passion, my muse, my joie de vivre. looking for someone who loves to play WoW!', N'Expert', N'message me on whatsapp: weallFloatOn40', N'living my best life, singing, record shops', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (26, 19, N'boojiboy', N'0.jpg', N'Just a spudboy', N'Expert', N'please do not', N'beautiful mutants', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (27, 20, N'FizzBuzz', N'0.jpg', N'Buzzin and Fizzin', N'Intermediate', N'Gimme a buzz (no fizz)', N'Retro gaming, vaping, clown history', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (28, 21, N'NeoAnderson', N'0.jpg', N'All around hoopy frood', N'Expert', N'WOOF', N'Golf, Python references', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (29, 22, N'PsychoZajko', N'0.jpg', N'I am an amature pet groomer', N'Intermediate', N'Ryver', N'Hardcore rap', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (30, 23, N'MedvitzTheEviscerator', N'0.jpg', N'Karaoke enthusiast', N'Expert', N'Mid lecture applause breaks', N'sarcasm', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (31, 24, N'20000_BC', N'0.jpg', N'Smarter than you', N'Intermediate', N'echoing laugh', N'eye rolling', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (32, 25, N'HEYWILMERIMHOME', N'0.jpg', N'My user name is a pun', N'Expert', N'I will find you', N'puns', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (33, 26, N'SquirrelPartyOrganizer', N'0.jpg', N'Ask about my recipe for pasta fibonacci', N'Intermediate', N'Fill out a form', N'Squirrels, parties, cigars', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (34, 27, N'threebeans', N'0.jpg', N'smeg', N'Expert', N'email', N'40''s', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (35, 28, N'bidlo_kwerve', N'', N'', N'', N'', N'', 1)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (36, 29, N'C4su4l_Gmr', N'', N'', N'', N'', N'', 1)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (37, 30, N'bears38', N'0.jpg', N'i drink 40''s', N'Intermediate', N'email', N'slaying', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (38, 31, N'bumblebee', N'0.jpg', N'i like to play games!', N'Intermediate', N'find me on steam: bee227', N'running and arcades!', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (39, 32, N'gamersupreme', N'0.jpg', N'hkj', N'Expert', N'email', N'whiskey', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (40, 33, N'redirksen', N'0.jpg', N'I like games', N'Intermediate', N'phone', N'sleeping', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (41, 34, N'Lockedown02', N'0.jpg', N'All CSS is terrible', N'Expert', N'Lockedown02', N'Performing music, playing soccer', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (42, 35, N'casual-gamer', N'0', N'', N'', N'', N'', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (43, 36, N'CMKULIK', N'0.jpg', N'I''m a casual gamer', N'Novice', N'email', N'eating', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (44, 37, N'hotshot21', N'0.jpg', N'i''m an amazingly drunk sister', N'Intermediate', N'email', N'sleeping', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (45, 38, N'gamer21', N'0.jpg', N'gaming since the 70''s', N'Expert', N'email', N'sleeping', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (46, 39, N'soup555', N'0.jpg', N'i love chess', N'Novice', N'email', N'eating', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (47, 40, N'paul420', N'0.jpg', N'i smoke blunts', N'Intermediate', N'email', N'growing ganja', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (48, 41, N'jcr23@gmail.com', N'0.jpg', N'i like sports, beach, beers, travel', N'Intermediate', N'email', N'sports', 0)
INSERT [dbo].[profile] ([profile_id], [user_id], [user_name], [avatar_name], [user_bio], [gaming_experience], [contact_preference], [other_interests], [is_Private]) VALUES (49, 42, N'theMANofTHEhour', N'0.jpg', N'i like computers', N'Novice', N'phone', N'phones', 0)
SET IDENTITY_INSERT [dbo].[profile] OFF
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 1)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 2)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 3)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 7)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 21)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 25)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 28)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 31)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (117, 32)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (118, 4)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (118, 5)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (118, 7)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (118, 21)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (118, 26)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (118, 29)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (118, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (119, 3)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (119, 4)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (119, 21)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (119, 26)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (119, 30)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (119, 34)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (119, 41)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (120, 7)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (120, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (120, 34)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (121, 25)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (121, 32)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (121, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (121, 44)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (121, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (122, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (123, 5)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (123, 48)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (124, 3)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (124, 4)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (124, 27)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (124, 41)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (124, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (125, 27)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (125, 28)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (125, 29)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (125, 31)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (125, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (125, 44)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (125, 47)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (126, 25)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (127, 25)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (127, 27)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (127, 29)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (127, 30)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (127, 31)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (127, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (127, 40)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (128, 1)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (128, 30)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (128, 43)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (128, 44)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (128, 47)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (129, 32)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (129, 43)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (129, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (130, 4)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (130, 29)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (131, 4)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (131, 30)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (131, 43)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (131, 46)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (131, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (132, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (132, 46)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (133, 1)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (133, 2)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (133, 26)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (133, 43)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (133, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (133, 46)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (134, 25)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (134, 28)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (134, 29)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (135, 5)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (135, 25)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (135, 27)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (135, 29)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (135, 30)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (135, 32)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (135, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (135, 40)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (136, 25)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (136, 26)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (136, 40)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 1)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 5)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 28)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 30)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 41)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 43)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 47)
GO
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 48)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (137, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (138, 27)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (138, 31)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (138, 32)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (138, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (139, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (139, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (139, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (140, 3)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (140, 26)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (140, 29)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (140, 31)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (140, 32)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (140, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (141, 25)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (141, 26)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (141, 27)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (141, 28)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (141, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (142, 5)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (142, 27)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (143, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (144, 33)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (144, 37)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (144, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (144, 49)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (145, 2)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (145, 30)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (145, 45)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (145, 48)
INSERT [dbo].[profile_game] ([games_id], [profile_id]) VALUES (145, 49)
SET IDENTITY_INSERT [dbo].[profile_genre] ON 

INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (3, 1, 1)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (6, 1, 2)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (7, 1, 3)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (12, 1, 4)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (63, 1, 7)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (57, 1, 25)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (25, 1, 26)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (29, 1, 27)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (5, 2, 2)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (9, 2, 3)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (13, 2, 5)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (18, 2, 21)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (21, 2, 25)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (45, 2, 31)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (49, 2, 32)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (79, 2, 41)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (1, 3, 1)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (10, 3, 4)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (64, 3, 7)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (19, 3, 21)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (23, 3, 25)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (37, 3, 29)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (41, 3, 30)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (66, 3, 34)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (74, 3, 40)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (107, 3, 49)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (2, 4, 1)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (8, 4, 3)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (65, 4, 7)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (20, 4, 21)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (67, 4, 34)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (80, 4, 41)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (90, 4, 44)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (94, 4, 45)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (97, 4, 46)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (100, 4, 47)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (103, 4, 48)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (108, 4, 49)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (4, 5, 2)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (11, 5, 4)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (14, 5, 5)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (28, 5, 26)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (101, 5, 47)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (104, 5, 48)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (109, 5, 49)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (75, 6, 40)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (81, 6, 41)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (84, 6, 43)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (91, 6, 44)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (110, 6, 49)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (85, 7, 43)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (36, 9, 28)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (68, 9, 37)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (86, 9, 43)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (92, 9, 44)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (98, 9, 46)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (48, 10, 31)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (52, 10, 32)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (56, 10, 33)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (87, 10, 43)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (17, 11, 5)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (33, 11, 28)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (27, 12, 26)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (35, 12, 28)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (46, 12, 31)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (55, 12, 33)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (95, 12, 45)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (43, 13, 30)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (15, 14, 5)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (39, 14, 29)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (47, 14, 31)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (51, 14, 32)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (88, 14, 43)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (31, 15, 27)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (93, 15, 44)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (99, 15, 46)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (102, 15, 47)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (76, 16, 40)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (61, 17, 25)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (26, 18, 26)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (30, 18, 27)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (34, 18, 28)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (38, 18, 29)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (42, 18, 30)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (54, 18, 33)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (89, 18, 43)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (105, 18, 48)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (16, 19, 5)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (62, 19, 25)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (40, 19, 29)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (44, 19, 30)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (50, 19, 32)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (77, 19, 40)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (82, 19, 41)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (96, 19, 45)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (106, 19, 48)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (32, 20, 27)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (53, 20, 33)
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (78, 20, 40)
GO
INSERT [dbo].[profile_genre] ([profile_genre_id], [genre_id], [profile_id]) VALUES (83, 20, 41)
SET IDENTITY_INSERT [dbo].[profile_genre] OFF
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Diagram_0', 1, 1, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000000200000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF18000000FEFFFFFF0400000005000000060000000700000026000000090000000A0000000B0000000C0000000D0000000E0000000F0000001000000011000000120000001300000014000000150000001600000017000000FEFFFFFFFEFFFFFF1A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000FEFFFFFF2700000028000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000C09A5746F152D50103000000400E0000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000076080000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000080000008D1F000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000220000005F000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F0000002000000021000000FEFFFFFF23000000FEFFFFFFFEFFFFFF260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F0000003000000031000000320000003300000034000000350000003600000037000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000430000A1E100C05000080290000000F00FFFF29000000007D000046990000775E000056A700000E70000078ECFFFF52030000DE805B10F195D011B0A000AA00BDCB5C000008003000000000020000030000003C006B0000000900000000000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002800430000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002800430000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C18000000840700000098010000003800A50900000700008001000000A6020000008000001000008053636847726964002EF0FFFF08070000626F6172645F67616D65202864626F2900003C00A50900000700008002000000AA020000008000001200008053636847726964005AF1FFFFD0200000667269656E64735F6C697374202864626F29000000003C00A50900000700008003000000AA02000000800000120000805363684772696400E8350000E835000067616D655F6C696272617279202864626F29000000003C00A50900000700008004000000AC0200000080000013000080536368477269640034530000BE23000067656E72655F6C696272617279202864626F290000003800A50900000700008005000000A0020000008000000D0000805363684772696400C0120000D020000070726F66696C65202864626F2909000000003C00A50900000700008006000000AA02000000800000120000805363684772696400441600003642000070726F66696C655F67616D65202864626F29000000008C00A50900000700008007000000520000000180000064000080436F6E74726F6C00431500001339000052656C6174696F6E736869702027464B5F5F70726F66696C655F675F5F70726F66695F5F3446374344303044202864626F2927206265747765656E202770726F66696C65202864626F292720616E64202770726F66696C655F67616D65202864626F292700002800B50100000700008008000000310000006F00000002800000436F6E74726F6C00CE030000543E000000003C00A5090000070000800D000000AC02000000800000130000805363684772696400E8350000FC21000070726F66696C655F67656E7265202864626F290000003400A5090000070000800E00000098020000008000000900008053636847726964006009000072060000727067202864626F2900000000003400A509000007000080120000009C020000008000000B0000805363684772696400F0F1FFFF6C3900007573657273202864626F296F00008800A5090000070000801300000052000000018000005D000080436F6E74726F6C004C0700006B38000052656C6174696F6E736869702027464B5F5F70726F66696C655F5F757365725F69645F5F3443413036333632202864626F2927206265747765656E20277573657273202864626F292720616E64202770726F66696C65202864626F292705000000002800B50100000700008014000000310000006F00000002800000436F6E74726F6C0063000000FB37000000003800A50900000700008015000000A6020000008000001000008053636847726964002823000072060000766964656F5F67616D65202864626F2900009000A5090000070000801A000000520000000180000067000080436F6E74726F6C005B2600003541000052656C6174696F6E736869702027464B5F70726F66696C655F67616D655F67616D655F6C696272617279202864626F2927206265747765656E202767616D655F6C696272617279202864626F292720616E64202770726F66696C655F67616D65202864626F29273F00002800B5010000070000801B000000310000006B00000002800000436F6E74726F6C00A5260000C540000000008800A5090000070000801E00000052000000018000005F000080436F6E74726F6C001C280000FB20000052656C6174696F6E736869702027464B5F70726F66696C655F67656E72655F70726F66696C65202864626F2927206265747765656E202770726F66696C65202864626F292720616E64202770726F66696C655F67656E7265202864626F29270000002800B5010000070000801F000000310000006300000002800000436F6E74726F6C009E2800008B20000000009400A5090000070000802400000052000000018000006B000080436F6E74726F6C00444B0000BD22000052656C6174696F6E736869702027464B5F70726F66696C655F67656E72655F67656E72655F6C696272617279202864626F2927206265747765656E202767656E72655F6C696272617279202864626F292720616E64202770726F66696C655F67656E7265202864626F29270000002800B50100000700008025000000310000006F00000002800000436F6E74726F6C00794800004D22000000008800A5090000070000802600000052000000018000005D000080436F6E74726F6C00B6060000CF1F000052656C6174696F6E736869702027464B5F667269656E64735F6C6973745F70726F66696C65202864626F2927206265747765656E202770726F66696C65202864626F292720616E642027667269656E64735F6C697374202864626F292700000000002800B50100000700008027000000310000006100000002800000436F6E74726F6C00BD0700005F1F000000008400A50900000700008028000000520000000180000059000080436F6E74726F6C00EFF0FFFF2D2A000052656C6174696F6E736869702027464B5F667269656E64735F6C6973745F7573657273202864626F2927206265747765656E20277573657273202864626F292720616E642027667269656E64735F6C697374202864626F292700000000002800B50100000700008029000000310000005D00000002800000436F6E74726F6C0035F3FFFF40310000000000000000000000000100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F573900000200E0955046F152D5010202000010484500000000000000000000000000000000004C0200004400610074006100200053006F0075007200630065003D0074006500730071006C007300650072007600650072002E00640061007400610062006100730065002E00770069006E0064006F00770073002E006E00650074002C0031003400330033003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0047006100214334120800000088160000930E000078563412070000001401000062006F006100720064005F00670061006D00650020002800640062006F0029000000803F0000803FD7D6563FDCDB5B3FEAE9693F0000803F00003340000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E00000000981B9424020000000300000000000000000000000000000000000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000B00000062006F006100720064005F00670061006D0065000000214334120800000088160000180C000078563412070000001401000066007200690065006E00640073005F006C0069007300740020002800640062006F002900000000000000004000000000006078400000000000003340000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E00000000E01C9424020000000300000000000000000000000000000000000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000180C000000000000030000000300000002000000020000001C010000F50A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D00000066007200690065006E00640073005F006C0069007300740000002143341208000000881600007F180000785634120700000014010000670061006D0065005F006C0069006200720061007200790020002800640062006F0029000000003F0000803FF3F2723F9E9D1D3F0000803F0000803F0000803FF3F2723F9E9D1D3F0000803F0000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E00000000800D94240200000003000000000000000000000000000000000000000200000000000000000000000000000000005042000050C20000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000371C0000000000002D0100000A0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600007F18000000000000080000000800000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D000000670061006D0065005F006C0069006200720061007200790000002143341208000000881600009D090000785634120700000014010000670065006E00720065005F006C0069006200720061007200790020002800640062006F00290000000000000000000000006C9D400000000000808C40000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E00000000281E94240200000003000000000000000000000000000000000000000200000000000000000000000000000000006444000064C40000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000E000000670065006E00720065005F006C006900620072006100720079000000214334120800000088160000FA1A0000785634120700000014010000700072006F00660069006C00650020002800640062006F0029000000E6E5653F0000803F0000803FD0CF4F3FD7D6563FE6E5653F0000803F000080400000C0400000E0400000C0400000A0400000C0400000404000001041000040400000E0400000E0400000E040000010410000A040000040400000E04000001041000000410000C040000030410000C040000030410000C040000080400000C0400000E0400000C0400000804000004040000080400000C0400000E0400000E0400000C0400000C0400000C0400000C0400000A0400000A0400000E0400000A0400000C0400000804000004040000080400000000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900007D1E0000000000002D0100000B0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000FA1A000000000000090000000900000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000008000000700072006F00660069006C00650000002143341208000000431100009D090000785634120700000014010000700072006F00660069006C0065005F00670061006D00650020002800640062006F002900000000000000000000000000000000400000000000808C40000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E00000000A03B94240200000003000000000000000000000000000000000000000200000000000000000000000000000000006444000064C40000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000431100009D09000000000000020000000200000002000000020000001C010000F8070000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D000000700072006F00660069006C0065005F00670061006D006500000002000B00DA160000CA3B0000DA160000364200000000000002000000F0F0F00000000000000000000000000000000000010000000800000000000000CE030000543E00005D12000058010000320000000100000200005D12000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F005F00700072006F00660069006C0065005F0067005F005F00700072006F00660069005F005F0034004600370043004400300030004400214334120800000088160000180C0000785634120700000014010000700072006F00660069006C0065005F00670065006E007200650020002800640062006F00290000000000000000000000006C9D400000000000408D40000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E00000000C04094240200000003000000000000000000000000000000000000000200000000000000000000000000000000006A4400006AC40000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000180C000000000000030000000300000002000000020000001C010000F50A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000E000000700072006F00660069006C0065005F00670065006E00720065000000214334120800000088160000930E000078563412070000001401000072007000670020002800640062006F00290000001C359424000000000000000000000000000000000000000000000000000000400000000000408D40000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E00000000383594240200000003000000000000000000000000000000000000000200000000000000000000000000000000006A4400006AC40000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000040000007200700067000000214334120800000088160000041600007856341207000000140100007500730065007200730020002800640062006F002900000000000000000000000000000000000000000000000000000000009E400000000000004A40000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E0000000060ACC30D0200000003000000000000000000000000000000000000000200000000000000000000000000000000005042000050C20000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600000416000000000000070000000700000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000600000075007300650072007300000002000B0078080000023A0000C0120000023A00000000000002000000F0F0F0000000000000000000000000000000000001000000140000000000000063000000FB3700005D12000058010000640000000100000200005D12000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F005F00700072006F00660069006C0065005F005F0075007300650072005F00690064005F005F00340043004100300036003300360032002143341208000000881600008913000078563412070000001401000076006900640065006F005F00670061006D00650020002800640062006F00290000000000000000000000000000000000006C9D400000000000808C40000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000C4ABAB5E0000000000000000846CAC5E1C58AC5E00000000F0AEC30D0200000003000000000000000000000000000000000000000200000000000000000000000000000000006444000064C40000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000AB170000000000002D010000080000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600008913000000000000060000000600000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000B00000076006900640065006F005F00670061006D006500000002000B00E8350000CC42000087270000CC4200000000000002000000F0F0F00000000000000000000000000000000000010000001B00000000000000A5260000C5400000AC100000580100003E000000010000020000AC10000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611C0046004B005F00700072006F00660069006C0065005F00670061006D0065005F00670061006D0065005F006C0069006200720061007200790002000B004829000092220000E8350000922200000000000002000000F0F0F00000000000000000000000000000000000010000001F000000000000009E2800008B2000004A0D000058010000640000000100000200004A0D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61180046004B005F00700072006F00660069006C0065005F00670065006E00720065005F00700072006F00660069006C00650002000B003453000054240000704C0000542400000000000002000000F0F0F00000000000000000000000000000000000010000002500000000000000794800004D2200001F110000580100003E0000000100000200001F11000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611E0046004B005F00700072006F00660069006C0065005F00670065006E00720065005F00670065006E00720065005F006C0069006200720061007200790002000B00C012000066210000E2070000662100000000000002000000F0F0F00000000000000000000000000000000000010000002700000000000000BD0700005F1F0000F10B00005801000057000000010000020000F10B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61170046004B005F0066007200690065006E00640073005F006C006900730074005F00700072006F00660069006C00650002000B0086F2FFFF6C39000086F2FFFFE82C00000000000002000000F0F0F0000000000000000000000000000000000001000000290000000000000035F3FFFF403100007D0B0000580100003D0000000100000200007D0B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61150046004B005F0066007200690065006E00640073005F006C006900730074005F0075007300650072007300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000019000000731900000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000240000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000025000000A60400000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000003800000012000000000000000C00000078ECFFFF520300000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000030000000300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000040000000400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000050000000500000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000060000000600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003000340030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000700000007000000000000004E0000000100000001000000640062006F00000046004B005F005F00700072006F00660069006C0065005F0067005F005F00700072006F00660069005F005F003400460037004300440030003000440000000000000000000000C402000000000800000008000000070000000800000001D1FE0D48D1FE0D0000000000000000AD0700000000000D0000000D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000E0000000E00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000120000001200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001300000013000000000000004E000000013FA62101000000640062006F00000046004B005F005F00700072006F00660069006C0065005F005F0075007300650072005F00690064005F005F003400430041003000360033003600320000000000000000000000C402000000001400000014000000130000000800000001CCFE0DC8CCFE0D0000000000000000AD070000000000150000001500000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001A0000001A000000000000004A000000013FA62101000000640062006F00000046004B005F00700072006F00660069006C0065005F00670061006D0065005F00670061006D0065005F006C0069006200720061007200790000000000000000000000C402000000001B0000001B0000001A0000000800000001CEFE0D48CEFE0D0000000000000000AD0700000000001E0000001E00000000000000420000000110D96A01000000640062006F00000046004B005F00700072006F00660069006C0065005F00670065006E00720065005F00700072006F00660069006C00650000000000000000000000C402000000001F0000001F0000001E0000000800000001D1FE0D08D1FE0D0000000000000000AD0700000000002400000024000000000000004E0000000100350001000000640062006F00000046004B005F00700072006F00660069006C0065005F00670065006E00720065005F00670065006E00720065005F006C0069006200720061007200790000000000000000000000C402000000002500000025000000240000000800000001CBFE0D48CBFE0D0000000000000000AD07000000000026000000260000000000000040000000013FA62101000000640062006F00000046004B005F0066007200690065006E00640073005F006C006900730074005F00700072006F00660069006C00650000000000000000000000C402000000002700000027000000260000000800000001CFFE0DC8CFFE0D0000000000000000AD0700000000002800000028000000000000003C000000013FA62101000000640062006F00000046004B005F0066007200690065006E00640073005F006C006900730074005F007500730065007200730000000000000000000000C402000000002900000029000000280000000800000001CEFE0DC8CEFE0D0000000000000000AD070000000000230000001A0000000300000006000000740000003900000024000000040000000D0000004A000000510000000700000005000000060000000D000000000000001E000000050000000D0000004F0000004A0000002600000005000000020000004A0000004B0000001300000012000000050000004B0000009E00000028000000120000000200000000000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006D0065004D006100740063006800650072003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D0061007000700061006300630065007300730075007300650072003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B0045006E00630072007900700074003D0054007200750065003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500140000004400690061006700720061006D005F0030000000000226001600000076006900640065006F005F00670061006D006500000008000000640062006F000000000226000C00000075007300650072007300000008000000640062006F0000000002260008000000720070006700000008000000640062006F000000000226001C000000700072006F00660069006C0065005F00670065006E0072006500000008000000640062006F000000000226001A000000700072006F00660069006C0065005F00670061006D006500000008000000640062006F0000000002260010000000700072006F00660069006C006500000008000000640062006F000000000226001C000000670065006E00720065005F006C00690062007200610072007900000008000000640062006F000000000226001A000000670061006D0065005F006C00690062007200610072007900000008000000640062006F000000000226001A00000066007200690065006E00640073005F006C00690073007400000008000000640062006F000000000224001600000062006F006100720064005F00670061006D006500000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D0000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'GameMatcherDiagram', 1, 2, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000000200000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF1A000000FEFFFFFF0400000005000000060000000700000029000000090000000A0000000B0000000C0000000D0000000E0000000F00000010000000110000001200000013000000140000001500000016000000170000001800000019000000FEFFFFFFFEFFFFFF1C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000FEFFFFFF2A0000002B000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF020000000000000000000000000000000000000000000000000000000000000040E8F9584D5BD50103000000C00E0000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000BA080000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000080000006522000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000230000005F000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000FEFFFFFF24000000FEFFFFFFFEFFFFFF2700000028000000290000002A0000002B0000002C0000002D0000002E0000002F00000030000000310000003200000033000000340000003500000036000000370000003800000039000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000430000A1E100C05000080190000000F00FFFF19000000007D0000AB8600005948000022A40000C7BB000000000000AA1A0000DE805B10F195D011B0A000AA00BDCB5C0000080030000000000200000300000038002B00000009000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002C00432000000000000000000000E00EA3B8B16A074887C09277C9C5051B34C9D2777977D811907000065B840D9C00002C00432000000000000000000000073EE6BFB8D29E4CB20BB589800C0C0334C9D2777977D811907000065B840D9C19000000C40700000099010500003800A50900000700008001000000A6020000008000001000008053636847726964008A66000000000000626F6172645F67616D65202864626F2900003C00A50900000700008002000000AA0200000080000012000080536368477269640000000000D8270000667269656E64735F6C697374202864626F29000000003C00A50900000700008003000000AA02000000800000120000805363684772696400D20F0000387C000067616D655F6C696272617279202864626F29000000003C00A50900000700008004000000AC020000008000001300008053636847726964000C300000E457000067656E72655F6C696272617279202864626F290000003800A50900000700008005000000A0020000008000000D0000805363684772696400D20F00008E44000070726F66696C65202864626F2909000000008800A5090000070000800600000062000000018000005D000080436F6E74726F6C00A70900003531000052656C6174696F6E736869702027464B5F667269656E64735F6C6973745F70726F66696C65202864626F2927206265747765656E202770726F66696C65202864626F292720616E642027667269656E64735F6C697374202864626F292705000000002800B50100000700008007000000310000006100000002800000436F6E74726F6C00501100005F39000000003C00A50900000700008008000000AA02000000800000120000805363684772696400D20F0000E268000070726F66696C655F67616D65202864626F29000000008C00A50900000700008009000000520000000180000064000080436F6E74726F6C005D190000D15C000052656C6174696F6E736869702027464B5F5F70726F66696C655F675F5F70726F66695F5F3446374344303044202864626F2927206265747765656E202770726F66696C65202864626F292720616E64202770726F66696C655F67616D65202864626F292700002800B5010000070000800A000000310000006F00000002800000436F6E74726F6C00E80700008963000000009000A5090000070000800B000000520000000180000067000080436F6E74726F6C005D190000C46F000052656C6174696F6E736869702027464B5F70726F66696C655F67616D655F67616D655F6C696272617279202864626F2927206265747765656E202767616D655F6C696272617279202864626F292720616E64202770726F66696C655F67616D65202864626F29270000002800B5010000070000800C000000310000006B00000002800000436F6E74726F6C00A31B0000AF76000000003C00A5090000070000800D000000AC020000008000001300008053636847726964000C300000CC42000070726F66696C655F67656E7265202864626F290000008800A5090000070000800E00000062000000018000005F000080436F6E74726F6C002E2500002D47000052656C6174696F6E736869702027464B5F70726F66696C655F67656E72655F70726F66696C65202864626F2927206265747765656E202770726F66696C65202864626F292720616E64202770726F66696C655F67656E7265202864626F29270000002800B5010000070000800F000000310000006300000002800000436F6E74726F6C00D92E0000FE50000000009400A5090000070000801000000052000000018000006B000080436F6E74726F6C0097390000294C000052656C6174696F6E736869702027464B5F70726F66696C655F67656E72655F67656E72655F6C696272617279202864626F2927206265747765656E202767656E72655F6C696272617279202864626F292720616E64202770726F66696C655F67656E7265202864626F29270000002800B50100000700008011000000310000006F00000002800000436F6E74726F6C00DD3B00002A52000000003400A509000007000080120000009802000000800000090000805363684772696400FC21000000000000727067202864626F2900000000003C00A50900000700008013000000A8020000008000001100008053636847726964008E440000000000007379736469616772616D73202864626F2929000000003400A509000007000080140000009C020000008000000B0000805363684772696400A41F0000282300007573657273202864626F290000008800A5090000070000801500000062000000018000005D000080436F6E74726F6C000F1A00007536000052656C6174696F6E736869702027464B5F5F70726F66696C655F5F757365725F69645F5F3443413036333632202864626F2927206265747765656E20277573657273202864626F292720616E64202770726F66696C65202864626F292705000000002800B50100000700008016000000310000006F00000002800000436F6E74726F6C00391C00003643000000008400A50900000700008017000000520000000180000059000080436F6E74726F6C005C1500001D2C000052656C6174696F6E736869702027464B5F667269656E64735F6C6973745F7573657273202864626F2927206265747765656E20277573657273202864626F292720616E642027667269656E64735F6C697374202864626F292700000000002800B50100000700008018000000310000005D00000002800000436F6E74726F6C0069150000AD2B000000003800A50900000700008019000000A6020000008000001000008053636847726964000000000000000000766964656F5F67616D65202864626F290000000000000100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F5739000002004095F2584D5BD501020200001048450000000000000000000000000000000000320200004400610074006100200053006F0075007200630065003D0074006500730071006C007300650072007600650072002E00640061007400610062006100730065002E00770069006E00214334120800000088160000930E000078563412070000001401000062006F006100720064005F00670061006D00650020002800640062006F00290000000000E0B9556C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000B00000062006F006100720064005F00670061006D0065000000214334120800000088160000180C000078563412070000001401000066007200690065006E00640073005F006C0069007300740020002800640062006F0029000000082BE4FE082BD0FF082B94FF082B0002B52CCC01B52C3820B52CF41FB52C7401882BBC00882BFC21B52CB821B52CBC23B52C7823B52CD40FB52C980FB52C9C24B52C5824B52C942BB52C602BB52C7C25B52C3825B52CD014B52C9014B52C1802882BC001882BC81EB52C8C1EB52C4C0FB52C0C0FB52CDC22B52C9822B52C2028B52CDC27B52C5C26B52C1826B52C642EB52C102EB52C0000000072000000280CB52CE00BB52CC42AB52C802AB52C3430082BF42F082BC00EB52C840EB52C4414B52C1014B52C0000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000180C000000000000030000000300000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D00000066007200690065006E00640073005F006C0069007300740000002143341208000000881600007F180000785634120700000014010000670061006D0065005F006C0069006200720061007200790020002800640062006F0029000000803FD7D6563FDCDB5B3FEAE9693F0000803F0000000049000000CC65082BDC64082B0000000000000000000000000C000000000000000000000049000000D465082BE864082B0000000000000000000000000C000000000000000000000049000000C465082BF464082B000000000000000000000000080000000000000000000000490000000066082B0065082B00000000000000000000000008000000000000000000000049000000DC65082B0C65082B00000000000000000000000008000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000371C0000000000002D0100000A0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600007F18000000000000080000000800000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D000000670061006D0065005F006C0069006200720061007200790000002143341208000000881600009D090000785634120700000014010000670065006E00720065005F006C0069006200720061007200790020002800640062006F0029000000B0AED767B0AED767BCAED767BCAED767C8AED767C8AED767D4AED767D4AED767E0AED767E0AED767ECAED767ECAED767F8AED767F8AED76704AFD76704AFD76710AFD76710AFD7671CAFD7671CAFD76728AFD76728AFD76734AFD76734AFD76740AFD76740AFD7674CAFD7674CAFD76758AFD76758AFD76764AFD76764AFD76770AFD76770AFD7677CAFD7677CAFD76788AFD76788AFD76794AFD76794AFD767A0AFD767A0AFD767ACAFD767ACAFD767B8AFD767B8AFD767C4AFD767C4AFD767D0AFD767D0AF000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000E000000670065006E00720065005F006C006900620072006100720079000000214334120800000088160000FA1A0000785634120700000014010000700072006F00660069006C00650020002800640062006F0029000000B8B6D767C4B6D767C4B6D767D0B6D767D0B6D767DCB6D767DCB6D767ECB6D767ECB6D767F8B6D767F8B6D76704B7D76704B7D76710B7D76710B7D7671CB7D7671CB7D7672CB7D7672CB7D7673CB7D7673CB7D76748B7D76748B7D76754B7D76754B7D76760B7D76760B7D7676CB7D7676CB7D76788B7D76788B7D76794B7D76794B7D767A0B7D767A0B7D767ACB7D767ACB7D767B8B7D767B8B7D767C8B7D767C8B7D767D8B7D767D8B7D767E8B7D767E8B7D767F8B7D767F8B7D76704B8D76704B8D76710B8D76710B8D7671CB8D7671CB8000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900007D1E0000000000002D0100000B0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000FA1A000000000000090000000900000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000008000000700072006F00660069006C006500000004000B00C81900008E440000C8190000663B0000220B0000663B0000220B0000F03300000000000002000000F0F0F00000000000000000000000000000000000010000000700000000000000501100005F390000F10B0000580100003B000000010000020000F10B000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61170046004B005F0066007200690065006E00640073005F006C006900730074005F00700072006F00660069006C0065002143341208000000881600009D090000785634120700000014010000700072006F00660069006C0065005F00670061006D00650020002800640062006F0029000000D767ACACD767ACACD767B8ACD767B8ACD767C4ACD767C4ACD767D0ACD767D0ACD767DCACD767DCACD767E8ACD767E8ACD76704ADD76704ADD76710ADD76710ADD7671CADD7671CADD76728ADD76728ADD76734ADD76734ADD76740ADD76740ADD76750ADD76750ADD7675CADD7675CADD76768ADD76768ADD76774ADD76774ADD76780ADD76780ADD7678CADD7678CADD76798ADD76798ADD767A4ADD767A4ADD767B0ADD767B0ADD767BCADD767BCADD767C8ADD767C8ADD767D4ADD767D4ADD767E0ADD767E0AD000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D000000700072006F00660069006C0065005F00670061006D006500000002000B00F41A0000885F0000F41A0000E26800000000000002000000F0F0F00000000000000000000000000000000000010000000A00000000000000E8070000896300005D12000058010000320000000100000200005D12000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F005F00700072006F00660069006C0065005F0067005F005F00700072006F00660069005F005F003400460037004300440030003000440002000B00F41A0000387C0000F41A00007F7200000000000002000000F0F0F00000000000000000000000000000000000010000000C00000000000000A31B0000AF760000AC1000005801000032000000010000020000AC10000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611C0046004B005F00700072006F00660069006C0065005F00670061006D0065005F00670061006D0065005F006C00690062007200610072007900214334120800000088160000180C0000785634120700000014010000700072006F00660069006C0065005F00670065006E007200650020002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000180C000000000000030000000300000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000E000000700072006F00660069006C0065005F00670065006E0072006500000004000B005A260000085200002A2E0000085200002A2E0000A84800000C300000A84800000000000002000000F0F0F00000000000000000000000000000000000010000000F00000000000000D92E0000FE5000004A0D000058010000320000000100000200004A0D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61180046004B005F00700072006F00660069006C0065005F00670065006E00720065005F00700072006F00660069006C00650002000B002E3B0000E45700002E3B0000E44E00000000000002000000F0F0F00000000000000000000000000000000000010000001100000000000000DD3B00002A5200001F11000058010000390000000100000200001F11000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611E0046004B005F00700072006F00660069006C0065005F00670065006E00720065005F00670065006E00720065005F006C00690062007200610072007900214334120800000088160000930E000078563412070000001401000072007000670020002800640062006F002900000000000000000000000100000000000000E0B9556C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000400000072007000670000002143341208000000881600000E1100007856341207000000140100007300790073006400690061006700720061006D00730020002800640062006F0029000000E0B9556C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600000E11000000000000050000000500000002000000020000001C010000F50A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C0000007300790073006400690061006700720061006D0073000000214334120800000088160000041600007856341207000000140100007500730065007200730020002800640062006F0029000000000000000100000000000000E0B9556C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600000416000000000000070000000700000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000600000075007300650072007300000004000B00C62A00002C390000C62A0000663B00008A1B0000663B00008A1B00008E4400000000000002000000F0F0F00000000000000000000000000000000000010000001600000000000000391C0000364300005D12000058010000640000000100000200005D12000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611E0046004B005F005F00700072006F00660069006C0065005F005F0075007300650072005F00690064005F005F003400430041003000360033003600320002000B00A41F0000B42D000088160000B42D00000000000002000000F0F0F0000000000000000000000000000000000001000000180000000000000069150000AD2B00007D0B000058010000350000000100000200007D0B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61150046004B005F0066007200690065006E00640073005F006C006900730074005F00750073006500720073002143341208000000881600008913000078563412070000001401000076006900640065006F005F00670061006D00650020002800640062006F00290000002000610073002000440054005F006E0061006D0065002C00200073006300680065006D0061005F006E0061006D0065002800730074002E0073006300680065006D0061005F006900640029002000610073002000440054005F0073006300680065006D0061002C00200063006F006C002E006D00610078005F006C0065006E006700740068002C00200063006F006C002E0070007200650063006900730069006F006E002C00200063006F006C002E007300630061006C0065002C002000620074002E006E0061006D006500000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000AB170000000000002D010000080000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600008913000000000000060000000600000002000000020000001C010000F50A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000B00000076006900640065006F005F00670061006D00650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000001B000000831B00000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000250000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000026000000CA0400000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000003A00000012000000000000000C00000000000000AA1A00000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000030000000300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000040000000400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000050000000500000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000600000006000000000000004000000001F7232A01000000640062006F00000046004B005F0066007200690065006E00640073005F006C006900730074005F00700072006F00660069006C00650000000000000000000000C402000000000700000007000000060000000800000001240E2A30240E2A0000000000000000AD0F0000010000080000000800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000900000009000000000000004E0000000100350001000000640062006F00000046004B005F005F00700072006F00660069006C0065005F0067005F005F00700072006F00660069005F005F003400460037004300440030003000440000000000000000000000C402000000000A0000000A000000090000000800000001260E2AF0260E2A0000000000000000AD0F00000100000B0000000B000000000000004A0000000100350001000000640062006F00000046004B005F00700072006F00660069006C0065005F00670061006D0065005F00670061006D0065005F006C0069006200720061007200790000000000000000000000C402000000000C0000000C0000000B0000000800000001240E2AB0240E2A0000000000000000AD0F00000100000D0000000D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000E0000000E000000000000004200000001F7232A01000000640062006F00000046004B005F00700072006F00660069006C0065005F00670065006E00720065005F00700072006F00660069006C00650000000000000000000000C402000000000F0000000F0000000E0000000800000001200E2A30200E2A0000000000000000AD0F00000100001000000010000000000000004E00000001E8232A01000000640062006F00000046004B005F00700072006F00660069006C0065005F00670065006E00720065005F00670065006E00720065005F006C0069006200720061007200790000000000000000000000C402000000001100000011000000100000000800000001270E2A30270E2A0000000000000000AD0F0000010000120000001200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000130000001300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000140000001400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001500000015000000000000004E0000000100350001000000640062006F00000046004B005F005F00700072006F00660069006C0065005F005F0075007300650072005F00690064005F005F003400430041003000360033003600320000000000000000000000C402000000001600000016000000150000000800000001250E2A70250E2A0000000000000000AD0F00000100001700000017000000000000003C0000000100000001000000640062006F00000046004B005F0066007200690065006E00640073005F006C006900730074005F007500730065007200730000000000000000000000C4020000000018000000180000001700000008000000012F0E2A302F0E2A0000000000000000AD0F0000010000190000001900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000230000000B0000000300000008000000240000002500000010000000040000000D00000024000000250000000E000000050000000D000000770000005C000000090000000500000008000000250000002400000006000000050000000200000020000000250000001700000014000000020000006C0000005D0000001500000014000000050000002500000026000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000064006F00770073002E006E00650074002C0031003400330033003B0049006E0069007400690061006C00200043006100740061006C006F0067003D00470061006D0065004D006100740063006800650072003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D0061007000700061006300630065007300730075007300650072003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F00220000000080050026000000470061006D0065004D006100740063006800650072004400690061006700720061006D000000000226001600000062006F006100720064005F00670061006D006500000008000000640062006F000000000226001A00000066007200690065006E00640073005F006C00690073007400000008000000640062006F000000000226001A000000670061006D0065005F006C00690062007200610072007900000008000000640062006F000000000226001C000000670065006E00720065005F006C00690062007200610072007900000008000000640062006F0000000002260010000000700072006F00660069006C006500000008000000640062006F000000000226001A000000700072006F00660069006C0065005F00670061006D006500000008000000640062006F000000000226001C000000700072006F00660069006C0065005F00670065006E0072006500000008000000640062006F0000000002260008000000720070006700000008000000640062006F00000000022600180000007300790073006400690061006700720061006D007300000008000000640062006F000000000226000C00000075007300650072007300000008000000640062006F000000000224001600000076006900640065006F005F00670061006D006500000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (1, N'reverend_G', N'gregkulik@gmail.com', N'e7iHqb2o32/uIXhF+iXAz7pordk=', N'oCV30wU6Kvg=', N'User', N'15216')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (2, N'LeoSlayer', N'leoslayer@gmail.com', N'7YBJa+/Dp0lRmqWXE8cQlZOP6TU=', N'cZ5BRnK2i80=', N'User', N'15219')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (3, N'General_Boy', N'General_Boy@aol.com', N'AQNjtodtqL6rsfUAiqnouqJmqFQ=', N'Fcxbhf8fGNg=', N'User', N'15003')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (4, N'Pony_Elvis', N'Pony_Elvis@comcast.net', N'xFq9hTDKKtBfzf973Ih+/4cMd+g=', N'J9dlHyViKh4=', N'User', N'15219')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (5, N'phoenixx420', N'phoenixx420@yahoo.com', N'UYBAbfhIuWM4baEiFPM5b9RISyM=', N'0QnNABTsyHg=', N'User', N'15217')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (6, N'IvoryUnclerico', N'campbellchadm@gmail.com', N'uQMMmrdMI697y3GK6SWsmU/DkOM=', N'lY5o3eTSRuc=', N'User', N'15237')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (7, N'Dragonhelm', N'jrtfan@gmail.com', N'1vUk5XnV1fCXAnMuVS72mRjkApo=', N'UYLlqiYl1V0=', N'User', N'15132')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (8, N'BeattleJuice', N'pizza@yahoo.com', N'GWSkhK1+/r2Y0fobz3Te8M5q+N4=', N'oYqXMCSGNm0=', N'User', N'15132')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (9, N'yo_mama', N'joshlanger@gmail.com', N'EnYqgY+8GqJF3zXbSE+osTb3bBg=', N'BqoU48b7cRo=', N'User', N'15217')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (10, N'dekubee', N'melsaysrun@aim.com', N'Ub/qmFFxjvqqodVPh1bV9vS/aBk=', N'R/TZVWxW8UM=', N'User', N'15210')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (11, N'DandyTheWandy', N'DTW@verizon.net', N'qN1CdwOou4nY8npDRwH6C4u8uZo=', N'BURvPFu5Og0=', N'User', N'10345')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (12, N'oddWorldEddy', N'oddy@gmail.com', N'NivIaZUqYUAeYbvEBqjDMLMdXQY=', N'AyHD2J1z46U=', N'User', N'15132')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (13, N'heythere', N'hey@email.com', N'TKYOpMnk7cBO4AY+bWlNsN7mQrI=', N'mYRT9hd+0MI=', N'User', N'15210')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (14, N'piedpiper27', N'richardhendricks@gmail.com', N'5smTZscT5Up7O54KAjehiBoXR6s=', N'43uIQ4gE7h4=', N'User', N'15212')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (15, N'sailormoon92', N'melsaysrun@aim.com', N'JeE++ndXB16SBPgWfh6S+6C1UyY=', N'5ytHuSjYx4o=', N'User', N'15210')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (16, N'yabai31', N'hello@hotmail.com', N'fg8Pn9A6/mUdOJbz2lXmFRMjLjc=', N'McdGHlgT1vw=', N'User', N'15217')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (17, N'aintnosunshine', N'therock@hotmail.com', N'1I8ynGlVzyothj4CCGK4gT4u90g=', N'wZbr03+FRSc=', N'User', N'21931')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (18, N'ruthless1279', N'heythere@hotmail.com', N'I7wq/LM2kHSrDJJZj4WTDgBMfiE=', N'hMMz7Q33LXo=', N'User', N'16312')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (19, N'boojiboy', N'boojiboy@devo.com', N'MhWi0wc/X3eDzUfc2cjBcLghedE=', N'Liuhn3UeJ/o=', N'User', N'16211')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (20, N'FizzBuzz', N'fizzbuzz@aol.com', N'gn4z6Q5p04u2dCT/xlAanM0sAzY=', N'ym9owTvxJH4=', N'User', N'15213')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (21, N'NeoAnderson', N'Tom_Anderson@techelevator.com', N'MXgECdnq4z+5gnFZClE2zqZeEqc=', N'FpOCY+XQYO8=', N'User', N'15238')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (22, N'PsychoZajko', N'CaitieZajko@comcast.net', N'UWaFdmYe/uLbAn3hRSntX3jumFk=', N'woCwuPFozgw=', N'User', N'15106')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (23, N'MedvitzTheEviscerator', N'Tom_Medvitz@techelevator.com', N'hcyvGhNyncEt6BC2ScMEoTHtZIE=', N'WuY2y7mlaak=', N'User', N'15227')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (24, N'20000_BC', N'Beth_Campbell@techelevator.com', N'0fN6nl4cV3nC/R7QRaIBuFWbezA=', N'f47s+xa9Bak=', N'User', N'15250')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (25, N'HEYWILMERIMHOME', N'Marissa_Wilmer@techelevator.com', N'xehEY30qd7bT58okZ4gGrYJr4jc=', N'FqaHoVVB0lM=', N'User', N'15220')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (26, N'SquirrelPartyOrganizer', N'JustinDriscoll@techelevator.com', N'AbzlHOPea31G9oNbi55qP28hQaY=', N'1b4gDk7037s=', N'User', N'15253')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (27, N'threebeans', N'example@hotmail.com', N'LltpdfLWP2AD0rXaV0tDtY4QOvk=', N'du2+UXISGmM=', N'User', N'12345')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (28, N'bidlo_kwerve', N'bidlo@gmail.com', N'unAd9HXtw/Etau8EpCCREWx+1+c=', N'Nt6qDQxNHuc=', N'User', N'15003')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (29, N'C4su4l_Gmr', N'casualgamer@gmail.com', N'Qf7Z+xOucGZFJNXWAD8uUbePd0Q=', N'4lYU3/2QuHc=', N'User', N'15214')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (30, N'bears38', N'heynow@hotmail.com', N'QDCaQUcgR1/I5sMCU5uOQtQad1k=', N'VDJd40RK7Uw=', N'User', N'12345')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (31, N'bumblebee', N'melbee@aim.com', N'ZT2HyCozepLVfoFbrfESULunM6c=', N'QeG6OJYYNGQ=', N'User', N'16066')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (32, N'gamersupreme', N'123@yahoo.com', N'hQUCeMtPeu5XJlt+mJat8S5Sa5M=', N'DVUu8K6aWdQ=', N'User', N'33333')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (33, N'redirksen', N'redirksen@gmail.com', N'UHy1657mTdbdd8M7+qhYxGprniA=', N'jY7m4h2ZKuM=', N'User', N'15217')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (34, N'Lockedown02', N'atrombonekid@hotmail.com', N'pUNWousfOn4Vj8pth1E7JRK5Xmw=', N'pN5jngG9yfg=', N'User', N'15317')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (35, N'casual-gamer', N'casualgamer@gmail.com', N'rGnp60yR7MvySNZIwTpaG0izrvw=', N'ERnha8jb95k=', N'User', N'15216')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (36, N'CMKULIK', N'cristina.kulik@gmail.com', N'Jm4qscj7ZXAuIUytPU5XnxpuX4I=', N'4V7qs2YHH0U=', N'User', N'15216')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (37, N'hotshot21', N'hotshot21@gmail.com', N'pa6ezpKjNoFQaOOxfMDtfTd1dL8=', N'N7TvfxZ1PME=', N'User', N'15146')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (38, N'gamer21', N'hello@gmail.com', N'zINDFqvi5g+YYZgpFGyoO3g3PQk=', N'sYVJTOX53ms=', N'User', N'15210')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (39, N'soup555', N'rwcklc@gmail.com', N'8ohqaTV0rTu2dtcE6YIMJG5u+9k=', N'rmRm3+YmUdI=', N'User', N'15125')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (40, N'paul420', N'paul420@hotmail.com', N'16dYlu9Mc5RDsp54cUbLxJAaDTo=', N'U0XjcsiFu9w=', N'User', N'16801')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (41, N'jcr23@gmail.com', N'jcr23@gmail.com', N'Ys+Qyn+mjP7nnJp1+0L2PUrnoCk=', N'UIXoL+9a7Rg=', N'User', N'15328')
INSERT [dbo].[users] ([user_id], [username], [email], [password], [salt], [role], [zipcode]) VALUES (42, N'theMANofTHEhour', N'rjpst19@me.com', N'YomJwsSqG6wFjbfqQKTM30KQfZ0=', N'ukSReSWHIWE=', N'User', N'15129')
SET IDENTITY_INSERT [dbo].[users] OFF
/****** Object:  Index [UQ_PG_gameID_profileID]    Script Date: 8/26/2019 7:50:19 AM ******/
ALTER TABLE [dbo].[profile_game] ADD  CONSTRAINT [UQ_PG_gameID_profileID] UNIQUE NONCLUSTERED 
(
	[games_id] ASC,
	[profile_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PG_genreID_profileID]    Script Date: 8/26/2019 7:50:20 AM ******/
ALTER TABLE [dbo].[profile_genre] ADD  CONSTRAINT [UQ_PG_genreID_profileID] UNIQUE NONCLUSTERED 
(
	[genre_id] ASC,
	[profile_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 8/26/2019 7:50:20 AM ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('user') FOR [role]
GO
ALTER TABLE [dbo].[friends_list]  WITH CHECK ADD  CONSTRAINT [FK_friends_list_profile] FOREIGN KEY([profile_id])
REFERENCES [dbo].[profile] ([profile_id])
GO
ALTER TABLE [dbo].[friends_list] CHECK CONSTRAINT [FK_friends_list_profile]
GO
ALTER TABLE [dbo].[friends_list]  WITH CHECK ADD  CONSTRAINT [FK_friends_list_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[friends_list] CHECK CONSTRAINT [FK_friends_list_users]
GO
ALTER TABLE [dbo].[profile]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[profile_game]  WITH CHECK ADD  CONSTRAINT [FK__profile_g__profi__4F7CD00D] FOREIGN KEY([profile_id])
REFERENCES [dbo].[profile] ([profile_id])
GO
ALTER TABLE [dbo].[profile_game] CHECK CONSTRAINT [FK__profile_g__profi__4F7CD00D]
GO
ALTER TABLE [dbo].[profile_game]  WITH CHECK ADD  CONSTRAINT [FK_profile_game_game_library] FOREIGN KEY([games_id])
REFERENCES [dbo].[game_library] ([games_id])
GO
ALTER TABLE [dbo].[profile_game] CHECK CONSTRAINT [FK_profile_game_game_library]
GO
ALTER TABLE [dbo].[profile_genre]  WITH CHECK ADD  CONSTRAINT [FK_profile_genre_genre_library] FOREIGN KEY([genre_id])
REFERENCES [dbo].[genre_library] ([genre_id])
GO
ALTER TABLE [dbo].[profile_genre] CHECK CONSTRAINT [FK_profile_genre_genre_library]
GO
ALTER TABLE [dbo].[profile_genre]  WITH CHECK ADD  CONSTRAINT [FK_profile_genre_profile] FOREIGN KEY([profile_id])
REFERENCES [dbo].[profile] ([profile_id])
GO
ALTER TABLE [dbo].[profile_genre] CHECK CONSTRAINT [FK_profile_genre_profile]
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 8/26/2019 7:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 8/26/2019 7:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 8/26/2019 7:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 8/26/2019 7:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 8/26/2019 7:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 8/26/2019 7:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 8/26/2019 7:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
ALTER DATABASE [GameMatcherNew] SET  READ_WRITE 
GO
