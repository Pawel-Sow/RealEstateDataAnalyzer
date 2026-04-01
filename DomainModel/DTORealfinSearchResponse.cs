namespace DomainModel
{
    public record DTORealfinSearchResponse(int status_code, int resultsPerPage, DtoDatum[] data, int limit, string message, int currentPage, bool status);

    public record DtoDatum(DtoHomedata homeData);

    public record DtoHomedata(
        string propertyId,
        string listingId,
        int listingDisplayLevel,
        string mlsId,
        string url,
        string dataSourceId,
        string marketId,
        string businessMarketId,
        string mlsStatusId,
        string servicePolicyId,
        DtoListingmetadata listingMetadata,
        int propertyType,
        int beds,
        float baths,
        DtoPriceinfo priceInfo,
        DtoSqftinfo sqftInfo,
        DtoPhotosinfo photosInfo,
        DtoDaysonmarket daysOnMarket,
        string timezone,
        DtoYearbuilt yearBuilt,
        DtoLotsize lotSize,
        DtoHoadues hoaDues,
        DtoSash[] sashes,
        DtoBrokers brokers,
        DtoLastsaledata lastSaleData,
        DtoInsights insights,
        bool showMlsId,
        DtoDirectaccessinfo directAccessInfo,
        int fullBaths,
        DtoBathinfo bathInfo,
        DtoAddressinfo addressInfo,
        DtoOpenhous[] openHouses,
        int partialBaths
     );

    public record DtoListingmetadata(int searchStatus, int listingType, bool isRedfin, bool hasVirtualTour, bool isNewConstruction);

    public record DtoPriceinfo(string amount, int displayLevel, int priceType, DtoHomeprice homePrice);

    public record DtoHomeprice(int displayLevel, string int64Value);

    public record DtoSqftinfo(string amount, int displayLevel);

    public record DtoPhotosinfo(DtoPhotorange[] photoRanges, int primaryPhotoDisplayLevel, int secondaryPhotoDisplayLevel, DtoAlternatephotosinfo[] alternatePhotosInfo, string scanUrl, string posterFrameUrl);

    public record DtoPhotorange(int startPos, int endPos, string version);

    public record DtoAlternatephotosinfo(string mediaListType, string groupCode, int[] positionSpec, int photoType);

    public record DtoDaysonmarket(string daysOnMarket, string timeOnRedfin, DateTime listingAddedDate, int displayLevel);

    public record DtoYearbuilt(int yearBuilt, int displayLevel);

    public record DtoLotsize(string amount, int displayLevel);

    public record DtoHoadues(int displayLevel, string amount);

    public record DtoBrokers(DtoListingbrokerandagent listingBrokerAndAgent);

    public record DtoListingbrokerandagent(string redfinAgentId, string agentName, string brokerName, bool isRedfin);

    public record DtoLastsaledata(DateTime lastSoldDate);

    public record DtoInsights(int displayLevel, bool hasInsight);

    public record DtoDirectaccessinfo(string supportPhoneNumber, DtoTimezone timeZone);

    public record DtoTimezone(int id, string timeZoneIdString, string olsonTimeZoneIdString, string description);

    public record DtoBathinfo(int rawFullBaths, int computedFullBaths, float computedTotalBaths, int rawHalfBaths, int computedPartialBaths, int rawThreeQuarterBaths);

    public record DtoAddressinfo(DtoCentroid centroid, string formattedStreetLine, string city, string state, string zip, string location, int streetlineDisplayLevel, int unitNumberDisplayLevel, int locationDisplayLevel, int countryCode, int postalCodeDisplayLevel, string unitNumber);

    public record DtoCentroid(DtoCentroid1 centroid, int displayLevel);

    public record DtoCentroid1(float latitude, float longitude);

    public record DtoSash(bool isRedfin, int sashTypeId, string sashTypeName, string sashTypeColor, string timeOnRedfin, string openHouseText);

    public record DtoOpenhous(DateTime openHouseStart, DateTime openHouseEnd);
}


