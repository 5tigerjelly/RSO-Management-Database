CREATE PROCEDURE [dbo].[AddSubgroupPersonRole]
AS
BEGIN
	DECLARE @PersonID INT
	DECLARE @SubGroupID INT
	DECLARE @ActivityID INT
	DECLARE @GroupPersonID INT
	DECLARE @RoleID INT

	DECLARE @Dig1 varChar (20)
	DECLARE @Rand Numeric (16,16)

	SELECT @RAND = RAND()
	SET @Dig1 = @rand
	
	SET @PersonID = (SELECT SUBSTRING(@Dig1, 7, 2))--random number 1~100
	SET @SubGroupID = (SELECT SUBSTRING(@Dig1, 9, 1))--random number 1~5
	SET @RoleID = (SELECT SUBSTRING(@Dig1, 4, 1))--random number 1~24
	
	INSERT INTO SUBGROUP_PERSON (SubGroupID, PersonID, BeginDate)
	VALUES (@SubGroupID, @PersonID, GetDate())
	SET @GroupPersonID = (SELECT SCOPE_IDENTITY())
	
	INSERT INTO SUBGROUP_PERSON_ROLE (GroupPersonID, RoleID, BeginDate)
	VALUES (@GroupPersonID, @RoleID,GetDate())
END