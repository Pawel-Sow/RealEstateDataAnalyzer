IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vw_AvgPricePerCity')
	DROP VIEW dbo.vw_AvgPricePerCity
GO

CREATE VIEW dbo.vw_AvgPricePerCity
AS

SELECT 
    City,
    RegionId,
    AVG(CAST(Price AS DECIMAL(12,2))) AS AvgPrice
FROM dbo.Properties
WHERE Price IS NOT NULL
GROUP BY City, RegionId

GO