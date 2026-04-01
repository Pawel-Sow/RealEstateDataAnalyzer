namespace DomainModel.DBViews
{
    public class AvgPricePerYearBuild
    {
        public string YearBuiltRange { get; set; }
        public required string RegionId { get; set; }
        public decimal AvgPrice { get; set; }
        public int NumberOfProperties { get; set; }
        
    }
}
