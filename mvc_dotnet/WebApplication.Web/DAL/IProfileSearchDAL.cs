using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models.Account;
using WebApplication.Web.Models.Profile;

namespace WebApplication.Web.DAL
{
    public interface IProfileSearchDAL
    {
        int SearchProfileByUsername(string username);

        ProfileViewModel GetProfile(int profileId);

        List<ProfileViewModel> SearchAll(string parameter);

        List<MatchStrengthModel> GetMatches();
    }
}
