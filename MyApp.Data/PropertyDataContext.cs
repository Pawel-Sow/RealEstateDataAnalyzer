using DomainModel;
using DomainModel.DBViews;
using Microsoft.EntityFrameworkCore;


namespace MyApp.Data
{
    public class PropertyDataContext : DbContext
    {
        public PropertyDataContext(DbContextOptions<PropertyDataContext> options) : base(options)
        {
        }
        public DbSet<PropertyRawData> PropertiesRawData { get; set; }

        public DbSet<Region> Regions { get; set; }

        public DbSet<AvgDaysOnMarketPerPropertyType> AvgDaysOnMarket { get; set; }

        public DbSet<AvgPricePerCity> AvgPricePerCity { get; set; }

        public DbSet<AvgPricePerPropertyType> AvgPricePerPropertyType { get; set; }

        public DbSet<AvgPricePerYearBuild> AvgPricePerYearBuild { get; set; }

        public DbSet<KPI> KPI { get; set; }

        public DbSet<PriceHistogram> PriceHistogram { get; set; }

        public DbSet<PricePerSqft> PricePerSqft { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PropertyRawData>(entity =>
            {
                entity.HasKey(e => e.Id);

                entity.Property(e => e.PropertyId)
                      .IsRequired();

                entity.Property(e => e.JsonData)
                      .IsRequired();

                entity.Property(e => e.RegionId)
                      .IsRequired();

                entity.Property(e => e.CreatedAt)
                      .HasDefaultValueSql("GETUTCDATE()");
            });

            modelBuilder.Entity<AvgDaysOnMarketPerPropertyType>()
                .HasNoKey()
                .ToView("vw_AvgDaysOnMarketPerPropertyType");

            modelBuilder.Entity<AvgPricePerCity>()
                .HasNoKey()
                .ToView("vw_AvgPricePerCity");

            modelBuilder.Entity<AvgPricePerPropertyType>()
                .HasNoKey()
                .ToView("vw_AvgPricePerPropertyType");

            modelBuilder.Entity<AvgPricePerYearBuild>()
                .HasNoKey()
                .ToView("vw_AvgPricePerYearBuild");

            modelBuilder.Entity<KPI>()
                .HasNoKey()
                .ToView("vw_KPI");

            modelBuilder.Entity<PriceHistogram>()
                .HasNoKey()
                .ToView("vw_PriceHistogram");

            modelBuilder.Entity<PricePerSqft>()
                .HasNoKey()
                .ToView("vw_PricePerSqft");

        }
    }
}
