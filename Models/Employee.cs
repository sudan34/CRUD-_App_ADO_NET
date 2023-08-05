using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CRUD__App_ADO_NET.Models
{
    public class Employee
    {
        [Key]
        public int Id { get; set; }
        [Required]
        [DisplayName("First Name")]
        public string FirstName { get; set; }
        [Required]
        [DisplayName("Last Name")]

        public string LastName { get; set; }
        [Required]
        [DisplayName("Date of Birth")]

        public DateTime DateOfBirth { get; set; }
        [DisplayName("E-mail")]
        public string Email { get; set; }
        [Required]
        public double Salary { get; set; }

        [NotMapped]
        public string FullName
        {
            get { return FirstName + "" + LastName; }
        }
    }
}
