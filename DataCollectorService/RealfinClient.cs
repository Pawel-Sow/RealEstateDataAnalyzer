using Microsoft.Extensions.Options;


namespace DataCollectorService
{   
    public sealed class RealfinClient(HttpClient httpClient, IOptions<RealfinApiOptions> options)
    {
        public async Task<string> SearchRealEstateData(string regionId = "6_30749")
        {
            var patchToCacheFile = $"../cachedData/SearchRegion_{regionId}.json";
            if (options.Value.GetFromFileCache && File.Exists(patchToCacheFile))
            {
                return await File.ReadAllTextAsync(patchToCacheFile);
            }
            else
            {
                var jsonResponse = await httpClient.GetStringAsync($"/search/region/for-sale?regionId={regionId}&limit={options.Value.SearchPageLimit}");
                await File.WriteAllTextAsync(patchToCacheFile, jsonResponse);
                return jsonResponse;
            }
        }
    }
}
