using System;
using System.Collections.Generic;
using System.Text;

namespace DomainModel
{
    public class PropertyRawData
    {
        public int Id { get; set; }
        public string PropertyId { get; set; } = default!;
        public DateTime? ProcessedAt { get; set; }
        public string JsonData { get; set; } = default!;
        public DateTime CreatedAt { get; set; }
        public string RegionId { get; set; } = default;
    }
}
