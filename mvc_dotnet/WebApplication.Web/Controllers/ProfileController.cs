﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebApplication.Web.DAL;
using WebApplication.Web.Models;
using WebApplication.Web.Models.Account;
using WebApplication.Web.Models.Profile;

namespace WebApplication.Web.Controllers
{
    public class ProfileController : Controller
    {
        private IProfileSearchDAL profileSearchDAL;
        private IUserDAL userDAL;
        public ProfileController(IProfileSearchDAL profileSearchDAL, IUserDAL userDAL)
        {
            this.profileSearchDAL = profileSearchDAL;
            this.userDAL = userDAL;
        }

        public IActionResult Search()
        {
            return View();
        }

        [HttpGet]
        public IActionResult GamerProfile(int id)
        {
            var profile = profileSearchDAL.GetProfile(id);
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

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Input(SelectGameModel selectedGame)
        {
           
            //code to save to database here

            return RedirectToAction("Profile", "Account");
        }

    }
}