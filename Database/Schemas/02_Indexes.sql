IF NOT EXISTS (select 1 from sys.indexes where name = N'IX_Properties_City')
BEGIN
    CREATE INDEX IX_Properties_City
    ON dbo.Properties(City);
END
GO

IF NOT EXISTS (select 1 from sys.indexes where name = N'IX_Properties_PropertyType')
BEGIN
    CREATE INDEX IX_Properties_PropertyType
    ON dbo.Properties(PropertyType);
END 
GO

IF NOT EXISTS (select 1 from sys.indexes where name = N'IX_PropertiesRawData_ProcessedAt')
BEGIN
    CREATE INDEX IX_PropertiesRawData_ProcessedAt 
    ON dbo.PropertiesRawData(ProcessedAt);
END
GO