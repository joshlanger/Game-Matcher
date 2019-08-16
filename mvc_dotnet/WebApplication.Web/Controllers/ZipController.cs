using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApplication.Web.DAL;
using WebApplication.Web.Models.Account;
using WebApplication.Web.Providers.Auth;

namespace WebApplication.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ZipController : ControllerBase
    {
        private IUserDAL userDAO;
        private IProfileDAL profileDAO;
        private readonly IAuthProvider authProvider;
        private IProfileSearchDAL profileSearchDAL;

        public ZipController(IAuthProvider authProvider, IUserDAL userDAO, IProfileDAL profileDAO, IProfileSearchDAL profileSearchDAL)
        {
            this.authProvider = authProvider;
            this.userDAO = userDAO;
            this.profileDAO = profileDAO;
            this.profileSearchDAL = profileSearchDAL;
        }

        [HttpGet("zipDistance")]
        public string GetZipDistance(ProfileViewModel profile, double zip1, double zip2)
        {
            var user = authProvider.GetCurrentUser();
            zip1 = user.ZipCode;
            string zipA = user.ZipCode.ToString();
            var gamerProfile = profileSearchDAL.GetProfile(profile.ProfileId);
            zip2 = gamerProfile.ZipCode;
            string zipB = user.ZipCode.ToString();

            WebClient webClient = new WebClient();
            string host = "https://www.zipcodeapi.com/rest/4Gfn1Q4ds8zgjzvAO9vCIk3R1ovzdHOZw3wOOazm04Tb21YjVK3tB1iVRcbrRCyK/distance.json/" + zipA + "/" + zipB + "/mile";
            var webResult = webClient.DownloadString(host);
            int index = webResult.IndexOf(":") + 1;
            return webResult.Substring(index, webResult.Length - 1 - index);
        }
    }
}