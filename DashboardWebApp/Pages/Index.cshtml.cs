using DomainModel;
using DomainModel.DBViews;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using MyApp.Data;

namespace DashboardWebApp.Pages
{
    public class IndexModel : PageModel
    {
        private readonly PropertyDataContext _context;

        public IndexModel(PropertyDataContext context)
        {
            _context = context;
        }

        public List<AvgDaysOnMarketPerPropertyType> AvgDaysOnMarket { get; set; }

        public List<AvgPricePerCity> AvgPricePerCity { get; set; }

        public List<AvgPricePerPropertyType> AvgPricePerPropertyType { get; set; }

        public List<AvgPricePerYearBuild> AvgPricePerYearBuild { get; set; }

        public KPI KPI { get; set; }

        public List<PriceHistogram> PriceHistogram { get; set; }

        public List<PricePerSqft> PricePerSqft { get; set; }

        public List<Region> Regions { get; set; }

        [BindProperty(SupportsGet = true)]
        public string SelectedRegion { get; set; }

        public void OnGet()
        {
            Regions = _context.Regions.ToList();

            SelectedRegion = Regions.FirstOrDefault()?.RegionId;

            AvgDaysOnMarket = _context.AvgDaysOnMarket.Where(x => x.RegionId == SelectedRegion).ToList();
            AvgPricePerCity = _context.AvgPricePerCity.Where(x => x.RegionId == SelectedRegion).ToList();
            AvgPricePerPropertyType = _context.AvgPricePerPropertyType.Where(x => x.RegionId == SelectedRegion).ToList();
            AvgPricePerYearBuild = _context.AvgPricePerYearBuild.Where(x => x.RegionId == SelectedRegion).ToList();
            KPI = _context.KPI.Where(x => x.RegionId == SelectedRegion).FirstOrDefault();
            PriceHistogram = _context.PriceHistogram.Where(x => x.RegionId == SelectedRegion).ToList();
            PricePerSqft = _context.PricePerSqft.Where(x => x.RegionId == SelectedRegion).ToList();
        }
    }
}
