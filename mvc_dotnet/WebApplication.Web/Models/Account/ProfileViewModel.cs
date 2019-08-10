using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models.Games;

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
        public int GamingExperience { get; set; }

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

        //public List<Game> AvailableGames { get; set; }
    }
}
