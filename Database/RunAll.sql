/***
  *  Description:
  *  This script should contain all data and table definitions required for RealEstateDataAnalyzer database.
     This script can be run multiple times. 

***/

:setvar BasePath "C:\Projects\RealEstateDataAnalyzer\RealEstateDataAnalyzer\Database"

:r $(BasePath)\Schemas\01_Tables.sql
:r $(BasePath)\Schemas\02_Indexes.sql

:r $(BasePath)\Seed\01_Regions.sql
:r $(BasePath)\Seed\02_PropertyTypeMapping.sql

:r $(BasePath)\Procedures\sp_TransformRawPropertyData.sql

:r $(BasePath)\Views\vw_AvgDaysOnMarketPerPropertyType.sql
:r $(BasePath)\Views\vw_AvgPricePerCity.sql
:r $(BasePath)\Views\vw_AvgPricePerPropertyType.sql
:r $(BasePath)\Views\vw_AvgPricePerYearBuild.sql
:r $(BasePath)\Views\vw_KPI.sql
:r $(BasePath)\Views\vw_PriceHistogram.sql
:r $(BasePath)\Views\vw_PricePerSqft.sql