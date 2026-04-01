using Microsoft.EntityFrameworkCore;
using MyApp.Data;

namespace DataCollectorService 
{
    public  class TransformWorker(IServiceProvider serviceProvider) : BackgroundService
    {
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                using var scope = serviceProvider.CreateScope();
                var db = scope.ServiceProvider.GetRequiredService<PropertyDataContext>();

                await db.Database.ExecuteSqlRawAsync("EXEC dbo.TransformRawPropertyData");

                await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
            }
        }
    }
}
