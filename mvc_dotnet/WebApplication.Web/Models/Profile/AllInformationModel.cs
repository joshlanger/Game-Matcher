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
            int totalGenres = 0;

            string name = "";
            string title = "";
            string genreBlocker = "";
            int titleCount = 0;
            int experience = 0;
            int genreCount = 0;
            string genreCountFinder = currentUser[0].Title;
            string titleCountFinder = "";

            for (int k = 0; k < currentUser.Count; k++)
            {
                
                if(currentUser[k].Title == genreCountFinder)
                {
                    totalGenres++;
                }
                if(currentUser[k].Title != titleCountFinder)
                {
                    totalTitles++;
                    titleCountFinder = currentUser[k].Title;
                }
            }
            genreCountFinder = "";
            titleCountFinder = "a";
            //NOTE THAT YOU HAD TOTALTITLES = 0 IN THE METHOD. TAKING THAT OUT MAY FIX IT WITHOUT THE && STATEMENTS YOU ADDED
            for(int j = 0; j < allUsers.Count; j++)
            {
                if (allUsers[j].Username != name)
                {
                    genreBlocker = AllUsers[j].Title;
                }


                if (allUsers[j].Username != currentUser[0].Username)
                {
                    if (name == allUsers[j].Username)
                    {
                        
                        for (int i = 0; i < currentUser.Count; i++)
                        {
                            //if (allUsers[j].Username != name)
                            //{
                            //    genreBlocker = CurrentUser[0].Title;
                            //}

                            if (currentUser[i].Title == allUsers[j].Title && title != allUsers[j].Title)
                            {
                                titleCount++;
                                title = allUsers[j].Title;
                            }//added the last && statement
                            if (currentUser[i].Genre == allUsers[j].Genre && genreBlocker == allUsers[j].Title && currentUser[0].Title == currentUser[i].Title)
                            {
                                genreCount++;
                                
                            }
                        }
                    }

                    if (name == "")
                    {
                        //if (allUsers[j].Username != name)
                        //{
                        //    genreBlocker = CurrentUser[0].Title;
                        //}
                        //name = allUsers[j].Username;

                        
                        for(int i = 0; i < currentUser.Count; i++)
                        {
                            if(currentUser[0].Experience == allUsers[j].Experience && i == 0)
                            {
                                experience++;
                            }
                            if(currentUser[i].Title == allUsers[j].Title && title != allUsers[j].Title)
                            {
                                titleCount++;
                                title = allUsers[j].Title;
                            }//added the last && statement
                            if (currentUser[i].Genre == allUsers[j].Genre && genreBlocker == CurrentUser[0].Title && currentUser[0].Title == currentUser[i].Title)
                            {
                                genreCount++;
                            }
                        }
                        
                    }
                    if(name != allUsers[j].Username)
                    {

                        double matchStrength = ((titleCount + experience + genreCount) / (totalTitles + totalGenres + 1.00)) * 100.00;
                        allUsers[j-1].MatchStrength = Math.Round(matchStrength, 2);
                        Matches.Add(allUsers[j-1]);
                        name = allUsers[j].Username;
                        titleCount = 0;
                        experience = 0;
                        genreCount = 0;
                        
                       

                        for (int i = 0; i < currentUser.Count; i++)
                        {
                            //if (allUsers[j].Username != name)
                            //{
                            //    genreBlocker = CurrentUser[0].Title;
                            //}

                            if (currentUser[0].Experience == allUsers[j].Experience && i == 0)
                            {
                                experience++;
                            }
                            if (currentUser[i].Title == allUsers[j].Title && title != allUsers[j].Title)
                            {
                                titleCount++;
                            }//added the last && statement
                            if (currentUser[i].Genre == allUsers[j].Genre && genreBlocker == CurrentUser[0].Title && currentUser[0].Title == currentUser[i].Title)
                            {
                                genreCount++;
                            }
                        }

                    }
                    if(j == allUsers.Count-1)
                    {
                        double matchStrength = ((titleCount + experience + genreCount) / (totalTitles + totalGenres + 1.00)) *100.00;
                        allUsers[allUsers.Count - 1].MatchStrength = Math.Round(matchStrength, 2);
                        Matches.Add(allUsers[allUsers.Count - 1]);
                    }
                    //if (title != allUsers[j].Title)
                    //{
                    //    totalTitles++;
                    //}
                    
                    //totalTitles++;
                    //totalGenres++;
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

        //public List<MatchStrengthModel> Matches(List<MatchStrengthModel> allUsers, List<MatchStrengthModel> currentUser)
        //{
        //    List<MatchStrengthModel> Matches = new List<MatchStrengthModel>();

        //    int totalTitles = 0;
        //    int totalStyles = 0;

        //    string name = "";
        //    int titleCount = 0;
        //    int experience = 0;
        //    int styleCount = 0;

        //    for (int j = 0; j < allUsers.Count; j++)
        //    {
        //        if (allUsers[j].Username != currentUser[0].Username)
        //        {
        //            if (name == allUsers[j].Username)
        //            {
        //                for (int i = 0; i < currentUser.Count; i++)
        //                {

        //                    if (currentUser[i].Title == allUsers[j].Title)
        //                    {
        //                        titleCount++;
        //                    }
        //                    if (currentUser[i].Style == allUsers[j].Style)
        //                    {
        //                        styleCount++;
        //                    }
        //                }
        //            }

        //            if (name == "")
        //            {
        //                name = allUsers[j].Username;


        //                for (int i = 0; i < currentUser.Count; i++)
        //                {
        //                    if (currentUser[0].Experience == allUsers[j].Experience && i == 0)
        //                    {
        //                        experience++;
        //                    }
        //                    if (currentUser[i].Title == allUsers[j].Title)
        //                    {
        //                        titleCount++;
        //                    }
        //                    if (currentUser[i].Style == allUsers[j].Style)
        //                    {
        //                        styleCount++;
        //                    }
        //                }

        //            }
        //            if (name != allUsers[j].Username)
        //            {

        //                double matchStrength = ((titleCount + experience + styleCount) / (totalTitles + totalStyles + 1.00)) * 100.00;
        //                allUsers[j - 1].MatchStrength = Math.Round(matchStrength, 2);
        //                Matches.Add(allUsers[j - 1]);
        //                name = allUsers[j].Username;
        //                titleCount = 0;
        //                experience = 0;
        //                styleCount = 0;
        //                totalStyles = 0;
        //                totalTitles = 0;
        //                for (int i = 0; i < currentUser.Count; i++)
        //                {
        //                    //check to see this is getting hit on the first row of a different gamer
        //                    if (currentUser[0].Experience == allUsers[j].Experience && i == 0)
        //                    {
        //                        experience++;
        //                    }
        //                    if (currentUser[i].Title == allUsers[j].Title)
        //                    {
        //                        titleCount++;
        //                    }
        //                    if (currentUser[i].Style == allUsers[j].Style)
        //                    {
        //                        styleCount++;
        //                    }
        //                }

        //            }
        //            if (j == allUsers.Count - 1)
        //            {
        //                double matchStrength = ((titleCount + experience + styleCount) / (totalTitles + totalStyles + 1.00)) * 100.00;
        //                allUsers[allUsers.Count - 1].MatchStrength = Math.Round(matchStrength, 2);
        //                Matches.Add(allUsers[allUsers.Count - 1]);
        //            }

        //            totalTitles++;
        //            totalStyles++;
        //        }
        //    }

        //    return Matches;
        //}
    }
}
