using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Account
{
    public class RegisterViewModel
    {
        [Required]
        [StringLength(50, MinimumLength = 7)]
        public string Username { get; set; }

        [Required]

        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required]
        [StringLength(100, MinimumLength = 6)]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required]
        [Compare("Password", ErrorMessage = "Password does not match.")]
        public string ConfirmPassword { get; set; }

        public string Salt { get; set; }

        public string Role { get; set; }

        [Required]
        [DataType(DataType.PostalCode)]
        [Display(Name = "Zipcode")]
        public int Zipcode { get; set; }

    }
}
