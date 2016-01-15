CREATE PROCEDURE uspInsertPerson @FName varchar(30), @LName varchar(30), @Phone INT, @areacode INT, @Email char(30)
AS 
BEGIN
	DECLARE @ID INT
	DECLARE @PhoneID INT

	EXEC @PhoneID = AddPhone @areacode = @areacode, @phone = @phone
	EXEC @ID = uspPersonExists @FirstName = @FName, @LastName = @LName, @EmailAdd = @Email

	IF @ID <> NULL 
		PRINT('Person Exists')
	ELSE 
		BEGIN
			PRINT('New person')
      INSERT INTO PERSON (PersonFName, PersonLName, PhoneID, EmailAddress)
        VALUES(@FName, @LName, @PhoneID, @Email) 
    END
END 


