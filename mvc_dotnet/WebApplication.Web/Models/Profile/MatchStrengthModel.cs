using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Profile
{
    public class MatchStrengthModel
    {
        public string Username { get; set; }
        public List<string> Title { get; set; }
        public string Experience { get; set; }
        public List<string> Style { get; set; }
        public double MatchStrength { get; set; }
    }
}
