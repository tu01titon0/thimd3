drop database moviesdatabase;
create database moviesdatabase;
use moviesdatabase;
create table Users(
id int primary key auto_increment,
userName varchar(50),
passWord varchar(50),
email varchar(50),
role bit default 0
);
create table Movies(
id int primary key auto_increment,
name varchar(50),
userId int,
foreign key(userid) references Users(id),
createdAt datetime DEFAULT CURRENT_TIMESTAMP,
dateAired datetime, 
 actors varchar(50),
 description text
);
create table Comments(
commentId int primary key auto_increment,
userId int,
foreign key(userId) references Users(id),
moviesId int,
foreign key(moviesId) references Movies(id),
comment text
);
create table Views(
moviesId int,
foreign key(moviesId) references Movies(id),
viewCount int , 
createAt datetime
);
create table Watchlist(
id int primary key auto_increment,
userID int,
foreign key(userID) references Users(id),
moviesId int,
foreign key(moviesId) references Movies(id)
);
create table Episodes(
id int primary key auto_increment,
moviesId int,
foreign key(moviesId) references Movies(id),
name varchar(50),
numberEpisodes int,
moviesUrl text 
);
create table Image(
id int primary key auto_increment,
moviesId int not null,
foreign key(moviesId) references Movies(id),
imgUrl text,
defaulImg boolean
);
create table Ratings(
id int primary key auto_increment,
moviesId int,
foreign key(moviesId) references Movies(id),
userId int,
foreign key(userId) references Users(id),
 rating tinyint check(rating between 1 and 5)
);
create table Favorites(
id int primary key auto_increment,
userId int,
foreign key(userId) references Users(id),
moviesId int,
foreign key(moviesId) references Movies(id)
);
create table Genre(
id int primary key auto_increment,
name varchar(50)
);
create table Genremovies(
moviesId int,
foreign key(moviesId) references Movies(id),
genreId int,
foreign key(genreId) references Genre(id)
);
-- Insert data into the Users table
INSERT INTO Users (userName, passWord, email, role)
VALUES ('vietadm', '123', 'vietadm@gmail.com', 1);

-- Insert data into the Movies table
INSERT INTO Movies (name, userId, createdAt, dateAired, actors,description)
VALUES ('Fifty Shades of Grey', 1, '2015-04-14', '2015-04-15', 'E.L. James','A routine interview between college senior Anastasia Steele and influential businessman Christian Grey, turns into a game of mystery and desire, as she slowly discovers his hidden tendencies.'),
		('Captain America: Chiến Binh Mùa Đông',1,'2014-03-13','2014-04-04','Anthony Russo, Joe Russo','As Steve Rogers struggles to embrace his role in the modern world, he teams up with a fellow Avenger and S.H.I.E.L.D agent, Black Widow, to battle a new threat from history: an assassin known as the Winter Soldier.'),
        ('Descendants of the Sun',1,'2016-02-14','2016-04-22','Lee Eung-bok, Baek Sang-hoon','This drama tells of the love story that develops between a surgeon and a special forces officer. Some relationships are fated, despite the challenges of time and place.'),
        ('Ashes Of Love',1,'2019-05-09','2019-03-11','Zhu Ruibin','Hidden away by her mother, the Floral Goddess, the naïve Jinmi is drawn to Xufeng, the Heavenly Emperors son. Yet forces conspire against them.'),
        ('Bão Ngầm',1,'2022-02-22','2022-07-06','Đinh Thái Thụy','Bão ngầm kể về hành trình điều tra của Đại úy Đào Hải Triều (Hà Việt Dũng) cùng các trinh sát trong việc điều tra phá án đường dây ma túy xuyên quốc gia. Bắt đầu từ việc bắt giữ vụ vận chuyển ma túy lớn trên đèo Mũi Ngựa, những sự thật về các tổ chức tội phạm xuyên quốc gia đã dần được bóc dỡ, vạch trần bộ mặt thật của tên trùm mafia ẩn trong một tập đoàn kinh tế lớn...')
        
        
        ;

-- Insert data into the Comments table
INSERT INTO Comments (userId, moviesId, comment)
VALUES (1, 1, 'i am adm');

-- Insert data into the Views table
INSERT INTO Views (moviesId, viewCount, createAt)
VALUES (1, 0, '2015-04-14'),
		(2,0,'2014-03-13'),
        (3,0,'2016-02-14'),
        (4,0,'2019-05-09'),
        (5,0,'2022-02-22');

-- Insert data into the Image table
INSERT INTO Image (moviesId, imgUrl, defaulImg)
VALUES (1, '50sacthai.jpg', true),
		(2, 'Captainamerica.jpg', true),
        (3,'hauduemattroi.jpg',true),
        (4,'huongmat.jpg',true),
        (5,'baongam.jpg',true)
		;

-- Insert data into the Ratings table
INSERT INTO Ratings (moviesId, userId, rating)
VALUES (1, 1, 5),
		(2,1,4),
        (3,1,5),
        (4,1,5),
        (5,1,4);

-- Insert data into the Genre table
INSERT INTO Genre (name)
VALUES ('Romance'),
		('Action'),
        ('Sex'),
        ('Drama'),
        ('Comedy'),
        ('Fantasy'),
        ('dectective');

-- Insert data into the Genremovies table
INSERT INTO Genremovies(moviesId, genreId )
VALUES (1,1),
		(2,2),
        (1,3),
        (3,2),
        (3,4),
        (4,1),
        (4,5),
        (4,6),
        (5,7),
        (5,2);

DELIMITER $
CREATE PROCEDURE addUser(
IN uName varchar(50),
uPass varchar(50),
email varchar(100)
)
BEGIN
  insert into Users(userName,passWord,email) values(uName,uPass,email);
END $


ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123321';

INSERT INTO Episodes (moviesId, name, numberEpisodes, moviesUrl)
VALUES
    (4, 'Episode 1',1, 'huongmattap1.mp4'),
    (4, 'Episode 2',2, 'huongmattap2.mp4'),
    (4, 'Episode 3',3, 'huongmattap3.mp4'),
    (1,'Episode 1',1,'50sacthai.mp4'),
    (2,'Episode 1',1,'caption.mp4'),
    (3,'Episode 1',1,'hauduetap1.mp4'),
    (3,'Episode 2',2,'hauduetap2.mp4'),
    (5,'Episode 1',1,'baongamtap1.mp4'),
    (5,'Episode 2',2,'baongamtap2.mp4'),
    (5,'Episode 3',3,'baongamtap3.mp4'),
    (5,'Episode 4',4,'baongamtap4.mp4')
    ;


SELECT * FROM Users
