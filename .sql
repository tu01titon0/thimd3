drop database homestaydatabase;
create database homestaydatabase;
use homestaydatabase;
CREATE TABLE HomeStay (
	id int auto_increment unique,
    name varchar (255),
    country varchar(255),
    count_bedrooms int,
    price float,
    count_toilets int,
    description text
);
INSERT INTO HomeStay (name, country, count_bedrooms, price, count_toilets, description)
VALUES ('home stay 1', 'ha noi', 1, 123, 2, 'chao b'),
		('home stay 2', 'ha noi', 2, 123, 1, 'chao b2'),
        ('home stay 3', 'ha noi', 3, 123, 3, 'chao b4');
        INSERT INTO HomeStay (name, country, count_bedrooms, count_toilets, description, price)
        VALUES ('tu', 'hanoi', 1, 2, '33333', 123.3);



select * from HomeStay where id = 1