using CRUD__App_ADO_NET.DAL;
using CRUD__App_ADO_NET.Models;
using Microsoft.AspNetCore.Mvc;

namespace CRUD__App_ADO_NET.Controllers
{
    public class EmployeeController : Controller
    {
        private readonly Employee_DAL _employee;

        public EmployeeController(Employee_DAL employee)
        {
            _employee = employee;
        }
        [HttpGet]
        public ActionResult Index()
        {
            List<Employee> employees = new List<Employee>();
            try
            {
                employees = _employee.GetAll();
            }
            catch (Exception ex)
            {
                TempData["errorMessage"] = ex.Message;
            }
            return View(employees);
        }

    }
}
