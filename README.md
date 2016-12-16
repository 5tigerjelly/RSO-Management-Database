# Student RSO Management Database
![alt tag](http://i.imgur.com/VWx3DHm.png)

```sql
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
```
##Buiseness Rule
All members with the role of ‘Treasurer’ within a group is 
forbidden on going on a trip to Hawaii (zipcode 96701 ~ 96898) 
during December because they must work on the Christmas event. 
If they have went in the past, well there is nothing we can 
do about that.
```sql


CREATE FUNCTION fn_NoGoHawaii (@PersonID INT)
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0
IF EXISTS(
	SELECT * 
	FROM PERSON P 
	JOIN SUBGROUP_PERSON SP ON P.PersonID = SP.PersonID
	JOIN SUBGROUP_PERSON_ROLE SPR ON SPR.GroupPersonID = SP.GroupPersonID
	JOIN [ROLE] R ON R.RoleID = SPR.RoleID
	JOIN PERSON_ACTIVITY PA ON PA.PersonID = P.PersonID
	JOIN ACTIVITY_OCCURENCE AO ON AO.ActivityOccurenceID = PA.ActivityOccurenceID
	JOIN ACTIVITY A ON A.ActivityID = AO.ActivityID
	JOIN ACTIVITY_LOCATION AL ON AL.ActivityID = A.ActivityID
	JOIN LOCATION L ON L.LocationID = AL.LocationID
	JOIN [ADDRESS] AD ON AD.AddressID = L.AddressID
	
	WHERE R.RoleName like '%Treasurer%'
	AND (SELECT MONTH(AO.OccurenceDate)) = 12
	AND AD.ZipCode between '96701' AND '96898'
	)
	SET @Ret = 1
	RETURN @Ret
END

ALTER TABLE PERSON_ACTIVITY WITH NOCHECK
ADD CONSTRAINT ck_tresNoGoHawaii
CHECK (dbo.fn_NoGoHawaii (PersonID) = 0)
```

##Data Population Script
```sql
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
```
Each team will conceive, diagram, code and populate a database from scratch.

Create a conceptual and logical entity-relationship diagram (ERD) for your database project using best-practices presented in lecture as well as obtained from class readings.
