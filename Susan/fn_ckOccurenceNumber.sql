/*An activity cannot have more than one occurrence in one day.*/

CREATE FUNCTION fn_ckOccurenceNumber()
RETURNS INT
AS 
BEGIN
	DECLARE @result INT = 0
	if EXISTS (SELECT ActivityID, CAST(OccurenceDate AS DATE), COUNT(*) 
				FROM ACTIVITY_OCCURENCE
				GROUP BY ActivityID, CAST(OccurenceDate AS DATE)
				HAVING COUNT(*) > 1)			
		SET @result = 1
		RETURN @result
END

ALTER TABLE ACTIVITY_OCCURENCE WITH NOCHECK
ADD CONSTRAINT ck_Conflict
CHECK(dbo.fn_ckOccurenceNumber() = 0) 