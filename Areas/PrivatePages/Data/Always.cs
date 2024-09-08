using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using WebCoSo.Models;

namespace WebCoSo.Areas.PrivatePages.Data
{
    public class Always
    {
        public static TaiKhoan GetTaiKhoanHH()
        {
            TaiKhoan a = new TaiKhoan();
            a = HttpContext.Current.Session["TtDangNhap"] as TaiKhoan;
            return a;
        }
        /// <summary>
        /// Lấy tên của tài khoản đã đăng nhập trong hệ thống
        /// </summary>
        /// <returns></returns>
        public static string GetTenTaiKhoan()
        {
            return GetTaiKhoanHH().TaiKhoan1;
        }
    }
}