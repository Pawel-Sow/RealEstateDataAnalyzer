/***
  *  Description:
  *  This script should contain all data and table definitions required for RealEstateDataAnalyzer database.
     This script can be run multiple times. 

***/










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


IF NOT EXISTS (SELECT 1 FROM dbo.PropertyTypeMapping where PropertyTypeId = '2')
BEGIN
    INSERT INTO dbo.PropertyTypeMapping(PropertyTypeId, [Name]) VALUES ('2', 'Land / Other') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.PropertyTypeMapping where PropertyTypeId = '3')
BEGIN
    INSERT INTO dbo.PropertyTypeMapping(PropertyTypeId, [Name]) VALUES ('3', 'Condo') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.PropertyTypeMapping where PropertyTypeId = '4')
BEGIN
    INSERT INTO dbo.PropertyTypeMapping(PropertyTypeId, [Name]) VALUES ('4', 'Multi-family') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.PropertyTypeMapping where PropertyTypeId = '5')
BEGIN
    INSERT INTO dbo.PropertyTypeMapping(PropertyTypeId, [Name]) VALUES ('5', 'Multi-family (BIG)') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.PropertyTypeMapping where PropertyTypeId = '6')
BEGIN
    INSERT INTO dbo.PropertyTypeMapping(PropertyTypeId, [Name]) VALUES ('6', 'House') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.PropertyTypeMapping where PropertyTypeId = '8')
BEGIN
    INSERT INTO dbo.PropertyTypeMapping(PropertyTypeId, [Name]) VALUES ('8', 'Land') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.PropertyTypeMapping where PropertyTypeId = '10')
BEGIN
    INSERT INTO dbo.PropertyTypeMapping(PropertyTypeId, [Name]) VALUES ('10', 'Townhouse') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.PropertyTypeMapping where PropertyTypeId = '13')
BEGIN
    INSERT INTO dbo.PropertyTypeMapping(PropertyTypeId, [Name]) VALUES ('13', 'Co-op') 
END