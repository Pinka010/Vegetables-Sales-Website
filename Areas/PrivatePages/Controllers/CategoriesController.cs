using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebCoSo.Areas.PrivatePages.Controllers
{
    public class CategoriesController : Controller
    {
        // GET: PrivatePages/Categories
        public ActionResult Index()
        {
            return View();
        }
    }
}