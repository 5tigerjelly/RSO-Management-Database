/*
 * Only admins can make changes to a sub_group
 * This function returns a Bool, wether or not the person is an admin
 */

CREATE FUNCTION dbo.ck_checkPriveleges (@PersonID, @SubGroupID)
RETURNS int
AS
BEGIN
     DECLARE @Priveleged int;
     SET @Priveleged = (
               SELECT COUNT(*) 
                    FROM Person P
                         JOIN SUBGROUP_PERSON SGP
                              ON P.PersonID = SGP.PersonID
                         JOIN SUB_GROUP SG
                              ON SGP.SubGroupID = SG.SubGroupID
                         JOIN SUBGROUP_PERSON_ROLE SGPR
                              ON SGP.GroupPersonID = SGPR.GroupPersonID
                         JOIN [ROLE] R
                              ON SGPR.RoleID = R.RoleID
                    WHERE P.PersonID = @PersonID
                         AND SG.SubGroupID = @SubGroupID
                         AND R.RoleName like '%admin%' 
               )
     IF (@Priveleged > 0)
          RETURN(1)
     RETURN(@Priveleged);
END;
