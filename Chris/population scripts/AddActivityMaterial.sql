CREATE PROCEDURE [dbo].[AddActivityMaterial]
AS
BEGIN
	DECLARE @MaterialID INT
	DECLARE @ActivityID INT

	DECLARE @Dig1 varChar (20)
	DECLARE @Rand Numeric (16,16)

	SELECT @RAND = RAND()
	SET @Dig1 = @rand

	SET @ActivityID = (SELECT SUBSTRING(@Dig1, 9, 1))--random number 1~13
	SET @MaterialID = (SELECT SUBSTRING(@Dig1, 6, 1))--random number 1~24
	
	INSERT INTO ACTIVITY_MATERIAL (ActivityID, MaterialID)
	VALUES (@ActivityID, @MaterialID)
END