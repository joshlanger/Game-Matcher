using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApplication.Web.DAL;
using WebApplication.Web.Models.Account;
using WebApplication.Web.Models.Games;

namespace WebApplication.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GamesController : ControllerBase
    {
        private GameDAL dal;
        public GamesController(GameDAL gameDAL)
        {
            dal = gameDAL;
        }

        [HttpGet]
        public ActionResult<List<Game>> GetVideoGames()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://api-v3.igdb.com/games/");
                return dal.GetGames();
            }
        }
    }
}