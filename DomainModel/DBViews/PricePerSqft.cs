namespace DomainModel.DBViews
{
    public class PricePerSqft
    {
        public required string RegionId { get; set; }
        public int Sqft { get; set; }
        public int Price { get; set; }
    }
}
