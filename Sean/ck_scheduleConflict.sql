/*2. Definition of a business rule

One person cannot be in two places at once. Therefore, the user will be notified when
he or she is trying to schedule an activity for themselves that occurs at the same time
as another one that is already scheduled. 

*/

/*3. One (1) user-defined function to enforce the business rule defined above*/
CREATE FUNCTION fn_checkScheduleConflict(
@PersonFName varchar(50), @PersonLName varchar(50),
@OccurenceDate DATETIME, @LocationName varchar(50))
RETURNS INT
AS
BEGIN
	DECLARE @RET INT = 0
	IF EXISTS(
		SELECT A.ActivityName 
		FROM ACTIVITY A
		JOIN ACTIVITY_LOCATION AL ON A.ActivityID = AL.ActivityID
		JOIN LOCATION L ON AL.LocationID = L.LocationID
		JOIN ACTIVITY_OCCURENCE AO ON A.ActivityID = AO.ActivityID
		JOIN PERSON_ACTIVITY PA ON AO.ActivityOccurenceID = PA.ActivityOccurenceID
		JOIN PERSON P ON PA.PersonID = P.PersonID
		WHERE L.LocationName = @LocationName AND 
		AO.OccurenceDate = @OccurenceDate AND
		P.PersonFName = @PersonFName AND
		P.PersonLName = @PersonLName
	)
	SET @RET = 1
	RETURN @RET
END