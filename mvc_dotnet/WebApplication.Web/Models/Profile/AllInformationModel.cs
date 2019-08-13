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
            List<MatchStrengthModel> Matches = new List<MatchStrengthModel>();


            //foreach(var user in allUsers)
            //{
            //    if () { } ;
            //}

            return Matches;
        }
    }
}
