IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = 'TransformRawPropertyData' AND ROUTINE_TYPE = 'PROCEDURE')
	DROP PROCEDURE dbo.TransformRawPropertyData
GO

CREATE PROCEDURE dbo.TransformRawPropertyData

AS

CREATE TABLE #batch (Id INT PRIMARY KEY);

BEGIN TRY
    BEGIN TRAN;

        INSERT INTO #batch (Id)
        SELECT TOP (500) PRD.Id
        FROM dbo.PropertiesRawData PRD
            LEFT JOIN [dbo].[Properties] P on P.PropertyId = PRD.PropertyId
        WHERE PRD.ProcessedAt IS NULL
            AND P.PropertyId IS NULL
        ORDER BY PRD.CreatedAt;

        INSERT INTO [dbo].[Properties]
            ([PropertyId]
            ,[PropertyType]
            ,[RegionId]
            ,[Price]
            ,[Beds]
            ,[FullBaths]
            ,[PartialBaths]
            ,[TotalBaths]
            ,[Sqft]
            ,[LotSize]
            ,[YearBuilt]
            ,[DaysOnMarket]
            ,[HoaDues]
            ,[HasVirtualTour]
            ,[IsNewConstruction]
            ,[LastSoldDate]
            ,[City]
            ,[BrokerName]
            ,[CreatedAt])
        SELECT 
	        JSD.PropertyId,
            JSD.PropertyType,
            HRD.RegionId,
            JSD.Price,
            JSD.Beds,
            JSD.FullBaths,
            JSD.PartialBaths,
            JSD.TotalBaths,
            JSD.Sqft,
            JSD.LotSize,
            JSD.YearBuilt,
            JSD.DaysOnMarket,
            JSD.HoaDues,
            JSD.HasVirtualTour,
            JSD.IsNewConstruction,
            JSD.LastSoldDate,
            JSD.City,
            JSD.BrokerName,
            GETDATE()
        FROM dbo.PropertiesRawData HRD
        JOIN #batch B on B.Id = HRD.Id
        CROSS APPLY OPENJSON(JsonData, '$.homeData')
        WITH (
	        PropertyId BIGINT '$.propertyId',
	        PropertyType INT '$.propertyType',
	        Price INT '$.priceInfo.amount',
	        BrokerName NVARCHAR(64) '$.brokers.listingBrokerAndAgent.brokerName',
	        Beds INT '$.beds',
	        City NVARCHAR(64) '$.addressInfo.city',
	        HasVirtualTour BIT '$.listingMetadata.hasVirtualTour',
	        HoaDues INT '$.hoaDues.amount',
	        FullBaths INT '$.fullBaths',
	        PartialBaths INT '$.partialBaths',
	        TotalBaths DECIMAL(3,1) '$.bathInfo.computedTotalBaths',
	        YearBuilt INT '$.yearBuilt.yearBuilt',
	        IsNewConstruction BIT '$.listingMetadata.isNewConstruction',
	        LotSize INT '$.lotSize.amount',
	        Sqft INT '$.sqftInfo.amount',
	        DaysOnMarket INT '$.daysOnMarket.daysOnMarket',
	        LastSoldDate DATETIME '$.lastSaleData.lastSoldDate'

        ) JSD

        UPDATE HRD
        SET ProcessedAt = SYSDATETIME()
        FROM dbo.PropertiesRawData HRD
        JOIN #batch b ON HRD.Id = b.Id;

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH


RETURN 
GO