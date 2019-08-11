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
        private IProfileDAL profileDAO;
        private readonly IAuthProvider authProvider;

        public AccountController(IAuthProvider authProvider, IUserDAL userDAO, IProfileDAL profileDAO)
        {
            this.authProvider = authProvider;
            this.userDAO = userDAO;
            this.profileDAO = profileDAO;
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
            return RedirectToAction("Login", "Account");
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
            //var userCheck = userDAO.GetUser(registerViewModel.Email);
            //bool isTaken = false;
            //if(userCheck.Email != null)
            //{
            //    isTaken = true;
            //}

            if (ModelState.IsValid /*&& !isTaken*/)
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

        [HttpGet]
        public IActionResult ProfileCreate(User editUserProfile)
        {
            ProfileViewModel profile = new ProfileViewModel();
            var user = authProvider.GetCurrentUser();
            editUserProfile.Email = user.Email;
            userDAO.GetUser(user.Email);
            editUserProfile.Id = user.Id;
            profile.UserId = editUserProfile.Id;
            return View(profile);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ProfileCreate(ProfileViewModel profile)
        {
            profileDAO.CreateProfile(profile);

            return RedirectToAction("Confirmation", "Account");
        }

        [HttpGet]
        public IActionResult ProfileEdit(User editUserProfile)
        {

            ProfileViewModel profileEdit = new ProfileViewModel();
            var user = authProvider.GetCurrentUser();
            editUserProfile.Username = user.Username;
            var container = profileDAO.GetProfile(editUserProfile.Username);
            profileEdit.UserId = user.Id;
            profileEdit.ProfileId = container.ProfileId;
            return View(profileEdit);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ProfileEdit(ProfileViewModel profileEdit)
        {
            User userTemp = new User();
            var user = authProvider.GetCurrentUser();
            userTemp.Username = user.Username;
            var container = profileDAO.GetProfile(userTemp.Username);
            profileEdit.ProfileId = container.ProfileId;
            profileDAO.UpdatedProfile(profileEdit);

            return RedirectToAction("Confirmation", "Account");
        }

        [HttpGet]
        public IActionResult UpdateInfo()
        {
            User updateinfo = new User();

            //get the current user info
            var user = authProvider.GetCurrentUser();

            //pass info to view.  existing info will be form field defaults
            return View(user);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult UpdateInfo (User user)
        { 
                userDAO.UpdateUser(user);

                return RedirectToAction("Confirmation", "Account");  
        }

        [HttpGet]
        public IActionResult ChangePassword (User user)
        {
            ChangePasswordModel password = new ChangePasswordModel();
            password.Id = user.Id;
            return View(password);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ChangePassword(ChangePasswordModel passwordIn)
        {
            if (ModelState.IsValid)
            {
                
                authProvider.ChangePassword(passwordIn.ExistingPassword, passwordIn.Password);

                return RedirectToAction("Confirmation", "Account");
            }
            else
            {
                return View(passwordIn);
            }
        }

        [HttpGet]
        public IActionResult Confirmation(User user)
        {
            return View(user);
        }

        //deletes the user's account from the database
        //i can't get this to work with [httpdelete], but it works with post
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteAccount(User user)
        {
            userDAO.DeleteUser(user);
            return RedirectToAction("Logoff", "Account");
        }
    }
}