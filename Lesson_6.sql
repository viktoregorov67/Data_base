/*ѕрактическое задание по теме Уќператоры, фильтраци€, сортировка и ограничение. јгрегаци€ данныхФ. 
Х - ѕусть задан некоторый пользователь. »з всех друзей этого пользовател€ найдите человека, который больше всех общалс€ с нашим пользователем.*/
USE vk;

select 
	from_user_id
	, concat(u.firstname, ' ', u.lastname) as name
	, count(*) as 'messages count'
from messages m
join users u on u.id = m.from_user_id
where to_user_id = 1
group by from_user_id
order by count(*) desc
limit 5;

-- Х - ѕодсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT count(*) FROM likes
WHERE media_id IN (SELECT id FROM media 
	WHERE user_id IN (SELECT user_id FROM profiles
		WHERE YEAR(CURDATE()) - YEAR(birthday) < 10
	)
);

-- Х - ќпределить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT gender, count(*)
FROM (
	SELECT 
		user_id AS user,
		(
			SELECT gender 
			FROM profiles
			WHERE user_id = user
		) AS gender
	FROM likes
) AS dummy
GROUP BY gender;





select count(*) from likes
where media_id in (SELECT id FROM media 
	where user_id in (SELECT user_id FROM profiles
		where  YEAR(CURDATE()) - YEAR(birthday) < 10
	)
);