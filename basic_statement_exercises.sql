-- 1. Use the albums_db database.
SHOW databases;
USE albums_db;

-- 2. What is the primary key for the albums table?
-- albums
-- 3. What does the column named 'name' represent?
-- It represents the albumn title.

-- 4. What do you think the sales column represents?
-- The sales column represents the amount of albums sold

-- 5. Find the name of all albums by Pink Floyd.
SHOW databases;
USE albums_db;
SELECT * FROM albums
WHERE artist = 'Pink FLoyd';

-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SHOW databases;
USE albums_db;
SELECT * FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- 1967
-- 7. What is the genre for the album Nevermind?
SHOW databases;
USE albums_db;
SELECT * FROM albums
WHERE name = "Nevermind"
-- Grunge, Alternative rock

-- 8. Which albums were released in the 1990s?
SHOW databases;
USE albums_db;
SELECT * FROM albums
WHERE release_date BETWEEN 1990 and 1999;

-- 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SHOW databases;
USE albums_db;
SELECT * FROM albums
WHERE sales <= 19;

