using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Web.Models.Account;
using WebApplication.Web.Models.Profile;

namespace WebApplication.Web.DAL
{
    public class ProfileSearchSqlDAL : IProfileSearchDAL
    {
        private string connectionString;

        public ProfileSearchSqlDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public int SearchProfileByUsername (string username)
        {
            int id = -1;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT profile_id from profile WHERE user_name = @username", conn);
                    cmd.Parameters.AddWithValue("@username", username);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if(reader.Read())
                    {
                        id = Convert.ToInt32(reader["profile_id"]);
                    }

                    return id;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
               
            }
        }

        public ProfileViewModel GetProfile(int profileId)
        {
            ProfileViewModel Profile = new ProfileViewModel();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {

                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * from profile WHERE profile_id = @profileId", conn);
                    cmd.Parameters.AddWithValue("@profileId", profileId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        Profile = MapRowToProfile(reader);
                    }

                    return Profile;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public List<ProfileViewModel> SearchByGenre(string genre)
        {
            List<ProfileViewModel> Results = new List<ProfileViewModel>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {

                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * from profile WHERE favorite_genres LIKE %@genre%", conn);
                    cmd.Parameters.AddWithValue("@genre", genre);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        var Container = MapRowToProfile(reader);
                        Results.Add(Container);
                    }

                    return Results;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
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
                GamingExperience = Convert.ToString(reader["gaming_experience"]),
                FavoriteGenres = Convert.ToString(reader["favorite_genres"]),
                ContactPreference = Convert.ToString(reader["contact_preference"]),
                OtherInterests = Convert.ToString(reader["other_interests"]),
                IsPrivate = Convert.ToBoolean(reader["is_Private"])
            };
        }
    }
}
