CREATE PROCEDURE [dbo].[PopulateActivityLocation]
AS
BEGIN
	DECLARE @addressID INT
	DECLARE @locationID INT
	DECLARE @ActivityID INT

	DECLARE @Dig1 varChar (20)
	DECLARE @Rand Numeric (16,16)

	SELECT @RAND = RAND()
	SET @Dig1 = @rand

	SET @addressID = (SELECT AddressID FROM ADDRESS WHERE AddressID = (SELECT SUBSTRING(@Dig1, 9, 1)))--random number 1~99

	SET @locationID = (SELECT locationID FROM LOCATION WHERE AddressID = @addressID)

	IF (@locationID IS NULL)
		BEGIN
			INSERT INTO LOCATION (LocationName, AddressID)
				VALUES ('LocationName', @addressID)
			SET @locationID = (SELECT SCOPE_IDENTITY())
		END

	SET @ActivityID = (SELECT SUBSTRING(@Dig1, 9, 1))--random number 1~13

	INSERT INTO ACTIVITY_LOCATION (ActivityID, LocationID)
	VALUES (@ActivityID, @locationID)
END