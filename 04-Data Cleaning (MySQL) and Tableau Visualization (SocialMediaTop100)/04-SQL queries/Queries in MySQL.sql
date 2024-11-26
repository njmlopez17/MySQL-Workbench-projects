--  check records from table(s):
Select * from social_media.profile;
Select * from view_tmp_Profile where Cleaned IS NOT NULL;
Select * from social_media.profile where Profile like '<%';

-- ****DATA CLEANING****

-- (1) Remove special characters...

-- create temp table (view)
DROP VIEW IF EXISTS view_tmp_Profile;
CREATE VIEW view_tmp_Profile AS
SELECT
	p1.PrfID,
    p1.PlatformID,
    p1.Profile,
CASE
	WHEN SUBSTRING(p1.Profile, 1, locate('<', p1.Profile) -1) <> '' THEN SUBSTRING(p1.Profile, 1, locate('<', p1.Profile) -1)
    END AS Cleaned
FROM 
	social_media.profile as p1
;

-- from the view, find the record that requires an update
SELECT 
	* 
FROM 
	social_media.view_tmp_Profile p1
    JOIN
		social_media.profile as p2
	ON
		p1.PrfID = p2.PrfID
	AND
		p1.PlatformID = p2.PlatformID
	AND
		p1.Cleaned IS NOT NULL
;

-- update the main table with cleaned record value from the temp (view) table
UPDATE
	social_media.profile as p2
    JOIN
		social_media.view_tmp_Profile p1
		ON
			p1.PrfID = p2.PrfID
		AND
			p1.PlatformID = p2.PlatformID
		AND
			p1.Cleaned IS NOT NULL
SET
	p2.Profile = p1.Cleaned    
;

-- (2) Update and group undetermined record values...

-- Clean up the remaining record (update the Profile as “Others”)…
SELECT
	p1.PrfID,
    p1.Profile
FROM 
	social_media.view_tmp_Profile p1
WHERE p1.Profile LIKE '<%' 
;

-- update the main table with cleaned record value from the temp (view) table
UPDATE
	social_media.profile as p2
    JOIN
		social_media.view_tmp_Profile p1
		ON
			p1.PrfID = p2.PrfID
		AND
			p1.PlatformID = p2.PlatformID
		AND
			p1.Profile LIKE '<%' 
SET
	p2.Profile = 'Others'      
;
  
-- ****DATASET FOR VISUALIZATION****

-- 1. Total followers and posts of the Top 100 social media profile or people
SELECT
    SUM(tbl1.Followers) AS 'Total Followers',
    SUM(tbl2.Posts) AS 'Total Posts'
FROM
	social_media.followers tbl1
    JOIN
		social_media.posts tbl2
    ON
		tbl1.FlwID = tbl2.PstID
	AND
		tbl1.PlatformID = tbl2.PlatformID
ORDER BY
	1,2
;

-- 2. Social media account of known profile or people
SELECT
	tbl1.Profile,
    tbl2.Platform
FROM
	social_media.profile tbl1,
	social_media.platform tbl2
WHERE
	tbl1.PlatformID = tbl2.PltID
ORDER BY
tbl1.Profile
;

-- 3. Number of social media account of known profile or people
SELECT
	tbl1.Profile,
    COUNT(tbl2.Platform) AS SM_Count
FROM
	social_media.profile tbl1,
	social_media.platform tbl2
WHERE
	tbl1.PlatformID = tbl2.PltID
GROUP BY
	tbl1.Profile
ORDER BY
	SM_Count DESC
;

-- 4. Social media account of known profile or people and their number of followers (or subscribers)
SELECT
	tbl1.Profile,
    tbl2.Platform,
    tbl3.Followers
FROM
	social_media.profile tbl1
    JOIN
		social_media.platform tbl2
	JOIN
		social_media.followers tbl3
    ON
		tbl1.PrfId = tbl3.FlwID
	AND
		tbl1.PlatformID = tbl3.PlatformID
	AND
        tbl1.PlatformID = tbl2.PltID
ORDER BY
	tbl1.Profile
;

-- 5. Social media account of known profile or people and their number of posts (or videos)
SELECT
	tbl1.Profile,
    tbl2.Platform,
    tbl4.Posts
FROM
	social_media.profile tbl1
    JOIN
		social_media.platform tbl2
	JOIN
		social_media.posts tbl4
    ON
		tbl1.PrfId = tbl4.PstID
	AND
		tbl1.PlatformID = tbl4.PlatformID
	AND
        tbl1.PlatformID = tbl2.PltID
ORDER BY
	tbl1.Profile
;

-- 6. Top 40 social media account by number of followers (or subscribers) of known profile or people
SELECT
    tbl3.Followers,
    tbl2.Platform,
	tbl1.Profile
FROM
	social_media.profile tbl1
    JOIN
		social_media.platform tbl2
	JOIN
		social_media.followers tbl3
    ON
		tbl1.PrfId = tbl3.FlwID
	AND
		tbl1.PlatformID = tbl3.PlatformID
	AND
        tbl1.PlatformID = tbl2.PltID
ORDER BY
	tbl3.Followers DESC LIMIT 40
;

-- 7. Top 40 social media account by number of posts (or videos) of known profile or people
SELECT
    tbl4.Posts,
    tbl2.Platform,
	tbl1.Profile
FROM
	social_media.profile tbl1
    JOIN
		social_media.platform tbl2
	JOIN
		social_media.posts tbl4
    ON
		tbl1.PrfId = tbl4.PstID
	AND
		tbl1.PlatformID = tbl4.PlatformID
	AND
        tbl1.PlatformID = tbl2.PltID
ORDER BY
	tbl4.Posts DESC LIMIT 40
;

-- 8. Total number of followers (or subscribers) by social media
SELECT
    SUM(tbl3.Followers) AS Total_Followers,
    tbl2.Platform
FROM
	social_media.platform tbl2
	JOIN
		social_media.followers tbl3
    ON
		tbl2.PltID = tbl3.PlatformID
GROUP BY
	tbl2.Platform
;

-- 9. Total number of posts (or videos) by social media
SELECT
    SUM(tbl4.Posts) AS Total_Posts,
    tbl2.Platform
FROM
	social_media.platform tbl2
	JOIN
		social_media.posts tbl4
    ON
		tbl2.PltID = tbl4.PlatformID
GROUP BY
	tbl2.Platform
;









