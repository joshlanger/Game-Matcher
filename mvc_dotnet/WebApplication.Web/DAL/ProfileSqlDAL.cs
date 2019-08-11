using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models.Account;

namespace WebApplication.Web.DAL
{
    public class ProfileSqlDAL : IProfileDAL
    {

        private readonly string connectionString;

        public ProfileSqlDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public void CreateProfile(ProfileViewModel profile)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO profile VALUES (@user_id, @user_name, @avatar_name, @user_bio, @gaming_experience, @contact_preference, @other_interests, @is_private)", conn);
                    cmd.Parameters.AddWithValue("@user_id", profile.UserId);
                    cmd.Parameters.AddWithValue("@user_name", profile.Username);
                    cmd.Parameters.AddWithValue("@avatar_name", profile.AvatarName);
                    cmd.Parameters.AddWithValue("@user_bio", profile.UserBio);
                    cmd.Parameters.AddWithValue("@gaming_experience", profile.GamingExperience);
                    cmd.Parameters.AddWithValue("@contact_preference", profile.ContactPreference);
                    cmd.Parameters.AddWithValue("@other_interests", profile.OtherInterests);
                    cmd.Parameters.AddWithValue("@is_private", profile.IsPrivate);

                    cmd.ExecuteNonQuery();
                    return;

                }
            }
            catch(SqlException ex)
            {
                throw ex;
            }
            
        }


        public ProfileViewModel GetProfile(string username)
        {
            ProfileViewModel profile = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT user_name from profile JOIN users on profile.user_id = users.user_id where users.username = @username", conn);
                    cmd.Parameters.AddWithValue("@username", username);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        profile = MapRowToProfile(reader);
                    }
                    return profile;
                }
            }
            catch(SqlException ex)
            {
                throw ex;
            }
            
        }

        public void UpdatedProfile(ProfileViewModel profile)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE profile SET user_name = @Username, avatar_name = @AvatarName, user_bio = @UserBio WHERE id = @id;", conn);
                    cmd.Parameters.AddWithValue("@Username", profile.Username);
                    cmd.Parameters.AddWithValue("@AvatarName", profile.AvatarName);
                    cmd.Parameters.AddWithValue("@UserBio", profile.UserBio);
                    
                }
            }
            catch
            {
                throw new NotImplementedException();
            }
            
        }
        private ProfileViewModel MapRowToProfile(SqlDataReader reader)
        {
            return new ProfileViewModel()
            {
                ProfileId = Convert.ToInt32(reader["profile_id"]),
                UserId = Convert.ToInt32(reader["user_id"]),
                Username = Convert.ToString(reader["user_name"]),
                AvatarName = Convert.ToString(reader["avatar_name"]),
                UserBio = Convert.ToString(reader["user_bio"]),
                GamingExperience = Convert.ToInt32(reader["gaming_experience"]),
                ContactPreference = Convert.ToString(reader["contact_preference"]),
                OtherInterests = Convert.ToString(reader["other_interests"]),
                IsPrivate = Convert.ToBoolean(reader["is_Private"])
            };
        }
    }
}
