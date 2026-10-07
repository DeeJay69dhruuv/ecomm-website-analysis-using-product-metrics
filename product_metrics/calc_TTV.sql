-- TTV taken for each user
WITH main_table AS (
SELECT 
    user_id,
    DATEDIFF(MINUTE, MIN(CASE WHEN event_type = 'view' THEN event_time END), MIN(CASE WHEN event_type = 'purchase' THEN event_time END)) AS ttv
FROM dbo.Nov_2019
GROUP BY user_id
HAVING DATEDIFF(MINUTE, MIN(CASE WHEN event_type = 'purchase' THEN event_time END), MIN(CASE WHEN event_type = 'view' THEN event_time END)) IS NOT NULL
)
--CALCULATING THE percent of users taking more than a day of TTV
SELECT 
(SELECT COUNT(*) FROM main_table
WHERE ttv >1440)*1.0/(SELECT COUNT(*) FROM main_table) AS pct_taking_more_than_a_day;

--SPACE for category wise analysis on the TTV, which category incites a quick buy reaction & which incites a slower buy reaction


WITH side_table AS (
SELECT 
    category_code,
    DATEDIFF(MINUTE, MIN(CASE WHEN event_type = 'view' THEN event_time END), MIN(CASE WHEN event_type = 'purchase' THEN event_time END)) AS ttv
FROM dbo.Nov_2019
GROUP BY category_code
HAVING DATEDIFF(MINUTE, MIN(CASE WHEN event_type = 'purchase' THEN event_time END), MIN(CASE WHEN event_type = 'view' THEN event_time END)) IS NOT NULL
)
SELECT
    *
FROM side_table;