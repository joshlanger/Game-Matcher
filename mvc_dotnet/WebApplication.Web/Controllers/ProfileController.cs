using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebApplication.Web.DAL;
using WebApplication.Web.Models;

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

        [HttpGet]
        public IActionResult GamerProfile(int id)
        {
            var profile = profileSearchDAL.GetProfile(id);
            return View();
        }

        [HttpGet]
        public IActionResult SearchUserName(string searchUsername)
        {
            int id = profileSearchDAL.SearchProfileByUsername(searchUsername);
            return RedirectToAction("GamerProfile", "Profile", "id");
        }
    }
}