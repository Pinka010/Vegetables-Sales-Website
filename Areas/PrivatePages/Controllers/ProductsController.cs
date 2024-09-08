using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using WebCoSo.Models;

namespace WebCoSo.Areas.PrivatePages.Controllers
{
    public class ProductsController : Controller
    {
        // GET: PrivatePages/Customer
        private static CoSoKTPMConnect db = new CoSoKTPMConnect();
        private static bool DaDuyet;
        // GET: PrivatePages/Customers
        public ActionResult Index()
        {
            List<SanPham> l = new CoSoKTPMConnect().SanPhams.OrderBy(x => x.TenSP).ToList<SanPham>();
            ViewData["DanhSachSP"] = l;
            return View();
        }
    }
}