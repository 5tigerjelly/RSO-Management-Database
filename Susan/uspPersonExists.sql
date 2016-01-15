CREATE PROCEDURE uspPersonExists @FirstName varchar(30), @LastName varchar(30), @EmailAdd char(30)
AS
SELECT PersonID 
FROM PERSON 
WHERE PersonFName = @FirstName
AND PersonLName = @LastName 
AND EmailAddress = @EmailAdd