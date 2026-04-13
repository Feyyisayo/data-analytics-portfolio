HumanResources.Employee, Person.Person, HumanResources.EmployeeDepartmentHistory, HumanResources.Department, HumanResources.Shift 
 
1. List 20 employees with their full name and JobTitle. 
SELECT TOP 20 
 e.BusinessEntityID, 
 p.FirstName + ' ' + p.LastName AS EmployeeName, 
 e.JobTitle 
FROM HumanResources.Employee e 
JOIN Person.Person p 
 ON e.BusinessEntityID = p.BusinessEntityID 
ORDER BY e.BusinessEntityID; 

2. Show each employee with their current department name. 
SELECT TOP 50 
 p.FirstName + ' ' + p.LastName AS EmployeeName, 
 d.Name AS DepartmentName 
FROM HumanResources.Employee e 
JOIN Person.Person p 
 ON e.BusinessEntityID = p.BusinessEntityID 
JOIN HumanResources.EmployeeDepartmentHistory edh 
 ON e.BusinessEntityID = edh.BusinessEntityID 
JOIN HumanResources.Department d 
 ON edh.DepartmentID = d.DepartmentID 
WHERE edh.EndDate IS NULL 
ORDER BY EmployeeName; 

3. Count how many employees are in each current department. 
SELECT 
 d.Name AS DepartmentName, 
 COUNT(edh.BusinessEntityID) AS EmployeeCount 
FROM HumanResources.Department d 
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh 
 ON d.DepartmentID = edh.DepartmentID 
 AND edh.EndDate IS NULL 
GROUP BY d.Name 
ORDER BY EmployeeCount DESC; 

4. List employees who have worked in more than one department (based on EmployeeDepartmentHistory). 
SELECT 
 e.BusinessEntityID, 
 p.FirstName + ' ' + p.LastName AS EmployeeName, 
 COUNT(DISTINCT edh.DepartmentID) AS DeptCount 
FROM HumanResources.Employee e 
JOIN Person.Person p 
 ON e.BusinessEntityID = p.BusinessEntityID 
JOIN HumanResources.EmployeeDepartmentHistory edh
Group 3 - Answers Page 1 
 ON e.BusinessEntityID = edh.BusinessEntityID 
GROUP BY e.BusinessEntityID, p.FirstName, p.LastName 
HAVING COUNT(DISTINCT edh.DepartmentID) > 1 
ORDER BY DeptCount DESC; 

5. Show each employee and the shift name they currently work on. 
SELECT TOP 50 
 p.FirstName + ' ' + p.LastName AS EmployeeName, 
 s.Name AS ShiftName 
FROM HumanResources.Employee e 
JOIN Person.Person p 
 ON e.BusinessEntityID = p.BusinessEntityID 
JOIN HumanResources.EmployeeDepartmentHistory edh 
 ON e.BusinessEntityID = edh.BusinessEntityID 
JOIN HumanResources.Shift s 
 ON edh.ShiftID = s.ShiftID 
WHERE edh.EndDate IS NULL 
ORDER BY EmployeeName; 

6. Find employees who do not have any department history records (if any). 
SELECT 
 e.BusinessEntityID, 
 p.FirstName + ' ' + p.LastName AS EmployeeName 
FROM HumanResources.Employee e 
JOIN Person.Person p 
 ON e.BusinessEntityID = p.BusinessEntityID 
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh 
 ON e.BusinessEntityID = edh.BusinessEntityID 
WHERE edh.BusinessEntityID IS NULL 
ORDER BY e.BusinessEntityID; 

7. For each department, list the earliest start date of any employee in that department. 
SELECT 
 d.Name AS DepartmentName, 
 MIN(edh.StartDate) AS EarliestStartDate 
FROM HumanResources.EmployeeDepartmentHistory edh 
JOIN HumanResources.Department d 
 ON edh.DepartmentID = d.DepartmentID 
GROUP BY d.Name 
ORDER BY EarliestStartDate; 

8. List employees hired in 2013 and show their department name (current or last known). 
SELECT 
 p.FirstName + ' ' + p.LastName AS EmployeeName, 
 e.HireDate, 
 d.Name AS DepartmentName 
FROM HumanResources.Employee e 
JOIN Person.Person p 
 ON e.BusinessEntityID = p.BusinessEntityID 
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh 
 ON e.BusinessEntityID = edh.BusinessEntityID 
 AND edh.EndDate IS NULL 
LEFT JOIN HumanResources.Department d 
 ON edh.DepartmentID = d.DepartmentID 
WHERE e.HireDate >= '2013-01-01' 
 AND e.HireDate < '2014-01-01' 
ORDER BY e.HireDate; 

9. Show each employee and how many department changes they have had
SELECT 
 e.BusinessEntityID, 
 p.FirstName + ' ' + p.LastName AS EmployeeName,  COUNT(edh.DepartmentID) AS DeptHistoryRows 
FROM HumanResources.Employee e 
JOIN Person.Person p 
 ON e.BusinessEntityID = p.BusinessEntityID 
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh  ON e.BusinessEntityID = edh.BusinessEntityID GROUP BY e.BusinessEntityID, p.FirstName, p.LastName ORDER BY DeptHistoryRows DESC; 

10. List departments that currently have zero employees (if any). 
SELECT 
 d.Name AS DepartmentName 
FROM HumanResources.Department d 
LEFT JOIN HumanResources.EmployeeDepartmentHistory edh  ON d.DepartmentID = edh.DepartmentID 
 AND edh.EndDate IS NULL 
WHERE edh.BusinessEntityID IS NULL 
ORDER BY d.Name;

