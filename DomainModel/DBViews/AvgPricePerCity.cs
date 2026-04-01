namespace DomainModel.DBViews
{
    public class AvgPricePerCity
    {
        public required string City { get; set; }
        public required string RegionId { get; set; }
        public decimal AvgPrice { get; set; }
    }
}
