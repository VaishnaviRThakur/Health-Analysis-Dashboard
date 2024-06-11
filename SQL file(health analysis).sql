create database hospital;
use hospital;
-- count and percent  female vs male having OCD -- & average obsession by gender
select * from ocd_patient_dataset;
WITH data as(
 select	gender,
count(`Patient ID`) as patient_count,
avg(`Y-BOCS Score (Obsessions)`) as avg
from ocd_patient_dataset
group by 1
order by 2)

select sum(case when gender="Female" then patient_count else 0 end) as female_count,
	sum(case when gender="Male" then patient_count else 0 end) as male_count ,
    round(sum(case when gender="Female" then patient_count else 0 end)/
    (sum(case when gender="Female" then patient_count else 0 end)+sum(case when gender="Male" then patient_count else 0 end))*100,2) as percent_female,
	round(sum(case when gender="Male" then patient_count else 0 end)/
    (sum(case when gender="Female" then patient_count else 0 end)+sum(case when gender="Male" then patient_count else 0 end))*100,2) as percent_male
 from data;


-- COUNT patients BY ETHNICITES and their respective AVERAGE OBSESSION SCORE
select ethnicity,count(*) as patient_count,
avg(`Y-BOCS Score (Obsessions)`) as obs_score
from ocd_patient_dataset
group by 1;

-- no.of people diagnosed with OCD MOM(month over month)
alter table ocd_patient_dataset
modify `OCD Diagnosis Date` date; -- changing format from text to date


SET @@sql_mode = SYS.LIST_DROP(@@sql_mode, 'ONLY_FULL_GROUP_BY');
SELECT @@sql_mode;

select 
date_format(`OCD Diagnosis Date`,'%Y-%m-01 00:00:00') as month,   -- we dont want day,ignoring
count(*) as patient_count
-- `OCD Diagnosis Date`
from ocd_patient_dataset
group by 1
order by 1;


-- whats most commom obsession type (count) and its repsective avg obession score
select `Obsession Type`, count(`Patient ID`) as patient_count ,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obsession_score
from ocd_patient_dataset
group by 1
order by 2
-- limit 1
;

-- whats most commom compulsion type (count) and its repsective avg obession score
select `Compulsion Type`, count(`Patient ID`) as patient_count ,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obsession_score
from ocd_patient_dataset
group by 1
order by 2 
-- limit 1
;