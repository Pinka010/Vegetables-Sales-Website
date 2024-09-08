using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using WebCoSo.Models;

namespace WebCoSo.Areas.PrivatePages.Controllers
{
    public class CustomersController : Controller
    {
        private static CoSoKTPMConnect db = new CoSoKTPMConnect();
        private static bool GioiTinh;
        [HttpGet]
        // GET: PrivatePages/Customers
        public ActionResult Index()
        {
            List<KhachHang> l = new CoSoKTPMConnect().KhachHangs.OrderBy(x => x.MaKH).ToList<KhachHang>();
            ViewData["DanhSachKH"] = l;
            return View();
        }
    }
}