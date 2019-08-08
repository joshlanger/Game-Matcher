using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models.Games;

namespace WebApplication.Web.Models.Account
{
    public class ProfileViewModel
    {

        public int ProfileId { get; set; }

        public int UserId { get; set; }

        public string UserName { get; set; }

        public string UserBio { get; set; }

        public string AvatarName { get; set; }

        public List<Game> AvailableGames { get; set; }
    }
}
