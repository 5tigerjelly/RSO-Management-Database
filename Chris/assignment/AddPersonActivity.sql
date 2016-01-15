CREATE PROCEDURE [dbo].[AddPersonActivity]

@Fname varchar(50),
@Lname varchar(50),
@Activityname varchar(100),
@OccuerenceCost Numeric(10,2),
@OccuerenceDate date

AS
BEGIN
	DECLARE @PersonID INT
	DECLARE @ActivityID INT
	DECLARE ActivityOccurenceID INT

	SET @PersonID = (SELECT PersonID FROM PERSON P WHERE P.PersonFname = @Fname AND P.PersonLname = @Lname)
	SET @ActivityID = (SELECT @ActivityID FROM ACTIVITY A WHERE A.Activityname = @Activityname)

	INSERT INTO ACTIITY_OCCURENCE (ActivityID, OccuerenceCost,OccurenceDate)
	VALUES (@ActivityID, @OccuerenceCost, @OccuerenceDate)
	SET @ActivityOccurenceID = (SELECT SCOPE_IDENTITY())
	
	INSERT INTO PERSON_ACTIVITY (PersonID, ActivityOccurenceID)
	VALUES (@PersonID, @ActivityOccurenceID)
END