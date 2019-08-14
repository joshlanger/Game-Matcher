

-- Switch to the DemoDB Database
USE GameMatcher;
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
profile_id			int				identity(1,1),
user_id				int				not null,
user_name			varchar(50)		not null,	
avatar_name			varchar(50)		null,		
user_bio			varchar(250)	null,
gaming_experience	varchar(50)		null,
contact_preference	varchar(50)	    null,
other_interests		varchar(140)	null,
is_Private			bit				not null,


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

CREATE TABLE game_library(
games_id	int			not null,
title		varchar(50)	null,
style       varchar(50) null,
min_players int null,
max_players int null,
genre varchar(50) null,
platform varchar(50) null,
image		varchar(50) null,

foreign key (games_id)	references profile_game(games_id)
);

CREATE TABLE genre_library(
genre_id	int			not null,
genre		varchar(50)	null,
);

CREATE TABLE profile_genre(
profile_genre_id int identity(1,1),
genre_id	int			not null,
profile_id	int not null,
);

CREATE TABLE friends_list(
friends_list_id int identity(1,1),
user_id	int			not null,
profile_id	int not null,
);





COMMIT TRANSACTION;
