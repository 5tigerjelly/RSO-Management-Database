SELECT * INTO PEOPLE FROM CUSTOMER_BUILD.dbo.tblCUSTOMER

EXEC AddPeople 20

DECLARE @count INT = 50
WHILE (@count > 0) 
	BEGIN
		-- these will fail often, but that is expected
		EXEC [dbo].[PopulateActivityLocation]
		EXEC [dbo].[AddActivityMaterial]
		EXEC [dbo].[AddPersonActivity]
		EXEC [dbo].[AddSubgroupPersonRole]
		SET @count = (@count - 1)
	END