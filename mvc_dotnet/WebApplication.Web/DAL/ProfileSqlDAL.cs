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
                    SqlCommand cmd = new SqlCommand("INSERT INTO profile VALUES (@avatar_name, @user_bio)", conn);
                    cmd.Parameters.AddWithValue("@avatar_name", profile.AvatarName);
                    cmd.Parameters.AddWithValue("@user_bio", profile.UserBio);

                    cmd.ExecuteNonQuery();
                    return;

                }
            }
            catch(SqlException ex)
            {
                throw ex;
            }
            
        }


        public ProfileViewModel GetProfile(string UserName)
        {
            ProfileViewModel profile = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM profile WHERE user_name = @user_name;", conn);
                    cmd.Parameters.AddWithValue("@user_name", UserName);

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

        public void UdatedProfile(ProfileViewModel profile)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE profile SET user_name = @UserName, avatar_name = @AvatarName, user_bio = @UserBio WHERE id = @id;", conn);
                    cmd.Parameters.AddWithValue("@UserName", profile.UserName);
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
                UserName = Convert.ToString(reader["user_name"]),
                AvatarName = Convert.ToString(reader["avatar_name"]),
                UserBio = Convert.ToString(reader["user_bio"])
                
            };
        }
    }
}
