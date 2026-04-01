IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vw_AvgDaysOnMarketPerPropertyType')
	DROP VIEW dbo.vw_AvgDaysOnMarketPerPropertyType
GO

CREATE VIEW dbo.vw_AvgDaysOnMarketPerPropertyType
AS

SELECT 
    PropertyType,
    RegionId,
    AVG(DaysOnMarket) AS AvgDaysOnMarket
FROM dbo.Properties
WHERE DaysOnMarket IS NOT NULL
GROUP BY PropertyType, RegionId

GO