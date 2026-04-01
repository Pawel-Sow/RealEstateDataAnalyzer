namespace DomainModel.DBViews
{
    public class AvgDaysOnMarketPerPropertyType
    {
        public required int PropertyType { get; set; }
        public required string RegionId { get; set; }
        public int AvgDaysOnMarket { get; set; }
    }
}
