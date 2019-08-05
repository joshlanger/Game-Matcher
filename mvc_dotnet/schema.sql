
-- Switch to the system (aka master) database
USE master;
GO

-- Delete the DemoDB Database (IF EXISTS)
IF EXISTS(select * from sys.databases where name='DemoDB')
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
	user_id			int		identity(1,1),
	username    varchar(50) not null,
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
first_name	   varchar(50)   null,
last_name	   varchar(50)   null,

constraint pk_profile primary key (profile_id),
foreign key (user_id) references users(user_id)
);

COMMIT TRANSACTION;