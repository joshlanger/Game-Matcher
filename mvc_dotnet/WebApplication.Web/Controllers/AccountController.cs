using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebApplication.Web.DAL;
using WebApplication.Web.Models;
using WebApplication.Web.Models.Account;
using WebApplication.Web.Providers.Auth;

namespace WebApplication.Web.Controllers
{
    public class AccountController : Controller
    {
        private IUserDAL userDAO;
        //added userDAO to the constructor
        private readonly IAuthProvider authProvider;
        public AccountController(IAuthProvider authProvider, IUserDAL userDAO)
        {
            this.authProvider = authProvider;
            this.userDAO = userDAO;
        }

        //[AuthorizationFilter] // actions can be filtered to only those that are logged in
        [AuthorizationFilter("Admin", "Author", "Manager", "User")]  //<-- or filtered to only those that have a certain role
        [HttpGet]
        public IActionResult Index()
        {
            var user = authProvider.GetCurrentUser();
            return View(user);
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Login(LoginViewModel loginViewModel)
        {
            //var email = userDAO.GetUser(loginViewModel.Email);
            //var password = userDAO.GetUser(loginViewModel.Password);

            // Ensure the fields were filled out
            if (ModelState.IsValid)
            {
                // Check that they provided correct credentials
                bool validLogin = authProvider.SignIn(loginViewModel.Email, loginViewModel.Password);
                if (validLogin)
                {
                    // Redirect the user where you want them to go after successful login
                    return RedirectToAction("Index", "Account");
                }
            }

            return View(loginViewModel);
        }

        [HttpGet]
        public IActionResult LogOff()
        {
            // Clear user from session
            authProvider.LogOff();

            // Redirect the user where you want them to go after logoff
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Register(RegisterViewModel registerViewModel)
        {
            if (ModelState.IsValid)
            {
                // Register them as a new user (and set default role)
                // When a user registers they need to be given a role. If you don't need anything special
                // just give them "User".
                authProvider.Register(registerViewModel.Username, registerViewModel.Email, registerViewModel.Password, registerViewModel.Salt, registerViewModel.Zipcode, role: "User");

                // Redirect the user where you want them to go after registering
                //this should be good. merge conflicts suck.
                TempData["Status"] = "Congratulations, you have successfully registered for a new account!";
                return RedirectToAction("Login", "Account");
            }

            return View(registerViewModel);
        }

        [HttpGet]
        public IActionResult Profile()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Profile(ProfileViewModel profileViewModel)
        {
            if (ModelState.IsValid)
            {
                authProvider.Profile(profileViewModel.UserName, profileViewModel.AvatarName, profileViewModel.UserBio);
            }
            return RedirectToAction("Profile", "Account");
        }
        //is the above method working ok? it was cut off before the closing bracket of the if statement

        [HttpGet]
        public IActionResult UpdateInfo ()
        {
            UpdateInfoModel updateinfo = new UpdateInfoModel();

            //get the current user info
            var user = authProvider.GetCurrentUser();

            //convert user model to updateinfomodel
            updateinfo = updateinfo.ConvertUserToUpdateInfo(user);

            //pass info to view.  existing info will be form field defaults
            return View(updateinfo);
        }

        [HttpPost]
        public IActionResult UpdateInfo (UpdateInfoModel updateInfoModel)
        {
            if (ModelState.IsValid)
            {
                User user = new User();
                //assign updateinfo to user
                user = user.ConvertUpdateInfoModelToUser(updateInfoModel);

                //call method to update database
                userDAO.UpdateUser(user);

                return RedirectToAction("Confirmation", "Account");
            }
            else
            {
                return View(updateInfoModel);
            }
        }

        [HttpGet]
        public IActionResult Confirmation(User user)
        {
            return View(user);
        }

        //deletes the user's account from the database
        //i can't get this to work with httpdelete, but it works with post
        [HttpPost]
        public IActionResult DeleteAccount(UpdateInfoModel updateInfoModel)
        {
            User user = new User();
            user = user.ConvertUpdateInfoModelToUser(updateInfoModel);
            userDAO.DeleteUser(user);
            return RedirectToAction("Logoff", "Account");
        }
    }
}