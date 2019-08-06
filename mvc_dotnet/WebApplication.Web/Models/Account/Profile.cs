using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models.Games;

namespace WebApplication.Web.Models.Account
{
    public class Profile
    {
        string Username { get; set; }

        string FirstName { get; set; }

        string LastName { get; set; }

        public List<Game> AvailableGames { get; set; }
    }
}
