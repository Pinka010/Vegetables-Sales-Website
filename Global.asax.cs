using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;


using WebCoSo.Models;

namespace WebCoSo
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }
        protected void Session_Start(Object sender, EventArgs e)
        {
            Session["TtDangNhap"] = null;
            Session["GioHang"] = new CartShop();
        }
    }
}
