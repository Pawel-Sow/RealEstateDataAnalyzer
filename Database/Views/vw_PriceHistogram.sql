IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'vw_PriceHistogram')
	DROP VIEW dbo.vw_PriceHistogram
GO

CREATE VIEW dbo.vw_PriceHistogram
AS

SELECT TOP(100)
    RegionId,
	Count(PropertyId) AS CountProperties,
	PriceRange,
	PriceSort
FROM
(
	SELECT
		RegionId,
		PropertyId,
		Price,
		CASE 
			WHEN Price < 1000000 THEN
				CONCAT(
					(Price / 100000) * 1,
					'00K - ',
					(Price / 100000) * 1 + 1,
					'00K'
				)
			ELSE 
				CONCAT(
					(Price / 1000000) * 1,
					'M - ',
					(Price / 1000000) * 1 + 1,
					'M'
				)
			END
		AS PriceRange,
		CASE 
			WHEN Price < 1000000 THEN
				(Price / 100000) * 100000
			ELSE 
				(Price / 1000000) * 1000000
			END
		AS PriceSort
	FROM dbo.Properties
	WHERE Price IS NOT NULL
) V1
GROUP BY RegionId, PriceRange, PriceSort
ORDER BY PriceSort

GO