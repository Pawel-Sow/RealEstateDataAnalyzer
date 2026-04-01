using DataCollectorService;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using MyApp.Data;
using System.Buffers.Text;

var builder = Host.CreateApplicationBuilder(args);
builder.Services.AddHttpClient<RealfinClient>((sp, client) =>
{
    var options = sp.GetRequiredService<IOptions<RealfinApiOptions>>().Value;

    client.BaseAddress = new Uri(options.BaseUrl); //"https://realfin-us.p.rapidapi.com";
    client.DefaultRequestHeaders.Accept.Clear();
    client.DefaultRequestHeaders.Add("User-Agent", ".NET Foundation Repository Reporter");
    client.DefaultRequestHeaders.Add("x-rapidapi-host", "realfin-us.p.rapidapi.com");
    client.DefaultRequestHeaders.Add("x-rapidapi-key", options.ApiKey);

});
builder.Services.AddHostedService<IngestionWorker>();
builder.Services.AddHostedService<TransformWorker>();
builder.Services.AddWindowsService();

builder.Services.Configure<RealfinApiOptions>(
    builder.Configuration.GetSection("RealfinApi"));

builder.Services.AddDbContext<PropertyDataContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection"))
        .EnableSensitiveDataLogging()
         .LogTo(Console.WriteLine));

var host = builder.Build();
host.Run();
