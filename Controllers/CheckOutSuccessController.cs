using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using WebCoSo.Models;

namespace WebCoSo.Controllers
{
    public class CheckOutSuccessController : Controller
    {
        // GET: CheckOutSuccess
        public ActionResult Index()
        {
            //--- Lấy giỏ hàng từ Sessiopn để hển thị lần cuối
            CartShop gh = Session["GioHang"] as CartShop;
            //--- Truyền ra ngoài View
            ViewData["Cart"] = gh;
            //--- Xóa giỏ hàng trong  Session
            Session["GioHang"] = new CartShop();
            return View();
        }
    }
}