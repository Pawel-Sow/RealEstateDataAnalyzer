using DomainModel;
using Microsoft.EntityFrameworkCore;
using MyApp.Data;
using System.Text.Json;

namespace DataCollectorService
{
    public class IngestionWorker(RealfinClient realfinClient, IServiceProvider serviceProvider, ILogger<IngestionWorker> logger) : BackgroundService
    {

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                if (logger.IsEnabled(LogLevel.Information))
                {
                    using var scope = serviceProvider.CreateScope();
                    var context = scope.ServiceProvider.GetRequiredService<PropertyDataContext>();

                    var regions = await context.Regions.ToListAsync();

                    foreach (var region in regions)
                    {
                        string JSonEstate = await realfinClient.SearchRealEstateData(region.RegionId);
                        var realfinSearchResponse = JsonSerializer.Deserialize<DTORealfinSearchResponse>(JSonEstate);

                        if (realfinSearchResponse?.data == null || realfinSearchResponse?.data.Length == 0)
                            continue;

                        if (realfinSearchResponse != null)
                        {
                            var raws = realfinSearchResponse.data.Select(x => new PropertyRawData
                            {
                                PropertyId = x.homeData.propertyId,
                                JsonData = JsonSerializer.Serialize(x),
                                RegionId = region.RegionId,
                                CreatedAt = DateTime.UtcNow
                            }).ToList();

                            context.PropertiesRawData.AddRange(raws);
                            await context.SaveChangesAsync(stoppingToken);
                        }
                    }                                 

                    logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
                }
                await Task.Delay(TimeSpan.FromHours(24), stoppingToken);
            }
        }
    }
}
