using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using WebCoSo.Models;
namespace WebCoSo.Controllers
{
    public class ProductDetailsController : Controller
    {
        // GET: ProductDetails
        public ActionResult Index(string maSanPham)
        {
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            SanPham x = db.SanPhams.Where(z => z.MaSP == maSanPham).First<SanPham>();
            ViewData["SpCanXem"] = x;
            return View();
        }
    }
}