CREATE DATABASE Brights_excellence_academy;

USE Brights_excellence_academy;

-- View our data in the table --
SELECT * FROM students_data;

-- PART A: DATA CHECK/ UNDERSTANDING THE DATA
-- Confirm total count of records in our data --
SELECT COUNT(*) FROM students_data;

-- Understand our data types formats in the table--
DESCRIBE students_data;
	# Each and every record is accurately described to its corresponding data type per column defined

-- PART B: DATA CLEANING PROCUDEURES --
#1. Check for any DUPLICATES
SELECT Student_ID, COUNT(*) AS entries
FROM students_data
GROUP BY Student_ID
HAVING COUNT(*) > 1;
	# Using Student_ID as the common primary key identifier for our data records, there are no evidet duplicates in our data.

#2. Check for any MISSING RECORDS/ NULLS IN our data
SELECT * FROM students_data
WHERE Student_ID IS NULL
OR Age IS NULL
OR Major IS NULL
OR Primary_AI_Tool IS NULL
OR Task_Frequency_Daily IS NULL
OR Main_Usage_Case IS NULL
OR GPA_Baseline IS NULL
OR GPA_Post_AI IS NULL
OR Time_Saved_Hours_Weekly IS NULL
OR AI_Ethics_Concern IS NULL
OR Career_Confidence_Score IS NULL;

-- PART C: DATA EXPLORATION / FINDING INSIGHTS TO SOME QUESTIONS --
SELECT * FROM Students_data;
#Q1. Show all records for all students majoring in Software Engineering
SELECT * FROM students_data
WHERE Major = 'Software Engineering';

#Q2.Show all records for students majoring in either Software Engineering, Biology and Fine Arts
SELECT * FROM students_data
WHERE Major = 'Software Engineering'
OR Major ='Biology'
OR Major = 'Fine Arts';
-- The OR Operator is a LOGICAL OPERATOR that allows combination of two or more conditions in a Single QUERY!. Returns if at least if one condition is TRUE --

#Q3.Find the count of how many students use each Primary_AI_Tool
SELECT Primary_AI_Tool, COUNT(*) FROM students_data
GROUP BY Primary_AI_Tool;
-- GROUP BY Clause used to group together all rows with the same values in the specified column(Primary_AI_Tool)--

#Q4. List all unique Main_Usage_Cases and show respective counts for AI Tools by students in the data
SELECT DISTINCT Main_Usage_Case, COUNT(*)
FROM students_data
GROUP BY Main_Usage_Case;
-- DISTINCT keyword only shows unique values in the specified column (Main_Usage_Case)--

#Q5. Sort the data by GPA_Post_AI and Career_Confidence_Score in descending order and only show the top 20
SELECT * FROM students_data
ORDER BY GPA_Post_AI DESC, Career_Confidence_Score DESC
LIMIT 20; 
-- The ORDER BY Clause sorts the data in either Descending or Ascending order on the specified column(Career_Confidence_Score)--
-- The LIMIT Function specifies the rows to be displayed. In this case only 20 Rows specified--

#Q6. List all students by their students_id, major, hours_saved_weekly for those saving more than 10 hours/week.  Which majors benefit?
SELECT Student_ID, Major,Time_Saved_Hours_Weekly
FROM students_data
WHERE Time_Saved_Hours_Weekly > 10
ORDER BY Time_Saved_Hours_Weekly DESC;
-- Data Science, Software Engineering, Biology and Business Administration are the majors that benefit from hours saved when using AI Tools.--

-- To view which MAJOR HAS the highest frequency saved by Students by more than 10hours per week --
SELECT Student_ID, Major,Time_Saved_Hours_Weekly,
COUNT(*) OVER (PARTITION BY Major) AS Major_frequency
FROM students_data
WHERE Time_Saved_Hours_Weekly > 10
ORDER BY Major_frequency DESC;
-- When using AI Tools, Business Administration major has the highest frequency--

#Q7. Find maximum task_frequency_daily for each primary_ai_tool.
SELECT Primary_AI_Tool, MAX(Task_Frequency_Daily) AS Max_freq_tool
FROM students_data
GROUP BY Primary_AI_Tool;

#Q8. Display all records for students whose  gpa_post_ai is greater than their gpa_baseline
SELECT COUNT(*) AS Total_students_count
FROM students_data
WHERE GPA_Post_AI > GPA_Baseline;

-- Count of students whose GPA basline did not improve post AI
SELECT COUNT(*) AS Total_Students_count
FROM students_data
WHERE GPA_Post_AI < GPA_Baseline;

#Q9. Compute the proportion in terms of percentages of the students based on performace pre and post AI tools Usage
SELECT COUNT(*)  AS Total_students_records,
	SUM(CASE WHEN GPA_Post_AI > GPA_Baseline THEN 1 ELSE 0 END),
	ROUND(SUM(CASE WHEN GPA_Post_AI > GPA_Baseline THEN 1 ELSE 0 END) * 100.0/COUNT(*),2) AS Improved_student_performance,
    
    SUM(CASE WHEN GPA_Post_AI < GPA_Baseline THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN GPA_Post_AI < GPA_Baseline THEN 1 ELSE 0 END) * 100.0/COUNT(*),2) AS Declined_student_performance,
    
    SUM(CASE WHEN GPA_Post_AI = GPA_Baseline THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN GPA_Post_AI = GPA_Baseline THEN 1 ELSE 0 END) * 100.0/COUNT(*),2) AS No_student_improvement
    FROM Students_data;
    
#Q10. From the listed Primary AI Tools, which tool is associated with the highest proportion of GPA Improvement.
SELECT Primary_AI_Tool,
	COUNT(*) AS All_students_users,
		ROUND(AVG(CASE WHEN GPA_Post_AI > GPA_Baseline THEN 1 ELSE 0 END) * 100.0/COUNT(*),2) AS Improved_proportion,
        ROUND(AVG(CASE WHEN GPA_Post_AI < GPA_Baseline THEN 1 ELSE 0 END) * 100.0/COUNT(*),2) AS Declined_proportion,
        ROUND(AVG(GPA_Post_AI - GPA_Baseline),3) AS Avg_gpa_change,
        ROUND(STDDEV(GPA_Post_AI - GPA_Baseline),3) AS Avg_gpa_deviation
FROM Students_data
GROUP BY Primary_AI_Tool
HAVING COUNT(*)>=10
ORDER BY Improved_proportion DESC;

#Q11. Identify the top 3 students per major with the highest Career Confidence Score.
WITH ranked_students AS (
    SELECT 
        Student_ID,
        Major,
        Career_Confidence_Score,
        ROW_NUMBER() OVER (
            PARTITION BY Major 
            ORDER BY Career_Confidence_Score DESC
        ) AS rank_position
    FROM students_data
)
SELECT 
    Student_ID,
    Major,
    Career_Confidence_Score,
    rank_position
FROM ranked_students
WHERE rank_position <= 3
ORDER BY rank_position;

-- In order to handle tied ranking positions of the majors, we use the DENSE RANK() Function --
WITH ranked_students AS (
	SELECT Student_ID, Major,Career_Confidence_Score,
		DENSE_RANK() OVER (PARTITION BY Major ORDER BY Career_Confidence_Score DESC) AS rank_position
    FROM students_data
)
SELECT Student_ID, Major, Career_Confidence_Score, rank_position
FROM ranked_students
WHERE rank_position <= 3
ORDER BY Major,rank_position;


#Q12. Obtain the ranks of the Majors by their average Career Confidence Score
WITH majors_by_avgs AS(
	SELECT Major, AVG(Career_Confidence_Score) AS avg_confidence_score
FROM students_data
GROUP BY Major
)
SELECT Major, ROUND(avg_confidence_score,2) AS avg_confidence_score,
	RANK() OVER (ORDER BY avg_confidence_score DESC) AS major_position
FROM majors_by_avgs
ORDER BY major_position; 

    
    





SELECT * FROM students_data;

