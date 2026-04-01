IF NOT EXISTS (SELECT 1 FROM dbo.Regions where RegionId = '6_29470')
BEGIN
    INSERT INTO dbo.Regions(RegionId, RegionName) VALUES ('6_29470', 'Chicago') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.Regions where RegionId = '6_23554')
BEGIN
    INSERT INTO dbo.Regions(RegionId, RegionName) VALUES ('6_23554', 'Hudson') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.Regions where RegionId = '6_11203')
BEGIN
    INSERT INTO dbo.Regions(RegionId, RegionName) VALUES ('6_11203', 'Los Angeles') 
END

IF NOT EXISTS (SELECT 1 FROM dbo.Regions where RegionId = '6_30749')
BEGIN
    INSERT INTO dbo.Regions(RegionId, RegionName) VALUES ('6_30749', 'New York') 
END