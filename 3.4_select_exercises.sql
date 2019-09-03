3.  Structure of albums_db:
CREATE TABLE `albums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `artist` varchar(240) DEFAULT NULL,
  `name` varchar(240) NOT NULL,
  `release_date` int(11) DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `genre` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

SQL Code Used:


use albums;

SELECT * from albums;

SELECT * FROM albums WHERE artist='Pink Floyd';

SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

SELECT genre FROM albums WHERE name='Nevermind';

SELECT * FROM albums WHERE release_date BETWEEN 1990 AND 1999;

SELECT * FROM albums WHERE sales < 20;

-- Does not include genres "Hard Rock" and "Progressive Rock" because it searches for the specific genre "Rock", not the words
SELECT * FROM albums WHERE genre = 'Rock';