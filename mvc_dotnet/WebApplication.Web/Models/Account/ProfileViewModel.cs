using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models.Profile;

namespace WebApplication.Web.Models.Account
{
    public class ProfileViewModel
    {

        public int ProfileId { get; set; }

        public int UserId { get; set; }

        public string Username { get; set; }

        [Required]
        [DataType(DataType.ImageUrl)]
        [Display(Name = "Avatar Url: ")]
        public string AvatarName { get; set; }

        [Required]
        [StringLength(140, ErrorMessage = "The {0} must have a bio of at least 50 characters.", MinimumLength = 50)]
        [DataType(DataType.Text)]
        [Display(Name = "About Me: ")]
        public string UserBio { get; set; }

        [Required]
        public string GamingExperience { get; set; }

        [Required]
        [StringLength(140, ErrorMessage = "The {0} must have a bio of at least 50 characters.", MinimumLength = 50)]
        [DataType(DataType.Text)]
        public string ContactPreference { get; set; }

        [Required]
        [StringLength(140, ErrorMessage = "The {0} must have a bio of at least 50 characters.", MinimumLength = 50)]
        [DataType(DataType.Text)]
        public string OtherInterests { get; set; }

        [Required]
        public bool IsPrivate { get; set; }

        public IList<SelectListItem> Games { get; set; }

        public int[] GamesSelected { get; set; }

        public int GamesId { get; set; }

        public List<Game> GameTitles { get; set; }

        public IList<SelectListItem> Genres { get; set; }

        public int[] GenresSelected { get; set; }

        public List<Genre> GenreNames { get; set; }

        public List<MatchStrengthModel> TopThree { get; set; }

        public static List<SelectListItem> ExperienceLevel = new List<SelectListItem>()
        {
            new SelectListItem() { Text = "Novice" },
            new SelectListItem() { Text = "Intermediate" },
            new SelectListItem() { Text = "Expert" },
        };
    }
}
