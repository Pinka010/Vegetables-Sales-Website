﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using WebCoSo.Models;

namespace WebCoSo.Controllers
{
    public class CartController : Controller
    {
        // GET: Card
        [HttpGet]
        public ActionResult Index()
        {
            CartShop gh = Session["GioHang"] as CartShop;
            ViewData["Carts"] = gh;
            return View();
        }
        public ActionResult Increase(string maSP)
        {
            CartShop gh = Session["GioHang"] as CartShop;
            gh.addItem(maSP);
            Session["GioHang"] = gh;
            return RedirectToAction("Index");
        }
        public ActionResult Decrease(string maSP)
        {
            CartShop gh = Session["GioHang"] as CartShop;
            gh.decrease(maSP);
            Session["GioHang"] = gh;
            return RedirectToAction("Index");
        }
        public ActionResult RemoveItem(string maSP)
        {
            CartShop gh = Session["GioHang"] as CartShop;
            gh.deleteItem(maSP);
            Session["GioHang"] = gh;
            return RedirectToAction("Index");
        }
    }
}