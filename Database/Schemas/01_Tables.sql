IF NOT EXISTS(select 1 from INFORMATION_SCHEMA.TABLES where table_name = 'Regions')
BEGIN

CREATE TABLE [dbo].[Regions](
	[RegionId] [nvarchar](16) NOT NULL,
	[RegionName] [nvarchar](128) NOT NULL,
    CONSTRAINT [PK_Regions] PRIMARY KEY CLUSTERED 
    (
	    [RegionId] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO


IF NOT EXISTS(select 1 from INFORMATION_SCHEMA.TABLES where table_name = 'Properties')
BEGIN
    CREATE TABLE dbo.Properties
    (
        Id INT IDENTITY(1,1) NOT NULL,
    
        -- Business key
        PropertyId BIGINT NOT NULL,

        RegionId NVARCHAR(16) NOT NULL,
        -- Core data
        PropertyType INT NULL,
        Price INT NULL,
        PricePerSqft AS
            CASE 
                WHEN Sqft > 0 THEN Price * 1.0 / Sqft 
                ELSE NULL 
            END,
        Beds INT NULL,
        FullBaths INT NULL,
        PartialBaths INT NULL,
        TotalBaths DECIMAL(3,1) NULL,
        Sqft INT NULL,
        LotSize INT NULL,
        YearBuilt INT NULL,
        DaysOnMarket INT NULL,

        -- Financial / fees
        HoaDues INT NULL,

        -- Flags
        HasVirtualTour BIT NULL,
        IsNewConstruction BIT NULL,

        -- Dates
        LastSoldDate DATETIME2(0) NULL,

        -- Location (flattened)
        City NVARCHAR(64) NULL,

        -- Broker
        BrokerName NVARCHAR(128) NULL,

        -- Audit
        CreatedAt DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),

        CONSTRAINT PK_Properties PRIMARY KEY CLUSTERED (Id),

        CONSTRAINT FK_Properties_Regions FOREIGN KEY (RegionId) REFERENCES dbo.Regions(RegionId)
    );
END
GO


IF NOT EXISTS(select 1 from INFORMATION_SCHEMA.TABLES where table_name = 'PropertiesRawData')
BEGIN
    CREATE TABLE dbo.PropertiesRawData
    (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        PropertyId NVARCHAR(100) NOT NULL,
        RegionId NVARCHAR(16) NOT NULL,
        JsonData NVARCHAR(MAX) NOT NULL,
        CreatedAt DATETIME2(7) NOT NULL,
        ProcessedAt DATETIME2(7) NULL
    );
END

IF NOT EXISTS(select 1 from INFORMATION_SCHEMA.TABLES where table_name = 'PropertyTypeMapping')
BEGIN
    CREATE TABLE dbo.PropertyTypeMapping
    (
        PropertyTypeId INT NOT NULL,
        [Name] NVARCHAR(50) NOT NULL
    );
END
GO