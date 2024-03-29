﻿using Microsoft.AspNetCore.Mvc.Rendering;
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
       

        public int SearchProfileByUsername(string username)
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

                    if (reader.Read())
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
            ProfileViewModel profile = new ProfileViewModel();
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
                        profile = MapRowToProfile(reader);
                    }

                    if (profile.Games == null && profile.Genres == null)
                    {
                        return profile;
                    }

                    return profile;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public List<ProfileViewModel> SearchAll(string parameter)
        {
            List<ProfileViewModel> Results = new List<ProfileViewModel>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"select profile.user_name, profile.is_Private, profile.profile_id, users.zipcode, game_library.title, game_library.style,   
                                    game_library.genre, genre_library.genre, profile.user_bio, profile.gaming_experience, profile.other_interests from board_game  
                                    full join profile_game on profile_game.games_id = board_game.games_id
                                    full join game_library on game_library.games_id = profile_game.games_id
                                    full join profile on profile.profile_id = profile_game.profile_id
                                    full join profile_genre on profile_genre.profile_id = profile.profile_id
                                    full join genre_library on profile_genre.genre_id = genre_library.genre_id
                                    full join users on profile.user_id = users.user_id
                                    where game_library.title like @parameter
                                    or game_library.style like @parameter 
                                    or game_library.genre like @parameter
                                    or genre_library.genre like @parameter
                                    or profile.user_name like @parameter
                                    or profile.user_bio like @parameter
                                    or profile.other_interests like @parameter
                                    or users.zipcode like @parameter
                                    or profile.gaming_experience like @parameter";


                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@parameter", "%" + parameter + "%");

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        var Container = MapRowToProfileForFullSearch(reader);
                        int index = Results.FindIndex(f => f.Username == Container.Username);
                        if (index == -1)
                        {
                            Results.Add(Container);
                        }  
                    }

                    return Results;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }        
        }

        public List<MatchStrengthModel> GetMatches()
        {
            List<MatchStrengthModel> Matches = new List<MatchStrengthModel>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {

                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"select profile.profile_id, profile.user_name, genre_library.genre, game_library.title, profile.gaming_experience from board_game  
                        full join profile_game on profile_game.games_id = board_game.games_id
                        full join game_library on game_library.games_id = profile_game.games_id
                        full join profile on profile.profile_id = profile_game.profile_id
                        full join profile_genre on profile_genre.profile_id = profile.profile_id
                        full join genre_library on profile_genre.genre_id = genre_library.genre_id
                        full join users on profile.user_id = users.user_id
                        where profile.is_Private = 'false' and game_library.title IS NOT NULL
                        ORDER BY profile.user_name", conn);

                    //sql statement for testing:

                    //SqlCommand cmd = new SqlCommand(@"select profile.profile_id, profile.user_name, genre_library.genre, game_library.title, profile.gaming_experience from board_game  
                    //    full join profile_game on profile_game.games_id = board_game.games_id
                    //    full join game_library on game_library.games_id = profile_game.games_id
                    //    full join profile on profile.profile_id = profile_game.profile_id
                    //    full join profile_genre on profile_genre.profile_id = profile.profile_id
                    //    full join genre_library on profile_genre.genre_id = genre_library.genre_id
                    //    full join users on profile.user_id = users.user_id
                    //    where profile.profile_id = 46 or profile.profile_id=58 and game_library.title IS NOT NULL", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                   
                    while (reader.Read())
                    {
                        MatchStrengthModel Container = new MatchStrengthModel();

                        Container.ProfileId = Convert.ToInt32(reader["profile_id"]);
                        Container.Username = Convert.ToString(reader["user_name"]);
                        Container.Genre = Convert.ToString(reader["genre"]);
                        Container.Title = Convert.ToString(reader["title"]);
                        Container.Experience = Convert.ToString(reader["gaming_experience"]);
                        

                        Matches.Add(Container);
                    }
                    return Matches;
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

        private ProfileViewModel MapRowToProfileForFullSearch(SqlDataReader reader)
        {
            ProfileViewModel Container = new ProfileViewModel();
   
            if(reader["user_name"] != DBNull.Value)
            {
                Container.Username = Convert.ToString(reader["user_name"]);
                Container.IsPrivate = Convert.ToBoolean(reader["is_Private"]);
                Container.ProfileId = Convert.ToInt32(reader["profile_id"]);
            }
            return Container;
        }
    }
}
