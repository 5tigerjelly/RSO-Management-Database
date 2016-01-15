CREATE PROCEDURE uspRemoveParticipants @ActivityOccurenceID INT
AS 
BEGIN 
DECLARE @Count INT
SET @Count = (SELECT COUNT(*) FROM PERSON_ACTIVITY WHERE ActivityOccurenceID = @ActivityOccurenceID)
WHILE @Count > 0 
DELETE FROM PERSON_ACTIVITY WHERE ActivityOccurenceID = @ActivityOccurenceID 
SET @Count = @Count - 1
END