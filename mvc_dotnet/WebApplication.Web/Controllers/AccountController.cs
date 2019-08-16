using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using WebApplication.Web.DAL;
using WebApplication.Web.Models;
using WebApplication.Web.Models.Account;
using WebApplication.Web.Models.Profile;
using WebApplication.Web.Providers.Auth;
using System.Web.Http.Cors;

namespace WebApplication.Web.Controllers
{
    [EnableCors(origins: "localhost", headers: "*", methods: "*")]


    public class AccountController : Controller
    {
        private IUserDAL userDAO;
        private IProfileDAL profileDAO;
        private readonly IAuthProvider authProvider;
        private IProfileSearchDAL profileSearchDAL;

        public AccountController(IAuthProvider authProvider, IUserDAL userDAO, IProfileDAL profileDAO, IProfileSearchDAL profileSearchDAL)
        {
            this.authProvider = authProvider;
            this.userDAO = userDAO;
            this.profileDAO = profileDAO;
            this.profileSearchDAL = profileSearchDAL;
        }


        //[AuthorizationFilter] // actions can be filtered to only those that are logged in
        [AuthorizationFilter("Admin", "Author", "Manager", "User")]  //<-- or filtered to only those that have a certain role
        [HttpGet]
        public IActionResult Index(User userProfile)
        {
            //ProfileViewModel profile = new ProfileViewModel();
            var user = authProvider.GetCurrentUser();
            //userProfile.Email = user.Email;
            //userProfile.Username = user.Username;
            //profile.UserId = user.Id;
            //profile.Username = user.Username;
            //profile.ZipCode = user.ZipCode;

            var container = profileDAO.GetProfile(user.Username);

            AllInformationModel AllInfo = new AllInformationModel();
            if (container.GameTitles.Count != 0 && container.GenreNames.Count != 0)
            {
                if (container.GameTitles.Count != 0 && container.GenreNames.Count != 0)
                {
                    AllInfo.AllUsers = profileSearchDAL.GetMatches();
                    AllInfo.CurrentUser = AllInfo.GetCurrentGamer(AllInfo.AllUsers, user.Username);
                    container.MatchStrength = AllInfo.Matches(AllInfo.AllUsers, AllInfo.CurrentUser);
                    container.MatchStrength = AllInfo.RemoveCurrentGamer(container.MatchStrength, user.Username);
                    container.TopThree = AllInfo.GetTopThree(container.MatchStrength);
                }
            }
            return View(container);
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
        public IActionResult Profile(User userProfile)
        {
            ProfileViewModel profile = new ProfileViewModel();
            var user = authProvider.GetCurrentUser();
            userProfile.Email = user.Email;
            userProfile.Username = user.Username;
            profile.UserId = user.Id;
            profile.Username = user.Username;

            var container = profileDAO.GetProfile(userProfile.Username);
            container.ZipCode = user.ZipCode;
            return View(container);
        }

        [HttpGet]
        public IActionResult ProfileCreate(User editUserProfile)
        {
            ProfileViewModel profileEdit = new ProfileViewModel();
            var user = authProvider.GetCurrentUser();
            editUserProfile.Username = user.Username;
            var container = profileDAO.GetProfile(editUserProfile.Username);
            container.AvatarName = editUserProfile.Id.ToString();
            return View(container);
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
            return View(container);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ProfileEdit(ProfileViewModel profileEdit)
        {
            User userTemp = new User();
            var user = authProvider.GetCurrentUser();
            userTemp.Username = user.Username;
            var container = profileDAO.GetProfile(userTemp.Username);
            profileDAO.UpdatedProfile(profileEdit);
            profileEdit.ProfileId = container.ProfileId;
            profileEdit.AvatarName = container.AvatarName;
            profileDAO.SaveGameOptions(profileEdit, profileEdit.GamesSelected);
            profileDAO.GameNames(profileEdit);
            profileDAO.SaveGenreOptions(profileEdit, profileEdit.GenresSelected);
            profileDAO.GenreNames(profileEdit);
            profileDAO.UpdatedProfile(profileEdit);

            return RedirectToAction("Profile", "Account");
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

        //PROGRAM IS CRASHING AT LINE "USER.EMAIL..."
        [HttpGet]
        public IActionResult Confirmation(User user)
        {
            var userConfirm = authProvider.GetCurrentUser();
            user.Email = userConfirm.Email;
            user.Id = userConfirm.Id;
            user.Password = userConfirm.Password;
            user.Role = userConfirm.Role;
            user.Salt = userConfirm.Salt;
            user.ZipCode = userConfirm.ZipCode;
            user.Username = userConfirm.Username;
            return View(user);
        }

        //deletes the user's account from the database
        //i can't get this to work with [httpdelete], but it works with post
        //note that this assumes the username of the profile and user table are the same
        //we should probably remove update user name from the update account options as it serves no real purpose
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteAccount(User user)
        {
            ProfileViewModel Container = new ProfileViewModel();
            Container = profileDAO.GetProfile(user.Username);
            userDAO.DeleteUser(Container.ProfileId, user.Id);
            return RedirectToAction("Logoff", "Account");
        }
    }
}