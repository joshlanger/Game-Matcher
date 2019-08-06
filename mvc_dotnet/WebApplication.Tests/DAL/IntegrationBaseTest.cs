using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
using System.Transactions;

namespace WebApplication.Tests.DAL
{
    [TestClass]
    public class IntegrationBaseTest
    {
        protected int UserId { get; set; }
        protected int ProfileId { get; set; }
        protected string Salt { get; set; }
        private TransactionScope transaction;

        protected string connectionString = "Server=.\\SQLEXPRESS; Database=GamingMastcher;Trusted_Connection=True;";

        [TestInitialize]
        public void Initializer()
        {
            transaction = new TransactionScope();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string deleteText = "delete from profile; delete from users;";
                SqlCommand command = new SqlCommand(deleteText, connection);
                command.ExecuteNonQuery();

                string cmdText = $"insert into users(username, email, password, salt, role, zipcode) values('IvoryUnclerico','campbellchadm@gmail.com','Ben82317','','user',15132); select scope_idetity();";
                command = new SqlCommand(cmdText, connection);
                UserId = Convert.ToInt32(command.ExecuteScalar());

                cmdText = $"insert into profile(user_id, first_name, last_name) values({UserId}, 'Chad', 'Campbell'); select scope_idetity();";
                command = new SqlCommand(cmdText, connection);
                ProfileId = Convert.ToInt32(command.ExecuteScalar());
                
            }
        }
        [TestCleanup]
        public void CleanUp()
        {
            transaction.Dispose();
        }
        protected int GetRowCount(string table)
        {
            int count;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand($"select count(*) from {table}", conn);
                count = Convert.ToInt32(cmd.ExecuteScalar());
            }
            return count;
        }
    }
}
