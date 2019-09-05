using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Profile
{
    public class MatchStrengthModel
    {
        public int ProfileId { get; set; }
        public string Username { get; set; }
        public string Title { get; set; }
        public string Experience { get; set; }
        public string Genre { get; set; }
        public double MatchStrength { get; set; }
        public string AvatarName { get; set; }    
    }
}
