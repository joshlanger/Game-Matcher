using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models;
using WebApplication.Web.Models.Account;

namespace WebApplication.Web.DAL
{
    public interface IProfileDAL
    {
        ProfileViewModel GetProfile(string username);

        void CreateProfile(ProfileViewModel profile);

        void UpdatedProfile(ProfileViewModel profile);

        IList<SelectListItem> GetGames();

        void SaveGameOptions(ProfileViewModel profile, int[] games);

        List<Game> GameNames(ProfileViewModel profile);
    }
}
