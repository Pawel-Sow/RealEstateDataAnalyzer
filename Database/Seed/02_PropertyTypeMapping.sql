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