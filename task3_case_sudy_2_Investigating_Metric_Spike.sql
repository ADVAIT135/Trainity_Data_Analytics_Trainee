/**
Data Analytics Trainnee Trainity Task 3: Case Study 2: Investigating metric spike
**/

/**
Question A: User Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service.
Your task: Calculate the weekly user engagement?
**/

-- Viewing the events table
select * from tutorial.yammer_events;


-- Running the Query
SELECT 
  extract (week from occurred_at) as week_num_user,
  count(distinct user_id)
FROM 
  tutorial.yammer_events
group by 
  week_num_user;
  
/**
Question B: User Growth: Amount of users growing over time for a product.
Your task: Calculate the user growth for product?
**/

-- User Growth = Number of active users per week 

-- Viewng the table
SELECT * from tutorial.yammer_users;


-- Running the Query 
select 
  year_num,
  week_num,
  num_active_users,
  SUM(num_active_users)OVER(ORDER BY year_num, week_num ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_active_users
from
(
select 
  extract (year from a.activated_at) as year_num,
  extract (week from a.activated_at) as week_num,
  count(distinct user_id) as num_active_users
from 
  tutorial.yammer_users a 
WHERE
  state = 'active'
group by year_num,week_num
order by year_num,week_num
) a;

-- counting users from user table having state as active
select count(*) from tutorial.yammer_users
where state = 'active';


/**
Question C : Weekly Retention: Users getting retained weekly after signing-up for a product.
Your task: Calculate the weekly retention of users-sign up cohort?
**/

SELECT
distinct user_id,
COUNT(user_id),
SUM(CASE WHEN retention_week = 1 Then 1 Else 0 END) as per_week_retention
FROM 
(
SELECT
a.user_id,
a.signup_week,
b.engagement_week,
b.engagement_week - a.signup_week as retention_week
FROM 
(
(SELECT distinct user_id, extract(week from occurred_at) as signup_week from tutorial.yammer_events
WHERE event_type = 'signup_flow'
and event_name = 'complete_signup'
--and extract(week from occurred_at) = 18
)a 

LEFT JOIN

(SELECT distinct user_id, extract (week from occurred_at) as engagement_week FROM tutorial.yammer_events
where event_type = 'engagement'
)b 
on a.user_id = b.user_id
)
)d 
group by user_id
order by user_id
;

-- specifying the week number as 18
SELECT
distinct user_id,
COUNT(user_id),
SUM(CASE WHEN retention_week = 1 Then 1 Else 0 END) as per_week_retention
FROM 
(
SELECT
a.user_id,
a.signup_week,
b.engagement_week,
b.engagement_week - a.signup_week as retention_week
FROM 
(
(SELECT distinct user_id, extract(week from occurred_at) as signup_week from tutorial.yammer_events
WHERE event_type = 'signup_flow'
and event_name = 'complete_signup'
and extract(week from occurred_at) = 18
)a 

LEFT JOIN

(SELECT distinct user_id, extract (week from occurred_at) as engagement_week FROM tutorial.yammer_events
where event_type = 'engagement'
)b 
on a.user_id = b.user_id
)
)d 
group by user_id
order by user_id
;








/**
Question D : Weekly Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service weekly.
Your task: Calculate the weekly engagement per device?
**/

SELECT 
  extract(year from occurred_at) as year_num,
  extract(week from occurred_at) as week_num,
  device,
  COUNT(distinct user_id) as no_of_users
FROM 
  tutorial.yammer_events
where event_type = 'engagement'
GROUP by 1,2,3
order by 1,2,3;

/**
Question E : Email Engagement: Users engaging with the email service.
Your task: Calculate the email engagement metrics?
**/

SELECT
  100.0*SUM(CASE when email_cat = 'email_opened' then 1 else 0 end)/SUM(CASE when email_cat = 'email_sent' then 1 else 0 end) as email_opening_rate,
  100.0*SUM(CASE when email_cat = 'email_clicked' then 1 else 0 end)/SUM(CASE when email_cat = 'email_sent' then 1 else 0 end) as email_clicking_rate
FROM 
(
SELECT 
  *,
  CASE 
    WHEN action in ('sent_weekly_digest','sent_reengagement_email')
      then 'email_sent'
    WHEN action in ('email_open')
      then 'email_opened'
    WHEN action in ('email_clickthrough')
      then 'email_clicked'
  end as email_cat
from tutorial.yammer_emails
) a;

