namespace DomainModel.DBViews
{
    public class AvgPricePerPropertyType
    {
        public int PropertyTypeId { get; set; }
        public required string PropertyTypeMappingName { get; set; }
        public required string RegionId { get; set; }
        public decimal AvgPrice { get; set; }
    }
}
