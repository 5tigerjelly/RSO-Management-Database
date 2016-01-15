/*1. Two (2) stored procedures to populate transactional tables*/

CREATE PROCEDURE uspAddActivityType 
@ActivityTypeName varchar(60), @ActivityTypeDescr varchar(300)
AS 
BEGIN TRAN T1
	INSERT INTO group_4.dbo.ACTIVITY_TYPE([ActivityTypeName], [ActivityTypeDescription])
	VALUES (@ActivityTypeName, @ActivityTypeDescr)

IF @@error <> 0
	Rollback TRAN T1
ELSE
	Commit TRAN T1