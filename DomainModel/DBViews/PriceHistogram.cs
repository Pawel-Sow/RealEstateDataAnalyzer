namespace DomainModel.DBViews
{
    public class PriceHistogram
    {
        public required string RegionId { get; set; }

        public required string PriceRange { get; set; }

        public required int CountProperties { get; set; }
    }
}
