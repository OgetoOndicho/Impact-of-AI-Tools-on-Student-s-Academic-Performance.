# Impact of AI Tools on Student's Academic Performance.
## About the Project.
This is an end to end Data Analytics project primarily utilizing MySQL to analyze data and quantify findings if use of AI tools has any effect on Students performance at Brights Excellence  Academy.
The advancement of technology in Artificial Intelligence and Machine Learning tools has found its way into learning institutions around the world. Statistics estimate that approximately 54% of students use AI on a daily or weekly basis. Overally, approximately 86% of students use multiple AI tools worldwide according to https://www.demandsage.com/ai-in-education-statistics/ report.
This project, uses sample data from a hypothetical institution (Brights Excellence Academy) aims to uncover if indeed use of AI tools has any effect on students Grade Point Average. Using data metrics such as GPA Baseline and GPA Post AI scores, career confidence, couse majors and the numbers of weekly saved hours, this project seeks to investigate student's performance post AI Tools use records any significant improvements on comparison with their baseline GPA scores (before AI Tools use).
The study also seeks to uncover if performance changes across the student population based on their respective average GPA Scores, and find out if use of AI affect students career confidence score.

## Project Objectives.
1. To investigate if use of Atificial Intelligeence tools affects the student's overall Grade Average Points Score.
2. To investigate if the use of Artificial Intelligence tools boosts  a students career confidence score.
3. To investgate which ae the most preferred Artificial Intelligence Tools and which of the AI Tools is associated with the highest scores as used by students at Brights Excellence Academy.
4. To determine under which main uses cases are AI Tools mostly peferred by students t Brights Excellence Academy.
5. To investigate any arising Ethic concerns in the school's Major departments on the use cases of AI Tools by Students.

## Outline and Procedure.
This project  followed a three procedural process.
### Part 1: Understanding the data
- Involved the process of schema definition. Case example using MySQL for databases and table creations to store the dataset, importing of the data accurately, verifications of accurate data records counts with their respective data types corectly in their places.

### Part 2: Data Cleaning and Standardizations.
- This phase ensured that data was thoroughly cleaned for duplicates, missing values and consistency in data types. A clean dataset ensures accurate results findings that truly reflect the intended purpose of the data.

### Part 3: Data Exploration.
- This was the final phase of the data analysis process. Involved writing of SQL Scripts to answe key business questions, uncover insights to facilitate true data analysis reporting on the predefined Project Objectives.


## Sample Questions for Data Analysis of the Project.
Q1. Show all records for students majoring in either Software Engineering, Biology and Fine Arts?
```sql
SELECT * FROM students_data
WHERE Major = 'Software Engineering'
OR Major ='Biology'
OR Major = 'Fine Arts';
```

Q2. Find the most popular Primary_AI_Tool used by students
```sql
SELECT Primary_AI_Tool, COUNT(*) FROM students_data
GROUP BY Primary_AI_Tool;
```
Out the 4 Primary AI Tools, Github Copilot is the most used with a total of 311 students from Brights Excellence Academy followed closely by Gemini Pro and Perplexity.

Q3. Which are some of the main use cases of AI Tools by Students?
```sql
SELECT DISTINCT Main_Usage_Case, COUNT(*)
FROM students_data
GROUP BY Main_Usage_Case;
```
A total of 384 students at Brights Excellence Academy used AI Tools majorly for examination preparations.

Q4. Find maximum task_frequency_daily for each primary_AI_tool.
```sql
SELECT Primary_AI_Tool, MAX(Task_Frequency_Daily) AS Max_freq_tool
FROM students_data
GROUP BY Primary_AI_Tool;
```
Each of the 4 AI Tools had a maximum daily frequency use cases of 10.



## Data Sources.
- The data was obtained from a secondary source in this case Kaggle Platform: https://www.kaggle.com/datasets/sohaibdevv/ai-and-student-life-2026-the-new-normal

## Tools Used
1. MySQL: For writing queries to  enable data cleaning, standardization and analysis.
2. PowerBI: For reporting through data visualizations.

