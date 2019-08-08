using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Text;
using WebApplication.Web.DAL;
using WebApplication.Web.Models;

namespace WebApplication.Tests.DAL
{
    [TestClass]
    public class UserSqlDALTests: IntegrationBaseTest
    {
        [TestMethod]
        public void ShouldReturnUser()
        {
            UserSqlDAL dao = new UserSqlDAL(connectionString);
            string username ="IvoryUnclerico";
            User user = dao.GetUser(username);
            Assert.AreEqual("IvoryUnclerico", );
        }
        

    }
}
