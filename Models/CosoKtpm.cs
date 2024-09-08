using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace WebCoSo.Models
{
    public class CosoKtpm
    {
        //--Hàm cho phép lấy ra danh sách sản phẩm
        public static List<SanPham> getProducts()
        {
            List<SanPham> l = new List<SanPham>();
            //--khai báo 1 đối tượng đại diện cho database
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            l = cn.Set<SanPham>().ToList<SanPham>();
            return l;
        }
        public static List<SanPham> getProductsByLoaiSP(int MaLoai)
        {
            List<SanPham> l = new List<SanPham>();
            //--- Khai báo 1 đối tượng đại diện cho database
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            //--- Lấy dữ liệu
            l = cn.Set<SanPham>().Where(x => x.MaLoai == MaLoai).OrderByDescending(z => z.NgayDang).ToList<SanPham>();
            return l;
        }
        //--Hàm cho phép lấy ra danh sách chủng loại - ngành hàng
        public static List<LoaiSP> getCategorties()
        {
            return new DbContext("name=CoSoKTPMConnect").Set<LoaiSP>().ToList<LoaiSP>();
        }
        public static List<BaiViet> getArticle (int n)
        {
            List<BaiViet> l = new List<BaiViet>();
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            l = db.BaiViets.OrderByDescending(baiviet => baiviet.NgayDang).Take(n).ToList<BaiViet>();
            return l;
        }
        public static SanPham getProductById(string maSP)
        {
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            return cn.Set<SanPham>().Find(maSP);
        }
        public static string getNameOfProductByID(string maSP)
        {
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            return cn.Set<SanPham>().Find(maSP).TenSP;
        }
        public static string getImageOfProductByID(string maSP)
        {
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            return cn.Set<SanPham>().Find(maSP).HinhDD;
        }
    }
}