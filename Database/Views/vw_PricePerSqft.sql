IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vw_PricePerSqft')
	DROP VIEW dbo.vw_PricePerSqft
GO

CREATE VIEW dbo.vw_PricePerSqft
AS

SELECT
    Price,
    Sqft,
    RegionId
FROM dbo.Properties
WHERE Price IS NOT NULL 
        AND Sqft IS NOT NULL 
        AND PropertyType NOT IN (2,8) --Exclude lands
        AND Sqft > 100 -- Some records seems to be corrupted.

GO