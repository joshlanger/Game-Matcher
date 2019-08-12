using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Profile
{
    public class MatchStrengthModel
    {
        public string Username { get; set; }
        public bool IsPrivate { get; set; }
        public int ProfileId { get; set; }
        public int Zipcode { get; set; }

    }
}
