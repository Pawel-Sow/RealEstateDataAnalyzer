IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vw_AvgPricePerPropertyType')
	DROP VIEW dbo.vw_AvgPricePerPropertyType
GO

CREATE VIEW dbo.vw_AvgPricePerPropertyType
AS

SELECT 
    P.PropertyType as PropertyTypeId,
    ISNULL(PTM.[Name], 'Unknown') AS PropertyTypeMappingName,
    P.RegionId,
    AVG(CAST(P.Price AS DECIMAL(12,2))) AS AvgPrice
FROM dbo.Properties P
LEFT JOIN dbo.PropertyTypeMapping PTM ON P.PropertyType = PTM.PropertyTypeId 
WHERE Price IS NOT NULL
GROUP BY PropertyType, ISNULL(PTM.[Name], 'Unknown'),  RegionId

GO