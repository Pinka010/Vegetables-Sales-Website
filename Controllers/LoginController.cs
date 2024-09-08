using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using WebCoSo.Models;

namespace WebCoSo.Controllers
{
    public class LoginController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(string Acc, string Pass)
        {
            string mk = MaHoa.encryptSHA256(Pass);
            //--Đọc thông tin từ database thông qua data model để xét có đúng tài khoản và mật khẩu không!
            TaiKhoan ttdn = new CoSoKTPMConnect().TaiKhoans.Where(x => x.TaiKhoan1.Equals(Acc.ToLower().Trim()) && x.MatKhau.Equals(mk)).First<TaiKhoan>();
            bool isAuthentic = ttdn !=null && ttdn.TaiKhoan1.Equals(Acc.ToLower().Trim()) && ttdn.MatKhau.Equals(mk);
            if (isAuthentic)
            {
                Session["TtDangNhap"] = ttdn;
                return RedirectToAction("Index", "Dashboard", new { Area = "PrivatePages" });
            }    
               
            return View();
        }
    }
}