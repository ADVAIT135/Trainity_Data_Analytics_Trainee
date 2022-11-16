/* Case Study - 1 : Job Data
Task (A): Number of jobs reviewed: Amount of jobs reviewed over time.
Your task: Calculate the number of jobs reviewed per hour per day for November 2020?
*/
use job_data;
select * from job_data;

-- non_distinct jobs reviewed per day
select count(job_id)/(30*24) as number_of_jobs_reviewed_per_day_non_distinct
from job_data;

-- distinct jobs reviewed per day
select count(distinct job_id)/(30*24) as number_of_jobs_reviewed_per_day_distinct
from job_data;
/*
Task (B) : Throughput: It is the no. of events happening per second.
Your task: Let’s say the above metric is called throughput. Calculate 7 day rolling average of throughput?
For throughput, do you prefer daily metric or 7-day rolling and why?
*/

-- seven day rolling average of throughput for distinct job_id
SELECT ds as date_of_review, jobs_reviewed, 
AVG(jobs_reviewed) 
OVER(ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS throughput_7_rolling_average
FROM ( SELECT ds, COUNT( DISTINCT job_id) AS jobs_reviewed FROM job_data GROUP BY ds ORDER BY ds ) a;

-- seven day rolling average of throughput for non-distinct job_id
SELECT ds as date_of_review, jobs_reviewed, 
AVG(jobs_reviewed) 
OVER(ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS throughput_7_rolling_average_non_distinct_job_id
FROM ( SELECT ds, COUNT(job_id) AS jobs_reviewed FROM job_data GROUP BY ds ORDER BY ds ) a;




/*
Task (C) : Percentage share of each language: Share of each language for different contents.
Your task: Calculate the percentage share of each language?
*/
-- percentage of share of language 
select job_data.job_id, job_data.language,count(job_data.language) as total_of_each_language,((count(job_data.language)/(select count(*) from job_data))*100) as percentage_share_of_each_language 
from job_data
group by job_data.language;

-- percentage of share of distinct language 
select job_data.job_id, job_data.language,count(distinct job_data.language) as total_of_each_language,((count(job_data.language)/(select count(*) from job_data))*100) as percentage_share_of_each_distinct_language 
from job_data
group by job_data.language;

/*
Task (D) : Duplicate rows: Rows that have the same value present in them.
Your task: Let’s say you see some duplicate rows in the data. How will you display duplicates from the table?
*/

SELECT * FROM 
(SELECT *, ROW_NUMBER()OVER(PARTITION BY job_id) AS row_num
FROM job_data) a 
WHERE row_num>1;

