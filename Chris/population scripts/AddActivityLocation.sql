CREATE PROCEDURE [dbo].[AddActivityLocation]
@LocationName varchar(50),
@address varchar(50),
@zip char(5),
@ActivityID int

AS
BEGIN
	DECLARE @addressID INT
	DECLARE @locationID INT

	DECLARE @Dig1 varChar (20)
	DECLARE @Rand Numeric (16,16)

	SELECT @RAND = RAND()
	SET @Dig1 = @rand

	SET @addressID = (SELECT AddressID FROM ADDRESS WHERE Street = @address AND ZipCode = @zip)

	IF (@addressID IS NULL)
		BEGIN
			INSERT INTO ADDRESS (Street, ZipCode)
				VALUES (@address, @zip)
			SET @addressID = (SELECT SCOPE_IDENTITY())
		END

	SET @locationID = (SELECT @locationID FROM LOCATION WHERE AddressID = @addressID)

	IF (@locationID IS NULL)
		BEGIN
			INSERT INTO LOCATION (LocationName, AddressID)
				VALUES (@LocationName, @addressID)
			SET @locationID = (SELECT SCOPE_IDENTITY())
		END

	INSERT INTO ACTIVITY_LOCATION (ActivityID, LocationID)
	VALUES (@ActivityID, @locationID)
END