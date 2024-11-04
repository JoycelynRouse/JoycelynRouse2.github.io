#)1) Employee Satisfaction and Patient Outcomes Correlation
#Business Problem:
	#Understanding and analyzing the relationship between employee performance and patient outcomes can help prioritize training for underperforming staff or reward 
    #high-performing employees. If a strong link between employee satisfaction and patient outcomes is found, HR can focus more on employee engagement strategies
    #to boost care quality.
    
#1a) How does employee satisfaction affect patient outcomes?
SELECT employee.satisfied AS employee_satisfaction,
	  AVG( patient.quality_of_life_score) AS avg_patient_satisfaction_score,
      COUNT(patient_id) AS number_of_patients
FROM employee_patient.patient AS patient
JOIN employee_patient.employee AS employee
	ON employee.emp_id = patient.emp_id
GROUP BY employee_satisfaction; 

#1b) Is there a correlation between employee job level or rating and the quality of patient care?
SELECT employee.job_level AS employee_job_level,
	   employee.rating AS employee_rating,
	   AVG(patient.quality_of_life_score) AS avg_patient_quality_care_score,
       COUNT(patient.patient_id) AS number_of_patients
FROM employee_patient.employee AS employee
JOIN employee_patient.patient AS patient
	ON employee.emp_id = patient.emp_id
GROUP BY employee_job_level, employee_rating
ORDER BY employee_job_level, employee_rating;
       
#1c) Do employees with certifications or awards provide better patient care?
SELECT employee.awards AS employee_award,
	   employee.certifications AS employee_certifications,
       AVG(patient.quality_of_life_score) AS avg_patient_quality_care_score,
       COUNT(patient.patient_id) AS number_of_patients
FROM employee_patient.employee AS employee
JOIN employee_patient.patient AS patient
	ON employee.emp_id = patient.emp_id
GROUP BY employee_award, employee.certifications
ORDER BY  employee_award, employee.certifications;

#2) Employee Retention and Recruitment Efficiency
#Business Problem:
	#High employee turnover and dissatisfaction can affect patient care quality, making it essential to recruit the right candidates from effective sources.
    #Recruitment strategies can be adjusted based on which sources yield long-term, satisfied, and high-performing employees.
    
#2a) How does the recruitment source affect employee job satisfaction?
SELECT employee.recruitment_type AS employee_recruitment,
	  AVG(employee.satisfied)*100 AS avg_employee_satisfaction_percent,
      COUNT(employee.emp_id) AS employee_count
FROM employee_patient.employee AS employee
GROUP BY employee_recruitment 
ORDER BY avg_employee_satisfaction_percent;

#2b) Are employees from certain educational backgrounds more likely to have higher satisfaction?
SELECT
	CASE 
        WHEN employee.education = 'UG' THEN 'Undergraduate'
        WHEN employee.education = 'PG' THEN 'Postgraduate'
        ELSE 'Other'
    END AS employee_college_education,
	AVG(employee.satisfied)*100 AS avg_employee_satisfaction,
	COUNT(employee.emp_id) AS employee_count
FROM employee_patient.employee AS employee
GROUP BY employee_college_education;

#2c) Provide insights into how employee salaries vary by department.
SELECT employee.dept AS department,
	   AVG(employee.salary) AS avg_employee_salary
FROM employee_patient.employee AS employee
GROUP BY department
ORDER BY avg_employee_salary;

#2d) Provide insights into how employee salaries vary by location.
SELECT employee.location AS location,
	   AVG(employee.salary) AS avg_employee_salary
FROM employee_patient.employee AS employee
GROUP BY location
ORDER BY avg_employee_salary;

#3) Resource Allocation for Chronic Disease Management
#Business Problem:
	#Proper resource allocation is crucial for chronic disease management. Identifying areas of improvement can help prioritize resource distribution to
    #ensure patient health. By improving chronic disease management in underperforming areas, you can potentially lower healthcare costs and increase patient 
    #satisfaction.
    
#3a) Which departments manage the highest number of patients with chronic diseases, and how effective are they?
SELECT employee.Dept AS department,
	   COUNT(patient.patient_id) AS number_of_patients,
       AVG(patient.quality_of_life_score) AS avg_patient_quality_score
FROM employee_patient.patient AS patient
JOIN employee_patient.employee AS employee
GROUP BY department
ORDER BY number_of_patients desc;

#3b) Identify employees with salaries above the average salary in their department and rank them by salary
SELECT employee.emp_id,
       employee.salary,
       AVG(employee.salary) OVER (PARTITION BY employee.dept) AS avg_department_salary,
       RANK() OVER (ORDER BY employee.salary DESC) AS salary_rank
FROM employee_patient.employee AS employee
WHERE employee.salary > AVG(employee.salary) OVER (PARTITION BY employee.dept);

#4) Diagnosis Trends Over Time
#Business Problem:
	#Identifying long-term trends in diagnosis rates can help forecast future demand for healthcare services and allocate resources appropriately. 
    #Analyzing time-based trends can help healthcare organizations prepare for future spikes in demand and create more effective preventative care campaigns to 
    #reduce chronic disease incidence
    
#4a) How do diagnosis trends for diseases evolve over time? Are new diagnoses increasing or decreasing?
SELECT patient.chronic_disease AS disease,
	   YEAR(patient.diagnosis_date) AS year_diagnosed,
       COUNT(patient.patient_id) AS number_of_diagnosis
FROM employee_patient.patient AS patient
GROUP BY year_diagnosed, disease;

