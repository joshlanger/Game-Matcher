using Microsoft.AspNetCore.Mvc.Rendering;
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
                    SqlCommand cmd = new SqlCommand("SELECT * from profile JOIN users on profile.user_id = users.user_id where users.username = @username", conn);
                    cmd.Parameters.AddWithValue("@username", username);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        profile = MapRowToProfile(reader);
                    }
                    profile.Games = GetGames();
                    profile.GameTitles = GameNames(profile);
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
                    SqlCommand cmd = new SqlCommand("UPDATE profile SET user_name = @user_name, avatar_name = @avatar_name, user_bio = @user_bio, gaming_experience = @gaming_experience, contact_preference = @contact_preference, other_interests = @other_interests, is_Private = @is_private WHERE user_id = @user_id", conn);
                    cmd.Parameters.AddWithValue("@user_id", profile.UserId);
                    cmd.Parameters.AddWithValue("@profile_id", profile.ProfileId);
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

        public IList<SelectListItem> GetGames()
        {
            List<SelectListItem> Games = new List<SelectListItem>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {

                    conn.Open();
                    SqlCommand cmd = new SqlCommand("select games_id, title from game_library", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Games.Add(new SelectListItem() { Text = Convert.ToString(reader["title"]), Value = Convert.ToString(reader["games_id"]) });
                    }

                    return Games;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

        }

        public void SaveGameOptions(ProfileViewModel gameEdit, int[] Games)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {

                    conn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO profile_game VALUES (@games_id, @profile_id)", conn);
                    cmd.Parameters.AddWithValue("@profile_id", gameEdit.ProfileId);
                    cmd.Parameters.Add("@games_id",System.Data.SqlDbType.Int);

                    foreach (int game_id in Games)
                    {
                        cmd.Parameters["@games_id"].Value =  game_id;
                        cmd.ExecuteNonQuery();
                    }
                    return;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

        }

        public string[] GameNames(ProfileViewModel profile)
        {
            List<string> GameTitles = new List<string>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {

                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT title from game_library JOIN profile_game ON game_library.games_id = profile_game.games_id WHERE profile_id = @profile_id", conn);
                    cmd.Parameters.AddWithValue("@profile_id", profile.ProfileId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        GameTitles.Add(Convert.ToString(reader["title"]));
                    }

                    string[] gameTitles = GameTitles.ToArray();
                    return gameTitles;
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
                ContactPreference = Convert.ToString(reader["contact_preference"]),
                OtherInterests = Convert.ToString(reader["other_interests"]),
                IsPrivate = Convert.ToBoolean(reader["is_Private"])
            };
        }
    }
}
