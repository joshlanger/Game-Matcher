using Microsoft.AspNetCore.Mvc;
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
        [DataType(DataType.Text)]
        [StringLength(25, MinimumLength = 7)]
        public string Username { get; set; }

        [Required]
        [DataType(DataType.EmailAddress)]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required]
        [StringLength(30, MinimumLength = 6)]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required]
        [Compare("Password")]
        public string ConfirmPassword { get; set; }

        public string Salt { get; set; }

        public string Role { get; set; }

        [Required]
        //[Range(5, 6, ErrorMessage = "Zipcode must be 5 digits")]
        [DataType(DataType.PostalCode)]
        [Display(Name = "Zipcode")]
        public int Zipcode { get; set; }

    }
}
