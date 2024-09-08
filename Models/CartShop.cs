using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebCoSo.Models
{
    public class CartShop
    {
        public string MaKh { get; set; }
        public string TaiKhoan { get; set; }
        public DateTime NgayDat { get; set; }
        public DateTime NgayGiao { get; set; }
        public string DiaChi { get; set; }

        public SortedList<string, CtDonHang> SanPhamDC { get; set; }
        public CartShop()
        {
            this.MaKh = ""; this.TaiKhoan = ""; this.NgayDat = DateTime.Now; this.NgayGiao = DateTime.Now.AddDays(2);
            this.DiaChi = "";
            this.SanPhamDC = new SortedList<string, CtDonHang>();
        }
        public bool IsEmpty()
        {
            return (SanPhamDC.Keys.Count == 0);
        }
        public void addItem(string masp)
        {
            if(SanPhamDC.Keys.Contains(masp))
            {
                CtDonHang x = SanPhamDC.Values[SanPhamDC.IndexOfKey(masp)];
                x.SoLuong++;
                updateOneItem(x);
            }
            else
            {
                CtDonHang i = new CtDonHang();
                i.MaSP = masp;
                i.SoLuong = 1;
                SanPham z = CosoKtpm.getProductById(masp);
                i.GiaBan = z.GiaBan;
                i.GiamGia = z.GiamGia;
                SanPhamDC.Add(masp, i);
            }
        }
        public void updateOneItem(CtDonHang x)
        {
            this.SanPhamDC.Remove(x.MaSP);
            this.SanPhamDC.Add(x.MaSP, x);
        }
        public void deleteItem(string masp)
        {
            if (SanPhamDC.Keys.Contains(masp))
                SanPhamDC.Remove(masp);
        }
        public void decrease(string masp)
        {
            if (SanPhamDC.Keys.Contains(masp))
            {
                CtDonHang x = SanPhamDC.Values[SanPhamDC.IndexOfKey(masp)];
                if (x.SoLuong > 1)
                {
                    x.SoLuong--;
                    updateOneItem(x);
                }
                else
                    deleteItem(masp);
            }
        }
        public long moneyOfOneProduct(CtDonHang x)
        {
            return (long)((x.GiaBan * x.SoLuong) - ((x.GiaBan - x.SoLuong) * (x.GiamGia / 100)));
        }
        public long totalOfCartShop()
        {
            long kq = 0;
            foreach (CtDonHang i in SanPhamDC.Values)
                kq += moneyOfOneProduct(i);
            return kq;
        }
    }
}