
-- 1) What grades are stored in the database?
-- SELECT * from grade;

-- 2) What emotions may be associated with a poem?
-- SELECT * from emotion;

-- 3) How many poems are in the database?
/*
SELECT COUNT(P.id) as PoemCount
	FROM Poem p;
*/

-- 4) Sort authors alphabetically by name. What are the names of the top 76 authors?
/*
SELECT TOP 76 a.Name
	FROM Author a
ORDER BY a.Name;
*/


-- 5) Starting with the above query, add the grade of each of the authors.
/*
SELECT TOP 76 a.Name, g.Name
	FROM Author a, Grade g
ORDER BY a.Name;
*/



-- 6) Starting with the above query, add the recorded gender of each of the authors.
-- Author grade id is = to grade id
-- JOIN You're telling it where it needs to meet so the data can talk to each other
-- This tables both exist, and join is how they can meet
/*
SELECT TOP 76 a.Name, g.Name, gen.Name
	FROM Author a
	JOIN Grade g on a.GradeId = g.Id
	JOIN Gender gen on a.GenderId = gen.Id
ORDER BY a.Name;
*/


-- 7) What is the total number of words in all poems in the database?
-- COUNT counts the column
-- SUM is adding up what is inside the column
/*
SELECT SUM(p.WordCount)
	From Poem p;
*/

-- 8) Which poem has the fewest characters?
/*
SELECT p.Title, p.CharCount
	FROM Poem p
WHERE p.CharCount = (SELECT min(p.CharCount)
FROM Poem p);
*/

-- 9) How many authors are in the third grade?
/*
SELECT COUNT(a.Id)
	FROM Author a
JOIN Grade g on a.GradeId = g.Id
WHERE g.Id = 3;
*/

-- 10) How many authors are in the first, second or third grades?
/*
SELECT COUNT(a.Id)
	FROM Author a
JOIN Grade g ON a.GradeId = g.Id
WHERE g.Id = 1 or g.Id = 2 or g.Id = 3;
*/

-- 11) What is the total number of poems written by fourth graders?
/*
SELECT COUNT(Poem.Id)
	From Poem
JOIN Author ON Poem.AuthorId = Author.Id
WHERE GradeId = 4;
*/

-- 12) How many poems are there per grade?
/*
SELECT COUNT(Poem.Id) as PoemsPerGrade
	From Poem
JOIN Author ON Poem.AuthorId = Author.Id
--WHERE GradeId = 1 OR GradeId = 2 OR GradeId = 3 OR GradeId = 4 OR GradeId = 5
GROUP BY GradeId;
*/

-- 13) How many authors are in each grade? (Order your results by grade starting with 1st Grade)
/*
SELECT g.Name as Grade, COUNT(ar.Id) as AuthorsInEachGrade
	FROM Author ar
JOIN Grade g ON GradeId = g.Id
GROUP BY g.Name;
*/
-- 14) What is the title of the poem that has the most words?
/*
SELECT p.Title, p.WordCount
	FROM Poem p
WHERE p.WordCount = (
	SELECT MAX(p.WordCount)
	FROM Poem p
);
*/

-- 15) Which author(s) have the most poems? (Remember authors can have the same name.)
/*
SELECT a.Id as AuthorID, a.Name as AuthorName, COUNT(p.Id) as NumOfPoems
	From Author a
JOIN Poem p on a.Id = p.AuthorId
GROUP BY p.AuthorId, a.Name, a.Id
ORDER BY NumOfPoems DESC;
*/

-- 16) How many poems have an emotion of sadness?
/*
SELECT COUNT(p.id) as PoemsOfSadness
FROM Poem p
JOIN PoemEmotion pe On p.id = pe.PoemId
JOIN Emotion emo ON pe.EmotionId = emo.Id
WHERE emo.Name = 'Sadness';

SELECT COUNT(pe.id) as PoemsOfSadness
FROM PoemEmotion pe
JOIN Emotion emo ON pe.EmotionId = emo.Id
WHERE emo.Name = 'Sadness';


SELECT COUNT(pe.PoemId) as PoemsOfSadness
FROM PoemEmotion pe
WHERE pe.Id = 3;

SELECT COUNT(p.Id) As NullPoems
FROM PoemEmotion
*/

-- 17) How many poems are not associated with any emotion?
-- WHERE is to select and HAVING is assoc with GROUP BY
/*
SELECT COUNT(Poem.id) as PoemsNoEmotion
FROM Poem
LEFT JOIN PoemEmotion ON Poem.id = PoemEmotion.PoemId
LEFT JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
WHERE Emotion.Name IS NULL;
*/

-- 18) Which emotion is associated with the least number of poems?
-- JOIN <Table you want to join> ON <Start with where you were(POEM) to(=) table you want to join>
-- <What key you want to compare to each other PK FK> 
-- COUNT is an aggregrate function. More than one in SELECT, will need a GROUP BY
-- default is 
/*
SELECT TOP 1 COUNT(p.Id) as LeastEmotion, emo.Name as Emotion 
From Poem p
LEFT JOIN PoemEmotion pe ON p.id = pe.PoemId
LEFT JOIN Emotion emo ON pe.EmotionId = emo.Id
GROUP BY emo.Name
HAVING emo.Name IS NOT NULL
ORDER BY LeastEmotion;
*/
-- 19) Which grade has the largest number of poems with an emotion of joy?\
/*
SELECT TOP 1 COUNT(Poem.Id) as Poems, Grade.Name, Emotion.Name
	FROM Poem 
	JOIN Author ON Poem.AuthorId = Author.Id
	JOIN Grade ON Author.GradeId = Grade.Id
	JOIN PoemEmotion ON Poem.Id = PoemEmotion.PoemId
	JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
GROUP BY Grade.Name, Emotion.Name
HAVING Emotion.Name = 'Joy'
ORDER BY Poems desc;
*/
-- 20) Which gender has the least number of poems with an emotion of fear?
/*
SELECT TOP 1 COUNT(p.ID) as PoemsOfFear, gen.Name, emo.Name 
	FROM Poem p
	JOIN Author au ON p.AuthorId = au.Id
	JOIN Gender gen ON au.GenderId = gen.Id
	JOIN PoemEmotion pe ON p.Id = pe.PoemId
	JOIN Emotion emo ON pe.EmotionId = emo.Id
GROUP BY gen.Name, emo.Name
HAVING emo.Name = 'Fear'
ORDER BY PoemsOfFear;
*/
