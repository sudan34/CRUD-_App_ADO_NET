using CRUD__App_ADO_NET.Models;
using Microsoft.EntityFrameworkCore;

namespace CRUD__App_ADO_NET.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }
        public DbSet<Employee> Employees { get; set; }
    }
}
