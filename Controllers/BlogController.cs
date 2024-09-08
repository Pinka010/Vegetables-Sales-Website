using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using WebCoSo.Models;
namespace WebCoSo.Controllers
{
    public class BlogController : Controller
    {
        // GET: Blog
        public ActionResult Index(string MaBV)
        {
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            BaiViet x = db.BaiViets.Where(z => z.MaBV == MaBV).First<BaiViet>();
            ViewData["BaiCanXem"] = x;
            return View();
        }
    }
}