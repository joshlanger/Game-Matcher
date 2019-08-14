using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Profile
{
    public class AllInformationModel
    {
        public List<MatchStrengthModel> CurrentUser { get; set; }
        public List<MatchStrengthModel> AllUsers { get; set;}
        public List<MatchStrengthModel> GamerMatchStrength { get; set; }

        //style is getting weighted more than title.
        public List<MatchStrengthModel> Matches (List<MatchStrengthModel> allUsers, List<MatchStrengthModel> currentUser)
        {
            List<MatchStrengthModel> Matches = new List<MatchStrengthModel>();
 
            int totalTitles = 0;
            int totalStyles = 0;

            string name = "";
            int titleCount = 0;
            int experience = 0;
            int styleCount = 0;

            for(int j = 0; j < allUsers.Count; j++)
            {
                if (allUsers[j].Username != currentUser[0].Username)
                {
                    if (name == allUsers[j].Username)
                    {
                        for (int i = 0; i < currentUser.Count; i++)
                        {
                           
                            if (currentUser[i].Title == allUsers[j].Title)
                            {
                                titleCount++;
                            }
                            if (currentUser[i].Style == allUsers[j].Style)
                            {
                                styleCount++;
                            }
                        }
                    }

                    if (name == "")
                    {
                        name = allUsers[j].Username;

                        
                        for(int i = 0; i < currentUser.Count; i++)
                        {
                            if(currentUser[0].Experience == allUsers[j].Experience && i == 0)
                            {
                                experience++;
                            }
                            if(currentUser[i].Title == allUsers[j].Title)
                            {
                                titleCount++;
                            }
                            if(currentUser[i].Style == allUsers[j].Style)
                            {
                                styleCount++;
                            }
                        }
                    }
                    if(name != allUsers[j].Username)
                    {

                        double matchStrength = ((titleCount + experience + styleCount) / (totalTitles + totalStyles + 1.00)) * 100.00;
                        allUsers[j].MatchStrength = matchStrength;
                        Matches.Add(allUsers[j]);
                        name = allUsers[j].Username;
                        titleCount = 0;
                        experience = 0;
                        styleCount = 0;
                        totalStyles = 0;
                        totalTitles = 0;
                        for (int i = 0; i < currentUser.Count; i++)
                        {
                            if (currentUser[0].Experience == allUsers[j].Experience && i == 0)
                            {
                                experience++;
                            }
                            if (currentUser[i].Title == allUsers[j].Title)
                            {
                                titleCount++;
                            }
                            if (currentUser[i].Style == allUsers[j].Style)
                            {
                                styleCount++;
                            }
                        }

                    }
                    if(j == allUsers.Count-1)
                    {
                        double matchStrength = ((titleCount + experience + styleCount) / (totalTitles + totalStyles + 1.00)) *100.00;
                        allUsers[allUsers.Count - 1].MatchStrength = matchStrength;
                        Matches.Add(allUsers[allUsers.Count - 1]);
                    }

                    totalTitles++;
                    totalStyles++;
                }
            }

            return Matches;
        }

        public List<MatchStrengthModel> GetCurrentGamer(List<MatchStrengthModel> allUsers, string username)
        {
            List<MatchStrengthModel> CurrentGamer = new List<MatchStrengthModel>();
            foreach(var user in allUsers)
            {
                if(user.Username == username)
                {
                    CurrentGamer.Add(user);
                }
            }
            return CurrentGamer;
        }

        //int totalTitles = currentUser.Title.Count;
        //int totalStyles = currentUser.Style.Count;

        //foreach (var user in allUsers)
        //{
        //    if(user.Username != currentUser.Username)
        //    { 
        //    int titleCount = 0;
        //    int experience = 0;
        //    int style = 0;

        //    foreach (var title in currentUser.Title)
        //    {
        //        for (int i = 0; i < user.Title.Count; i++)
        //        {
        //            if (user.Title[i] == title)
        //            {
        //                titleCount++;
        //            }
        //        }
        //    }
        //    foreach (var gameStyle in currentUser.Style)
        //    {
        //        for (int i = 0; i < user.Style.Count; i++)
        //        {
        //            if (user.Style[i] == gameStyle)
        //            {
        //                style++;
        //            }
        //        }
        //    }
        //    if(user.Experience == currentUser.Experience)
        //    {
        //        experience++;
        //    }
        //    double matchStrength = (titleCount + experience + style)/(totalTitles + totalStyles + 1);
        //    user.MatchStrength = matchStrength;
        //    }
        //}
    }
}
