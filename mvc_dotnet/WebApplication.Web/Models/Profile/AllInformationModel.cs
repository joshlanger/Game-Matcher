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

                            if (currentUser[i].Title == allUsers[j].Title && title != allUsers[j].Title)
                            {
                                titleCount++;
                                title = allUsers[j].Title;
                            }
                            if (currentUser[i].Genre == allUsers[j].Genre && genreBlocker == allUsers[j].Title && currentUser[0].Title == currentUser[i].Title)
                            {
                                genreCount++;
                                
                            }
                        }
                    }

                    if (name == "")
                    {
                       

                        
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
                            }
                            if (currentUser[i].Genre == allUsers[j].Genre && genreBlocker == allUsers[j].Title && currentUser[0].Title == currentUser[i].Title)
                            {
                                genreCount++;
                            }
                        }
                        name = allUsers[j].Username;
                    }
                    if(name != allUsers[j].Username)
                    {

                        double matchStrength = ((titleCount + experience + genreCount) / (totalTitles + totalGenres + 1.00)) * 100.00;
                        //if (j == 0)
                        //{
                        //    //allUsers[j].MatchStrength = Math.Round(matchStrength, 2);
                        //    //Matches.Add(allUsers[j]);
                        //}
                        //else
                        //{
                        //    titleCount = 0;
                        //    experience = 0;
                        //    genreCount = 0;

                        //    allUsers[j - 1].MatchStrength = Math.Round(matchStrength, 2);
                        //    Matches.Add(allUsers[j - 1]);

                        //}
                        

                        //adds the gamer from the previous stack of data rows to the matches list.  the change of the username is the
                        //indication that there is no more info about the gamer to evaluate.
                        allUsers[j - 1].MatchStrength = Math.Round(matchStrength, 2);
                        Matches.Add(allUsers[j - 1]);

                        name = allUsers[j].Username;

                        //resets the count of matches now that a new username has been encountered
                        titleCount = 0;
                        experience = 0;
                        genreCount = 0;



                        for (int i = 0; i < currentUser.Count; i++)
                        {

                            if (currentUser[0].Experience == allUsers[j].Experience && i == 0)
                            {
                                experience++;
                            }
                            if (currentUser[i].Title == allUsers[j].Title && title != allUsers[j].Title)
                            {
                                titleCount++;
                            }
                            if (currentUser[i].Genre == allUsers[j].Genre && genreBlocker == allUsers[j].Title && currentUser[0].Title == currentUser[i].Title)
                            {
                                genreCount++;
                            }
                        }

                    }
                    //this is to deal with the last item in the list, since objects are added to the matches list only after username changes.
                    if(j == allUsers.Count-1)
                    {
                        double matchStrength = ((titleCount + experience + genreCount) / (totalTitles + totalGenres + 1.00)) *100.00;
                        allUsers[allUsers.Count - 1].MatchStrength = Math.Round(matchStrength, 2);
                        Matches.Add(allUsers[allUsers.Count - 1]);
                    }
                    
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

        //remove the current user from the list
        public List<MatchStrengthModel> RemoveCurrentGamer(List<MatchStrengthModel> matches, string username)
        {
            int userIndex = 0;
            bool exists = false;
            for(int i = 0; i< matches.Count; i++)
            {
                if(matches[i].Username == username)
                {
                    userIndex = i;
                    exists = true;
                }
            }
           
            if(exists)
            {
                matches.Remove(matches[userIndex]);
            }
            return matches;
        }
       
        public List<MatchStrengthModel> GetTopThree(List<MatchStrengthModel> allUsers)
        {
            List<MatchStrengthModel> TopThree = new List<MatchStrengthModel>();

            double topMatch = 0;
            string topUserName = "";
            double secondPlace = 0;
            string secondName = "";
            double thirdPlace = 0;
            string thirdName = "";

           
            for (int i = 0; i < allUsers.Count; i++)
            {              
                if (allUsers[i].MatchStrength > topMatch)
                {
                    topMatch = allUsers[i].MatchStrength;
                    topUserName = allUsers[i].Username;
                }
            }
            for (int i = 0; i < allUsers.Count; i++)
            {
                if(allUsers[i].MatchStrength > secondPlace && allUsers[i].Username != topUserName)
                {
                    secondPlace = allUsers[i].MatchStrength;
                    secondName = allUsers[i].Username;
                }
            }
            for(int i = 0; i < allUsers.Count; i++)
            {
                if(allUsers[i].MatchStrength > thirdPlace && allUsers[i].Username != topUserName && allUsers[i].Username != secondName)
                {
                    thirdPlace = allUsers[i].MatchStrength;
                    thirdName = allUsers[i].Username;
                }
            }
            foreach(var gamer in allUsers)
            {
                if(topUserName == gamer.Username)
                {
                    TopThree.Add(gamer);
                }
                if(secondName == gamer.Username)
                {
                    TopThree.Add(gamer);
                }
                if(thirdName == gamer.Username)
                {
                    TopThree.Add(gamer);
                }
            }
            return TopThree;
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
