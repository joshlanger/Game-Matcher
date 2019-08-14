using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebApplication.Web.DAL;
using WebApplication.Web.Models;
using WebApplication.Web.Models.Account;
using WebApplication.Web.Models.Profile;
using WebApplication.Web.Providers.Auth;

namespace WebApplication.Web.Controllers
{
    public class ProfileController : Controller
    {
        private IProfileSearchDAL profileSearchDAL;
        private IUserDAL userDAL;
        private readonly IAuthProvider authProvider;
        public ProfileController(IProfileSearchDAL profileSearchDAL, IUserDAL userDAL, IAuthProvider authProvider)
        {
            this.profileSearchDAL = profileSearchDAL;
            this.userDAL = userDAL;
            this.authProvider = authProvider;
        }

        public IActionResult Search()
        {
            return View();
        }

        [HttpGet]
        public IActionResult GamerProfile(int id)
        {
            var profile = profileSearchDAL.GetProfile(id);
            AllInformationModel AllInfo = new AllInformationModel();
            var user = authProvider.GetCurrentUser();
            AllInfo.AllUsers = profileSearchDAL.GetMatches();
            AllInfo.CurrentUser = AllInfo.GetCurrentGamer(AllInfo.AllUsers, user.Username);
            profile.TopThree = AllInfo.Matches(AllInfo.AllUsers, AllInfo.CurrentUser);
            return View(profile);
        }

        [HttpGet]
        public IActionResult SearchResults(SearchModel parameter)
        {
            SearchResultsModel Results = new SearchResultsModel();
            Results.Results = profileSearchDAL.SearchAll(parameter.searchParameter);
            if (Results.Results.Count == 0)
            {
                ProfileViewModel Container = new ProfileViewModel();
                Results.Results.Add(Container);
            }
            return View(Results);
        }

        [HttpGet]
        public IActionResult SearchUserName(SearchModel searchUsername)
        {
            int id = profileSearchDAL.SearchProfileByUsername(searchUsername.searchParameter);
            return RedirectToAction("GamerProfile", new { id });
            
        }

        [HttpGet]
        public IActionResult Matches()
        {
            var user = authProvider.GetCurrentUser();
            
            AllInformationModel AllInfo = new AllInformationModel();
            AllInfo.AllUsers = profileSearchDAL.GetMatches();
           
            AllInfo.CurrentUser = AllInfo.GetCurrentGamer(AllInfo.AllUsers, user.Username);
            AllInfo.GamerMatchStrength = AllInfo.Matches(AllInfo.AllUsers, AllInfo.CurrentUser);
            return View(AllInfo);
        }

    }
}