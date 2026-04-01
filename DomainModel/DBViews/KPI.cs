namespace DomainModel.DBViews
{
    public class KPI
    {     
        public required string RegionId { get; set; }
        public int AvgPrice { get; set; }
        public int AvgPricePerSqft { get; set; }
        public int AvgDaysOnMarket { get; set; }
        public int MedianPrice { get; set; }
    }
}
