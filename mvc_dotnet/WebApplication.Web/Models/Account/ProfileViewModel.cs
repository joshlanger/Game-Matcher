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

        public string Username { get; set; }

        public string AvatarName { get; set; }

        public string UserBio { get; set; }

        public int GamingExperience { get; set; }

        public string FavoriteGenres { get; set; }

        public string ContactPreference { get; set; }

        public string OtherInterests { get; set; }

        public bool IsPrivate { get; set; }

        public string GamingExperience { get; set; }

        public string FavoriteGenres { get; set; }

        public string ContactPreference { get; set; }

        public string OtherInterests { get; set; }

        public string IsPrivate { get; set; }

        //public List<Game> AvailableGames { get; set; }
    }
}
