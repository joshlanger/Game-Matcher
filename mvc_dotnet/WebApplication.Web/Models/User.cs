using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models.Account;

namespace WebApplication.Web.Models
{
    public class User
    {
        /// <summary>
        /// The user's id.
        /// </summary>
        [Required]
        public int Id { get; set; }

        /// <summary>
        /// The user's username.
        /// </summary>
        [Required]
        [MaxLength(50)]
        public string Username { get; set; }

        /// <summary>
        /// The user's email address.
        /// </summary>
        [EmailAddress]
        public string Email { get; set; }

        /// <summary>
        /// The user's password.
        /// </summary>
        [Required]
        public string Password { get; set; }

        /// <summary>
        /// The user's salt.
        /// </summary>
        [Required]
        public string Salt { get; set; }

        /// <summary>
        /// The user's role.
        /// </summary>
        public string Role { get; set; }

        /// <summary>
        /// The user's zip code.
        /// </summary>
        public int ZipCode { get; set; }

        public User ConvertUpdateInfoModelToUser (UpdateInfoModel updateInfoModel)
        {
            User updatedUser = new User();
            updatedUser.Email = updateInfoModel.Email;
            updatedUser.Id = updateInfoModel.Id;
            updatedUser.Password = updateInfoModel.Password;
            updatedUser.Role = updateInfoModel.Role;
            updatedUser.Salt = updateInfoModel.Salt;
            updatedUser.Username = updateInfoModel.Username;
            updatedUser.ZipCode = updateInfoModel.Zipcode;
            return updatedUser;
        }
    }
}
