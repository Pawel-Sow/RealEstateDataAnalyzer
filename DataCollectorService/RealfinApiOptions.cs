namespace DataCollectorService
{
    public class RealfinApiOptions
    {
        public string BaseUrl { get; set; } = default!;
        public string ApiKey { get; set; } = default!;
        public int SearchPageLimit { get; set; }
        public bool GetFromFileCache { get; set; }
    }
}
