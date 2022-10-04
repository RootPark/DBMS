#1
SELECT name
FROM Pokemon
WHERE type LIKE 'Grass'
ORDER BY name;

#2
SELECT name
FROM Trainer
WHERE hometown LIKE 'Brown City' or hometown LIKE 'Rainbow City'
ORDER BY name;

#3
SELECT DISTINCT type
FROM Pokemon
ORDER BY type;

#4
SELECT name
FROM City
WHERE name LIKE 'B_%'
ORDER BY name;

#5
SELECT hometown
FROM Trainer
WHERE name NOT LIKE 'M_%'
ORDER BY hometown;

#6
SELECT nickname
FROM CatchedPokemon
WHERE level = (SELECT MAX(level) FROM CatchedPokemon)
ORDER BY nickname;

#7
SELECT name
FROM Pokemon
WHERE name LIKE 'a_%' or name LIKE 'e_%' or name LIKE 'i_%' or name LIKE 'o_%' or name LIKE 'u_%'
ORDER BY name;

#8
SELECT AVG(level)
FROM CatchedPokemon;

#9
SELECT MAX(level)
FROM CatchedPokemon
WHERE owner_id = (SELECT id FROM Trainer WHERE name ='Yellow') 
ORDER BY nickname;

#10
SELECT DISTINCT hometown
FROM Trainer
ORDER BY hometown;

#11
SELECT Trainer.name, CatchedPokemon.nickname
FROM Trainer, CatchedPokemon
WHERE Trainer.id = CatchedPokemon.owner_id and CatchedPokemon.nickname LIKE 'A_%'
ORDER BY Trainer.name;

#12
SELECT Trainer.name
FROM City, Gym, Trainer
WHERE City.description = 'Amazon' and Gym.city = City.name and Gym.leader_id = Trainer.id;

#13
SELECT DISTINCT owner_id, COUNT(pid) AS c
FROM CatchedPokemon
WHERE pid 
IN (SELECT id
	FROM Pokemon
	WHERE type = 'Fire'
	)
GROUP BY owner_id
ORDER BY c DESC
LIMIT 1;

#14
SELECT type
FROM(
	SELECT type, MAX(id) AS id
	FROM Pokemon
	WHERE LENGTH(id) = 1
	GROUP BY type
	)t
ORDER BY id DESC;

#15
SELECT COUNT(*)
FROM Pokemon
WHERE type NOT LIKE 'Fire';

#16
SELECT Pokemon.name
FROM Pokemon, Evolution
WHERE Evolution.before_id > Evolution.after_id and Evolution.before_id = Pokemon.id
ORDER BY Pokemon.name;

#17
SELECT AVG(CatchedPokemon.level)
FROM CatchedPokemon, Pokemon
WHERE Pokemon.type = 'Water';

#18
SELECT DISTINCT CatchedPokemon.nickname
FROM CatchedPokemon, Trainer, Gym
WHERE CatchedPokemon.level = (SELECT MAX(CatchedPokemon.level) FROM CatchedPokemon, Trainer, Gym WHERE CatchedPokemon.owner_id = Gym.leader_id);

#19
SELECT Trainer.name
FROM Trainer 
JOIN CatchedPokemon
ON Trainer.id = CatchedPokemon.owner_id
WHERE Trainer.hometown = 'Blue City'
GROUP BY CatchedPokemon.owner_id
HAVING AVG(CatchedPokemon.level) >= ALL(
	SELECT AVG(CatchedPokemon.level)
	FROM Trainer
	JOIN CatchedPokemon
	ON Trainer.id = CatchedPokemon.owner_id
	WHERE Trainer.hometown = 'Blue City'
	GROUP BY CatchedPokemon.owner_id)
ORDER BY Trainer.name;

#20
SELECT DISTINCT Pokemon.name
FROM Pokemon, CatchedPokemon, (SELECT DISTINCT id, hometown FROM Trainer) T, Evolution
WHERE Pokemon.id = CatchedPokemon.pid and CatchedPokemon.pid = Evolution.before_id and Pokemon.type = 'Electric' and
T.id = CatchedPokemon.owner_id;

#21
SELECT T.name, SUM(C.level)
FROM CatchedPokemon C
JOIN Gym G
ON C.owner_id = G.leader_id
JOIN Trainer T
ON C.owner_id = T.id
GROUP BY T.name
ORDER BY SUM(C.level) DESC;

#22
SELECT hometown
FROM Trainer
GROUP BY hometown
HAVING count(*) = (SELECT MAX(mycount) FROM (SELECT hometown, COUNT(*) AS mycount FROM Trainer GROUP BY hometown) AS result);

#23
SELECT Pokemon.name
FROM CatchedPokemon
JOIN Pokemon
ON CatchedPokemon.pid = Pokemon.id
JOIN Trainer
ON CatchedPokemon.owner_id = Trainer.id
WHERE Trainer.hometown = 'Sangnok City' or Trainer.hometown = 'Brown City'
GROUP BY CatchedPokemon.pid
HAVING COUNT(CatchedPokemon.pid)>=2
ORDER BY Pokemon.name;

#24
SELECT Trainer.name
FROM CatchedPokemon, Trainer, Pokemon
WHERE Trainer.hometown = 'Sangnok City' and CatchedPokemon.pid = Pokemon.id and Pokemon.name LIKE 'P_%' and Trainer.id = CatchedPokemon.owner_id
ORDER BY Trainer.name;

#25
SELECT Trainer.name, Pokemon.name
FROM Trainer, CatchedPokemon, Pokemon
WHERE Trainer.id = CatchedPokemon.owner_id and CatchedPokemon.pid = Pokemon.id
ORDER BY Trainer.name, Pokemon.name;

#26
SELECT P.name
FROM Pokemon P
JOIN Evolution E1
ON P.id = E1.before_id
LEFT JOIN Evolution E2
ON E1.before_id = E2.after_id
LEFT JOIN Evolution E3
ON E1.after_id = E3.before_id
WHERE E3.before_id IS NULL and E2.after_id is NULL
ORDER BY P.name;

#27
SELECT CatchedPokemon.nickname
FROM CatchedPokemon
JOIN Trainer
ON CatchedPokemon.owner_id = Trainer.id
JOIN Gym
ON Trainer.hometown = Gym.City
JOIN Pokemon
ON CatchedPokemon.pid = Pokemon.id
WHERE Trainer.id = Gym.leader_id and Pokemon.type = 'Water' and Trainer.hometown = 'Sangnok City'
ORDER BY CatchedPokemon.nickname;

#28
SELECT Trainer.name
FROM CatchedPokemon
JOIN Trainer ON CatchedPokemon.owner_id = Trainer.id
JOIN Evolution ON CatchedPokemon.pid = Evolution.after_id
GROUP BY owner_id
HAVING COUNT(*)>=3
ORDER BY Trainer.name;

#29
SELECT Pokemon.name
FROM Pokemon
LEFT JOIN CatchedPokemon
ON Pokemon.id = CatchedPokemon.pid
WHERE CatchedPokemon.nickname IS NULL
ORDER BY Pokemon.name;

#30
SELECT MAX(CatchedPokemon.level)
FROM CatchedPokemon
JOIN Trainer
ON CatchedPokemon.owner_id = Trainer.id
GROUP BY Trainer.hometown
ORDER BY MAX(CatchedPokemon.level) DESC;

#31
SELECT P1.id, P1.name AS firstName, P2.name AS secondName, P3.name AS thirdName
FROM Pokemon P2
JOIN Evolution E1
ON P2.id = E1.before_id
JOIN Evolution E2
ON E1.before_id = E2.after_id
JOIN Pokemon P1
ON E2.before_id = P1.id
JOIN Pokemon P3
ON E1.after_id = P3.id
ORDER BY P1.id;