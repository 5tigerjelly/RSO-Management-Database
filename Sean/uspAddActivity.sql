
CREATE PROCEDURE uspAddActivity
@ActivityName varchar(150), 
@ActivityCost numeric(6,2), 
@ActivityDescr varchar(300),
@ActivityTypeName varchar(150)
AS
DECLARE @ActivityTypeID INT = (
	SELECT at.ActivityTypeID
	FROM ACTIVITY_TYPE at
	WHERE at.ActivityTypeName = @ActivityTypeName
)
BEGIN TRAN T2
	INSERT INTO group_4.dbo.ACTIVITY([ActivityTypeID], [ActivityName], 
		[ActivityCost], [ActivityDesc])
	VALUES (@ActivityTypeID, @ActivityName, @ActivityCost, @ActivityDescr)

IF @@error <> 0
	Rollback TRAN T2
ELSE
	Commit TRAN T2