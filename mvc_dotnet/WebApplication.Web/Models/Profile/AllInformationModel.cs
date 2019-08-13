using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Profile
{
    public class AllInformationModel
    {
        MatchStrengthModel CurrentUser = new MatchStrengthModel();
        List<MatchStrengthModel> AllUsers = new List<MatchStrengthModel>();

        public List<MatchStrengthModel> Matches (List<MatchStrengthModel> allUsers, MatchStrengthModel currentUser)
        {
            //List<MatchStrengthModel> Matches = new List<MatchStrengthModel>();
            
            
            int totalTitles = currentUser.Title.Count;
            int totalStyles = 3;

            foreach (var user in allUsers)
            {
                int titleCount = 0;
                int experience = 0;
                int style = 0;

                foreach (var title in currentUser.Title)
                {
                    for (int i = 0; i < user.Title.Count; i++)
                    {
                        if (user.Title[i] == title)
                        {
                            titleCount++;
                        }
                    }
                }
                foreach (var gameStyle in currentUser.Style)
                {
                    for (int i = 0; i < user.Style.Count; i++)
                    {
                        if (user.Style[i] == gameStyle)
                        {
                            style++;
                        }
                    }
                }
                if(user.Experience == currentUser.Experience)
                {
                    experience++;
                }
                double matchStrength = (titleCount + experience + style)/(totalTitles + totalStyles + 1);
                user.MatchStrength = matchStrength;
               
            }

            return allUsers;
        }
    }
}
