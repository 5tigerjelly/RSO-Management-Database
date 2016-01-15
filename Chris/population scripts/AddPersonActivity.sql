CREATE PROCEDURE [dbo].[AddPersonActivity]
AS
BEGIN
	DECLARE @PersonID INT
	DECLARE @ActivityID INT
	DECLARE @ActivityOccurenceID INT

	DECLARE @Dig1 varChar (20)
	DECLARE @Rand Numeric (16,16)

	SELECT @RAND = RAND()
	SET @Dig1 = @rand


	SET @PersonID = (SELECT SUBSTRING(@Dig1, 7, 2))--random number 1~100
	SET @ActivityID = (SELECT SUBSTRING(@Dig1, 6, 1))--random number 1~13

	INSERT INTO ACTIVITY_OCCURENCE (ActivityID, OccurenceCost,OccurenceDate)
	VALUES (@ActivityID, (SELECT SUBSTRING(@Dig1, 3, 2)), GetDate())
	SET @ActivityOccurenceID = (SELECT SCOPE_IDENTITY())
	
	INSERT INTO PERSON_ACTIVITY (PersonID, ActivityOccurenceID)
	VALUES (@PersonID, @ActivityOccurenceID)
END