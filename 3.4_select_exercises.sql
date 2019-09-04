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

-- Selects all from the albums table
SELECT * from albums;

-- Selects the name of all albums by Pink Floyd
SELECT * FROM albums WHERE artist='Pink Floyd';

-- Selects the year Sgt. Peppers Lonelyn Hearts Club Band was released
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- Selects the genre for the album Nevermind
SELECT genre FROM albums WHERE name='Nevermind';

-- Selects albums that were released in the 1990s
SELECT * FROM albums WHERE release_date BETWEEN 1990 AND 1999;

-- Selects albums which had less than 20 million certiied sales
SELECT * FROM albums WHERE sales < 20;

-- Does not include genres "Hard Rock" and "Progressive Rock" because it searches for the word "Rock" by itself.  "%Rock%" would search for anything containing itf
SELECT * FROM albums WHERE genre = 'Rock';
