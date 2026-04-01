IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vw_AvgPricePerYearBuild')
	DROP VIEW dbo.vw_AvgPricePerYearBuild
GO

CREATE VIEW dbo.vw_AvgPricePerYearBuild
AS

SELECT 
    RegionId,
    CONCAT(
        (YearBuilt / 10) * 10,
        ' - ',
         (YearBuilt / 10) * 10 + 10    
    ) AS YearBuiltRange,   
    AVG(CAST(PricePerSqft AS DECIMAL(12,2))) AS AvgPrice,
    count(YearBuilt) as NumberOfProperties
FROM dbo.Properties
WHERE Price IS NOT NULL
    AND YearBuilt > 1000 -- Some records seems to be corrupted.
GROUP BY 
    RegionId, 
    (YearBuilt / 10) * 10

GO