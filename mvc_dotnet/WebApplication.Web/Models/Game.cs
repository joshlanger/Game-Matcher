using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models
{
    public class Game
    {
        public int gameID { get; set; }
        public string title { get; set; }
        public string style { get; set; }
        public int min_players { get; set; }
        public int max_players { get; set; }
        public string genre { get; set; }
        public string image { get; set; }
        public string platform { get; set; }

    }
}
