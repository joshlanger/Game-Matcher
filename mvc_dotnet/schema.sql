
-- Switch to the system (aka master) database
USE master;
GO

-- Delete the DemoDB Database (IF EXISTS)
IF EXISTS(select * from sys.databases where name='GamingMatcher')
DROP DATABASE GamingMatcher;
GO

-- Create a new DemoDB Database
CREATE DATABASE GamingMatcher;
GO

-- Switch to the DemoDB Database
USE GamingMatcher;
GO

BEGIN TRANSACTION;

CREATE TABLE users
(
	user_id		int			identity(1,1),
	username	varchar(50) not null,
	email    	varchar(50)	not null,
	password	varchar(50)	not null,
	salt		varchar(50)	not null,
	role		varchar(50)	default('user'),
	zipcode     varchar(10) not null,

	constraint pk_users primary key (user_id)
);
CREATE TABLE profile
(
profile_id     int           identity(1,1),
user_id        int           not null,
user_name		varchar(50)	 null,	
avatar_name	   varchar(50)	 null,		
user_bio	   varchar(250)  null,

constraint pk_profile primary key (profile_id),
foreign key (user_id) references users(user_id)
);

CREATE TABLE profile_game(
games_id	int identity(1,1),
profile_id	int not null,
constraint pk_profile_game primary key (games_id),
foreign key (profile_id) references profile(profile_id)
);
CREATE TABLE video_game(
games_id	int			not null,
name		varchar(50) null,
num_player	int			null,
genre		varchar(50) null,
platform	varchar(50) null,
image		varchar(50) null,

foreign key (games_id) references profile_game(games_id)
);
CREATE TABLE board_game(
games_id	int			not null,
name		varchar(50) null,  
num_players	int			null,
image		varchar(50) null,

foreign key (games_id) references profile_game(games_id)
);
CREATE TABLE rpg(
games_id	int			not null,
name		varchar(50)	null,
num_players varchar(50) null,
image		varchar(50) null,

foreign key (games_id)	references profile_game(games_id)
);
COMMIT TRANSACTION;
