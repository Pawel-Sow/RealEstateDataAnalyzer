IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vw_KPI')
	DROP VIEW dbo.vw_KPI
GO

CREATE VIEW dbo.vw_KPI
AS

SELECT DISTINCT
    RegionId,
    AVG(Price) 
        OVER (PARTITION BY RegionId) AS AvgPrice,
    cast(AVG(PricePerSqft) 
        OVER (PARTITION BY RegionId) AS INT) AS AvgPricePerSqft,
    AVG(DaysOnMarket) 
        OVER (PARTITION BY RegionId) AS AvgDaysOnMarket,
    PERCENTILE_DISC(0.5) 
        WITHIN GROUP (ORDER BY Price)
        OVER (PARTITION BY RegionId) AS MedianPrice
FROM dbo.Properties
WHERE Price IS NOT NULL
GO