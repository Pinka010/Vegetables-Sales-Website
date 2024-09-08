using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Security.Cryptography;
using System.Text;

namespace WebCoSo.Models
{
    public class MaHoa
    {
        //--Hàm phục vụ cho mục đích mã hóa một chuỗi văn bản gốc dựa vào việc băm dữ liệu bởi SHA256
        public static string encryptSHA256(string PlainText)
        {
            string result = "";
            using (SHA256 hh = SHA256.Create())
            {
                //--Convert plain text to a bytes array
                byte[] sourceData = Encoding.UTF8.GetBytes(PlainText);
                byte[] hashResult = hh.ComputeHash(sourceData);
                result = BitConverter.ToString(hashResult);
            }
            return result;
        }
    }
}