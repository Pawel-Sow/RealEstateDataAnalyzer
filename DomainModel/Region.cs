using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DomainModel
{
    public class Region
    {
        [StringLength(16)]
        public string RegionId { get; set; } = default;
        [StringLength(128)]
        public string RegionName { get; set; } = default;
    }
}
