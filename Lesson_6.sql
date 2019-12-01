/*������������ ������� �� ���� ����������, ����������, ���������� � �����������. ��������� �������. 
� - ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.*/
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

-- � - ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..

SELECT count(*) FROM likes
WHERE media_id IN (SELECT id FROM media 
	WHERE user_id IN (SELECT user_id FROM profiles
		WHERE YEAR(CURDATE()) - YEAR(birthday) < 10
	)
);

-- � - ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

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