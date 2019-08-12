using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Profile
{
    public class SelectGameModel
    {
        [DisplayName("Game")]
        public int SelectedItem { get; set; }

        public List<SelectListItem> Items { get; set; }
    }
}
