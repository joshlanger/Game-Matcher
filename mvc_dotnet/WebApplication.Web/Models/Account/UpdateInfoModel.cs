﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Account
{
    public class UpdateInfoModel
    {
        
        public string Username { get; set; }
        public int Id { get; set; }
        
        [EmailAddress]
        [Display(Name = "Email")]
        public string Email { get; set; }

        
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        public string Salt { get; set; }

        public string Role { get; set; }

        
        public int Zipcode { get; set; }

        public UpdateInfoModel ConvertUserToUpdateInfo(User user)
        {
            UpdateInfoModel NewInfo = new UpdateInfoModel();
            NewInfo.Email = user.Email;
            NewInfo.Id = user.Id;
            NewInfo.Password = user.Password;
            NewInfo.Role = user.Role;
            NewInfo.Salt = user.Salt;
            NewInfo.Username = user.Username;
            NewInfo.Zipcode = user.ZipCode;
            return NewInfo;
        }

    }
}