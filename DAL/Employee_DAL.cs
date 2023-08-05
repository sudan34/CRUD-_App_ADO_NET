using CRUD__App_ADO_NET.Models;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;

namespace CRUD__App_ADO_NET.DAL
{
    public class Employee_DAL
    {
        SqlConnection _connection = null;
        SqlCommand _command = null;
        public static IConfiguration Configuration { get; set; }
        private string GetConnectionString()
        {
            var builder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json");
            Configuration = builder.Build();
            return Configuration.GetConnectionString("DefaultConnection");
        }
        public List<Employee> GetAll()
        {
            List<Employee> emplist = new List<Employee>();
            using (_connection = new SqlConnection(GetConnectionString()))
            {
                _command = _connection.CreateCommand();
                _command.CommandType = System.Data.CommandType.StoredProcedure;
                _command.CommandText = "[dbo].[sp_Get_Employees]";
                _connection.Open();
                SqlDataReader dr = _command.ExecuteReader();

                while (dr.Read())
                {
                    Employee emp = new Employee();
                    emp.Id = Convert.ToInt32(dr["Id"]);
                    emp.FirstName = dr["FirstName"].ToString();
                    emp.LastName = dr["LastName"].ToString();
                    emp.DateOfBirth = Convert.ToDateTime(dr["DateOfBirth"]).Date;
                    emp.Email = dr["Email"].ToString();
                    emp.Salary = Convert.ToDouble(dr["Salary"]);
                    emplist.Add(emp);
                }
                _connection.Close();
            }
            return emplist;
        }
    }
}

