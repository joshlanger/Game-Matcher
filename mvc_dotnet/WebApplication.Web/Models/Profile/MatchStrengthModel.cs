using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication.Web.Models.Profile
{
    public class MatchStrengthModel
    {
        public int ProfileId { get; set; }
        public string Username { get; set; }
        public string Title { get; set; }
        public string Experience { get; set; }
        public string Style { get; set; }
        public double MatchStrength { get; set; }
        

        //public List<MatchStrengthModel> Converter(List<MatchStrengthModel> databaseList)
        //{
        //    List<MatchStrengthModel> ConvertedList = new List<MatchStrengthModel>();
        //    MatchStrengthModel Container = new MatchStrengthModel();
        //    List<string> TitleContainer = new List<string>();
        //    List<string> StyleContainer = new List<string>();
        //    string currentUserName = "";
        //    int j = 0;
        //    for(int i = 0; i < databaseList.Count; i++)
        //    {
                
                
        //        if(currentUserName == "")
        //        {
        //            currentUserName= databaseList[0].Username;
        //            Container.ProfileId = databaseList[0].ProfileId;
        //            Container.Username = databaseList[0].Username;
        //            Container.Experience = databaseList[0].Experience;
        //        }
        //        if (currentUserName != databaseList[i].Username)
        //        {
        //            ConvertedList.Add(Container);
        //            Container = null;
        //            currentUserName = databaseList[i].Username;
        //            Container.ProfileId = databaseList[i].ProfileId;
        //            Container.Username = databaseList[i].Username;
        //            Container.Experience = databaseList[i].Experience;
                    
        //        }
        //        if (currentUserName == databaseList[i].Username)
        //        {
                    
        //            Container.TitleList.Add(databaseList[i].Title);
        //            Container.StyleList.Add(databaseList[i].Style);
        //        }
                
        //    }
        //    return ConvertedList;
        //}
    }
}
