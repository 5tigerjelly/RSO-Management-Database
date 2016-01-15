/*All members with the role of ‘Treasurer’ within a group is 
forbidden on going on a trip to Hawaii (zipcode 96701 ~ 96898) 
during December because they must work on the Christmas event. 
If they have went in the past, well there is nothing we can 
do about that.*/

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
