---A script creates a database.
 USE MASTER
 GO
 IF EXISTS(SELECT NAME FROM SYSDATABASES WHERE NAME ='DoAnCoSoKTPM')
 DROP DATABASE DoAnCoSoKTPM
 GO
 CREATE DATABASE CoSoKTPM 
 GO
 USE CoSoKTPM
 GO
 set dateformat DMY
-- 1: Tạo Table [Accounts] chứa tài khoản thành viên được phép sử dụng các trang quản trị ----
create table TaiKhoan
(
	TaiKhoan varchar(20) primary key not null,
	MatKhau varchar(20) not null,
	HoDem nvarchar(50) null,
	TenTV nvarchar(30) not null,
	Ngaysinh datetime ,
	GioiTinh bit default 1,
	SDT nvarchar(20),
	Email nvarchar(50),
	ĐiaChi nvarchar(250),
	TrangThai bit default 0,
	GhiChu ntext
)
go

-- 2: Tạo Table [Customers] chứa Thông tin khách hàng  ---------------------------------------
create table KhachHang
(
	MaKH varchar(10) primary key not null,
	TenKH nvarchar(50) not null,
	SDT varchar(20) ,
	Email varchar(50),
	DiaChi nvarchar(250),
	NgaySinh datetime ,
	GioiTinh bit default 1,
	GhiChu ntext
)
go

-- 3: Tạo Table [Articles] chứa thông tin về các bài viết phục vụ cho quảng bá sản phẩm, ------
--    xu hướng mua sắm hiện nay của người tiêu dùng , ...             ------------------------- 
create table BaiViet
(
	MaBV varchar(10) primary key not null,
	TenBV nvarchar(250) not null,
	HinhDD varchar(max),
	NdTomTat nvarchar(2000),
	NgayDang datetime ,
	LoaiTin nvarchar(30),
	NoiDung nvarchar(4000),
	TaiKhoan varchar(20) not null ,
	DaDuyet bit default 0,
	foreign key (TaiKhoan) references TaiKhoan(TaiKhoan) on update cascade 
)
go
-- 4: Tạo Table [LoaiSP] chứa thông tin loại sản phẩm, ngành hàng -----------------------------
create table LoaiSP
(
	MaLoai int primary key not null identity,
	TenLoai nvarchar(88) not null,
	GhiChu ntext default ''
)
go
-- 5: Tạo Table [Products] chứa thông tin của sản phẩm mà shop kinh doanh online --------------
create table SanPham
(
	MaSP varchar(10) primary key not null,
	TenSP nvarchar(500) not NULL,
	HinhDD varchar(max) DEFAULT '',
	NdTomTat nvarchar(2000) DEFAULT '',
	NgayDang DATETIME DEFAULT CURRENT_TIMESTAMP,
	MaLoai int not null references LoaiSP(maLoai),
	NoiDung nvarchar(4000) DEFAULT '',
	TaiKhoan varchar(20) not null foreign key references TaiKhoan(TaiKhoan) on update cascade,
	DVT nvarchar(32) default N'gram',
	DaDuyet bit default 0,
	GiaBan INTEGER DEFAULT 0,
	GiamGia INTEGER DEFAULT 0 CHECK (GiamGia>=0 AND GiamGia<=100),
	ThuongHieu nvarchar(168) default ''
)
go
-- 6: Tạo Table [Orders] chứa danh sách đơn hàng mà khách đã đặt mua thông qua web ------------
create table DonHang
(
	SoDH varchar(10) primary key not null ,
	MaKH varchar(10) not null foreign key references KhachHang(MaKH),
	TaiKhoan varchar(20) not null foreign key references TaiKhoan(TaiKhoan) on update cascade ,
	NgayDat datetime,
	DaKichHoat bit default 1,
	NgayGH datetime,
	DiaChiGH nvarchar(250),
	GhiChu ntext
)
go
-- 7: Tạo Table [OrderDetails] chứa thông tin chi tiết của các đơn hàng ---
--    mà khách đã đặt mua với các mặt hàng cùng số lượng đã chọn ---------- 
create table CtDonHang	
(
	SoDH varchar(10) not null foreign key references DonHang(SoDH),
	MaSP varchar(10) not null foreign key references SanPham(MaSP),
	SoLuong int,
	GiaBan bigint,
	GiamGia BIGINT,
	PRIMARY KEY (SoDH, MaSP)
)
go

/*========================== Nhập dữ liệu ==============================*/

--Nhập thông tin Tài khoản
insert into TaiKhoan 
values('lethithuhong','290403',N'Lê Thị Thu',N'Hồng','29/04/2003',0,'0838919981','2100005409@nttu.edu.vn',N'43/46 Vườn Lài, An Phú Đông, Quận 12 - Tp.HCM',1,'')
insert into TaiKhoan
values('thuhong','2904',N'Lê Thị Thu',N'Hồng','29/04/2003',0,'0838919981','2100005409@nttu.edu.vn',N'43/46 Vườn Lài, An Phú Đông, Quận 12 - Tp.HCM',1,'')
insert into TaiKhoan
values('ltth','299004003',N'Lê Thị Thu',N'Hồng','29/04/2003',0,'0838919981','2100005409@nttu.edu.vn',N'43/46 Vườn Lài, An Phú Đông, Quận 12 - Tp.HCM',1,'')
insert into TaiKhoan
values('lehong','030429',N'Lê Thị Thu',N'Hồng','29/04/2003',0,'0838919981','2100005409@nttu.edu.vn',N'43/46 Vườn Lài, An Phú Đông, Quận 12 - Tp.HCM',1,'')
GO

-- Nhập thông tin Khách hàng
insert into KhachHang
values('A1',N'Lê Thị Thu Hồng','0838919981','2100005409@nttu.edu.vn',N'Ấp Mỹ Hòa, H.Chợ Mới - T.An Giang','29/04/2003',0,'')
insert into KhachHang
values('A2',N'Lý Văn Lập','0984302291','210006075@nttu.edu.vn',N'Q.9 - Tp.HCM','23/09/2003',1,'')
insert into KhachHang
values('A3',N'Lê Huy Hoàng','0987784205','huyhoang1212.cke@gmail.com',N'Ninh Thới - H.Cầu Kè - T.Trà Vinh','12/12/2003',1,'')
insert into KhachHang
values('A4',N'Vũ Thị Ngọc Như','0963196203','2100003296@nttu.edu.vn',N'An Phú Đông - Q.12 - Tp.HCM','13/06/2003',0,'')
insert into KhachHang
values('A5',N'Lê Tiến Đạt','0868804528', 'ltdat@gmail.com',N'Q.10 - Tp.HCM', '09/12/2003',1,'')
insert into KhachHang
values('A6',N'Trịnh Minh Nhựt','0862269416','minhnhut2303@gmail.com',N'Ninh Thới - H.Cầu Kè - T.Trà Vinh','11/11/2003',1,'')
insert into KhachHang
values('A7',N'Nguyễn Trường Giang','0961114544','ntgiang@gmail.com',N'Phong Thạnh - H.Cầu Kè - T.Trà Vinh','05/12/2003',1,'')
insert into KhachHang
values('A8',N'Đỗ Hoàng Phúc','0328572011','dophuc@gmail.com',N'An Phú Đông - Q.12 - Tp.HCM','12/9/2003',1,'')
insert into KhachHang
values('A9',N'Trần Thị Khánh Nhi','0765152365','khanhnhi@gmail.com',N'An Phú Đông - Q.12 - Tp.HCM', '11/04/2003',0,'')
insert into KhachHang
values('B1',N'Tạ Nguyễn Phụng Kiều','0984302291','phungkieu@gmail.com',N'An Phú Đông - Q.12 - Tp.HCM','24/07/2003',0,'')
insert into KhachHang
values('B2',N'Trần Vĩnh Tín','0386691109','tranvinhtin@gmail.com',N'69 Sa Thầy - Huyện Sa Thầy - Tỉnh Kon Tum','24/08/2003',1,'')
GO

-- Nhập thông tin Bài viết
insert into BaiViet
values('AH1',N'Nhận xét Trái cây','~/Content/images/xoai_keo.jpg',N'Tươi.','13/04/2023',N' Đánh giá',N'','thuhong', 1)
insert into BaiViet
values('AH2',N'Cảm nhận về hương vị','~/Content/images/xoai_keo.jpg',N'Giòn ngọt.','12/01/2023',N' Đánh giá',N'','lehong', 1)
insert into BaiViet
values('AH3',N'Quá trình giao hàng','~/Content/images/man.jpg',N'Giao nhanh.','19/12/2022',N' Đánh giá',N'','thuhong', 1)
insert into BaiViet
values('AH4',N'Giá cả sản phẩm','~/Content/images/hanh.jpg',N'Hợp lí, không thách giá.','12/12/2022', N' Đánh giá', N'','ltth', 1)
insert into BaiViet
values('AH5',N'Chất lượng sản phẩm','~/Content/images/xa_lach.jpg',N'Sản phẩm sử dụng an toàn.','29/04/2022',N' Đánh giá',N'','ltth', 1)
insert into BaiViet
values('AH6',N'Đóng gói sản phẩm','~/Content/images/gung.jpg',N'Sản phẩm được đóng gói cẩn thận.','30/07/2022',N' Đánh giá',N'','thuhong', 1)
Go

-- Nhập thông tin loại Sản phẩm
insert into LoaiSP(tenLoai) values(N'Rau Lá')
insert into LoaiSP(tenLoai) values(N'Củ Quả')
insert into LoaiSP(tenLoai) values(N'Nấm')
insert into LoaiSP(tenLoai) values(N'Trái Cây')
go

-- Nhập thông tin Sản Phẩm
-- Nhập thông tin loại Rau Lá - mã loại 1
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K1',N'Xà Lách','~/Content/images/xa_lach.jpg', 
			  N'Thành phần: carbohydrate, chất xơ, nước, vitamin A, folate, giàu chất sắt, canxi, kẽm, đồng, kali, carotene, vitamin C,...', 
			  'thuhong','17000','3','1',N'Nguyên Khang Garden', N'250gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K2',N'Giá Đậu Xanh','~/Content/images/gia.jpg', 
			  N'Thành phần: 10 Kcal, vitamin C, vitamin E, chứa nhiều khoáng chất amino acid, protein.',
			  'thuhong','9600','5','1',N'OEM', N'200gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K3',N'Hành Lá','~/Content/images/hanh_la.jpg', 
			  N'Thành phần: 32.3 Kcal, cvitamin K, vitamin A, vitamin C, kali, canxi, chất xơ.', 
			  'thuhong','7500','5','1',N'OEM', N'100gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K4',N'Rau Diếp Cá','~/Content/images/diep_ca.jpg', 
			  N'Thành phần: 17 Kcal, vitamin A, vitamin B, các khoáng chất như sắt, kẽm, đồng, kali, chất xơ.', 
			  'thuhong','7100','3','1',N'Rau Cười Việt Nhật', N'100gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K5',N'Cải Thìa','~/Content/images/cai_thia.jpg', 
			  N'Thành phần: 16 Kcal, chất xơ, vitamin A, vitamin B, vitamin C và nhiều khoáng chất.', 
			  'thuhong','7900','4','1',N'OEM', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K6',N'Cải Ngọt','~/Content/images/cai_ngot.jpg', 
			  N'Thành phần: 17 Kcal, chất xơ, các vitamin A, vitamin B, vitamin C, kali, canxi, sắt.',
			  'thuhong','10500','5','1',N'Trường Phát', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K7',N'Rau Thơm','~/Content/images/rau_thom.jpg', 
			  N'Thành phần: 14 Kcal, chất xơ, sắt, canxi, magie,... cùng nhiều vitamin.', 
			  'thuhong','6100','5','1',N'OEM', N'100gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K8',N'Rau Muống','~/Content/images/rau_muong.jpg', 
			  N'Thành phần: chất xơ, protein, canxi, phốt pho, sắt, kẽm, các vitamin C, B1, B2.', 
			  'thuhong','9900','3','1',N'Vietgap', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K9',N'Rau Mồng Tơi','~/Content/images/rau_mong_toi.jpg', 
			  N'Thành phần: 22.9 Kcal, vitamin, kali, canxi, magie, đồng, sắt.',
			  'thuhong','12800','5','1',N'Rau Cười Việt Nhật', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K10',N'Rau Dền','~/Content/images/rau_den.jpg', 
			  N'Thành phần: 51 kcal, vitamin B1 và chất béo, vitamin C.', 
			  'thuhong','10500','4','1',N'Kinh Bắc', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K11',N'Cải Bó Xôi','~/Content/images/cai_bo_xoi.jpg', 
			  N'Thành phần: 23 Kcal, vitamin A, vitamin B, vitamin C cùng nhiều khoáng chất.',
			  'thuhong','5500','4','1',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K12',N'Bắp Cải Thảo','~/Content/images/bap_cai_thao.jpg', 
			  N'Thành phần: vitamin A, vitamin B, vitamin C, vitamin E, calcium, sắt, mangan, natri, kali , lipit, 24.6 Kcal.',
			  'thuhong','12500','5','1',N'OEM', N'600gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K13',N'Hẹ Lá','~/Content/images/he.jpg', 
			  N'Thành phần: chất xơ, vitamin A, vitamin C, canxi, phốt php, 30 Kcal.', 
			  'thuhong','6100','5','1',N'OEM', N'100gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K14',N'Cải Bẹ Xanh Baby','~/Content/images/cai_be_xanh.jpg', 
			  N'Thành phần: chất xơ, vitamin A, vitamin B, vitamin C, kali, canxi, sắt, 17Kcal.', 
			  'thuhong','13700','3','1',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K15',N'Ngò Gai, Rau Om','~/Content/images/rau_ngo.jpg', 
			  N'Thành phần: vitamin C, vitamin B1, vitamin B6, phốt pho, canxi, magie, 21 kcal.', 
			  'thuhong','5700','3','1',N'Trường Phát', N'100gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K16',N'Ớt Hiểm','~/Content/images/ot_hiem.jpg', 
			  N'Thành phần: vitamin C, vitamin B, sắt, canxi, phốt pho, 101 Kcal.',
			  'thuhong','7000','4','1',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K17',N'Rau Húng Quế','~/Content/images/hung_que.jpg', 
			  N'Thành phần: canxi, sắt, magie, kali, chất xơ, vitamin C, vitamin K,  22.5 Kcal.', 
			  'thuhong','6100','5','1',N'Rau Cười Việt Nhật', N'50gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K18',N'Ngò Rí','~/Content/images/ngo_ri.jpg', 
			  N'Thành phần: vitamin A, vitamin C, vitamin E, vitamin K, vitamin B6, vitamin B12, sắt, magie, kẽm, protein, chất béo, 17 Kcal.', 
			  'thuhong','5700','5','1',N'Trường Phát', N'100gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K19',N'Rau Ngót','~/Content/images/rau_ngot.jpg', 
			  N'Thành phần: chất xơ, vitamin A, vitamin B, vitamin C, 35 Kcal.',
			  'thuhong','18000','3','1',N'Vietgap', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K20',N'Bạc Hà','~/Content/images/bac_ha.jpg', 
			  N'Thành phần: phốt pho, kali, canxi, magie, đồng, sắt, protein và nước, 14 Kcal.', 
			  'thuhong','11400','4','1',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('K21',N'Cần Tây','~/Content/images/can_tay.jpg', 
			  N'Thành phần: chứa gần 95% nước cùng nhiều vitamin, protein và chất khoáng, vitamin K, chất xơ, 16 Kcal.', 
			  'thuhong','16000','3','1',N'OEM', N'250gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K22',N'Đậu Rồng','~/Content/images/dau_rong.jpg', 
			  N'Thành phần: sắt, canxi, chất xơ, magie, phốt pho, mangan, vitamin A, vitamin B, vitamin D, 49 Kcal.',
			  'thuhong','20000','3','1',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K23',N'Rau Má','~/Content/images/rau_ma.jpg', 
			  N'Thành phần: chất xơ, các vitamin A, vitamin B, vitamin C, 20 Kcal.',
			  'thuhong','9500','4','1',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K24',N'Rau Đắng','~/Content/images/rau_dang.jpg', 
			  N'Thành phần: sắt, kẽm, magie, đồng, các vitamin như vitamin A, vitamin B, vitamin C, chất xơ, chất đạm, 65 kcal.',
			  'thuhong','7600','5','1',N'OEM', N'100gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('K25',N'Sả Cây','~/Content/images/sa_cay.jpg', 
			  N'Thành phần: sắt, magie, kẽm, kali, mangan, vitamin C và vitamin A, 25 Kcal.', 
			  'thuhong','5900','6','1',N'An Lạc', N'200gram');
go
-- Nhập thông tin loại Củ, quả - mã loại 2
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T1',N'Gừng','~/Content/images/gung.jpg', 
			  N'Thành phần: vitamin C, vitamin B6, kali, đồng, mangan, phốt pho, sắt, 80 Kcal.', 
				'thuhong','5500','5','2',N'OEM', N'100gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T2',N'Dưa Leo','~/Content/images/dua_leo.jpg', 
			  N'Thành phần: nước, vitamin C, vitamin K, magie, mangan, kali, 15 Kcal.', 
				'thuhong','13000','4','2',N'OEM', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T3',N'Khoai Tây','~/Content/images/khoai_tay.jpg', 
			  N'Thành phần: tinh bột, chất xơ, protein, đường, các vitamin C, vitamin K, 77 Kcal.', 
			  'thuhong','16000','5','2',N'OEM', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T4',N'Khoai Lang','~/Content/images/khoai_lang_nhat.jpg', 
			  N'Thành phần: vitamin A, vitamin B6, vitamin C, vitamin E, chất xơ và tinh bột, 86 Kcal.',
			  'thuhong','34000','5','2',N'Vinamit', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu)  
              values('T5',N'Khoai Lang Mật','~/Content/images/khoai_lang_mat.jpg', 
			  N'Thành phần: Protein, Chất béo, Chất xơ, Vitamin A, Vitamin C, Vitamin B6, Kali, Axit pantothenic, Đồng, Niacin.', 
			  'thuhong','27000','12','2',N'OEM', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T6',N'Đậu Bắp','~/Content/images/dau_bap.jpg', 
			  N'Thành phần: chất xơ, chất béo, đường, các khoáng chất như magie, sắt, vitamin A, vitamin C, 3 Kcal.', 
			  'thuhong','8300','2','2',N'Dalatgap', N'250gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T7',N'Ớt Chuông Xanh','~/Content/images/ot_chuong_xanh.jpg', 
			  N'Thành phần: 92% là nước, đạm, vitamin A, vitamin C, vitamin K1, kali, canxi, 30.8 Kcal.', 
			  'thuhong','15000','','2',N'OEM', N'150gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T8',N'Ớt Chuông Đỏ','~/Content/images/ot_chuong_do.jpg', 
			  N'Nguyên liệu: chất đạm, vitamin A, vitamin C, vitamin K1, kali, canxi, 30.8 Kcal.', 
			  'thuhong','17000','','2',N'OEM', N'150gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T9',N'Cà Chua','~/Content/images/ca_chua_bi.jpg', 
			  N'Thành phần: vitamin A, vitamin C, vitamin K, kali, canxi, sắt, magie, 17.7 Kcal.', 
			  'thuhong','13200','4','2',N'Thảo Nguyên', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T10',N'Khổ Qua','~/Content/images/kho_qua.jpg', 
			  N'Thành phần: vitamin A, vitamin C, kali, canxi, phốt pho, kẽm, đồng, sắt, 34.4 kcal.', 
			  'thuhong','14900','3','2',N'An Lạc', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('T11',N'Bí Đỏ','~/Content/images/bi_do.jpg', 
			  N'Thành phần: vitamin A, Vitamin C, vitamin E, sắt, folate.', 
				'thuhong','18900','5','2',N'TNT Food', N'500gram' );
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T12',N'Củ Sắn','~/Content/images/cu_san.jpg', 
			  N'Thành phần:  tinh bột, đường glucose, protein,sắt, photpho, canxi và các vitamin A, vitamin C, vitamin B, 59 Kcal. ', 
			  'thuhong','20000','','2',N'An Lạc', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T13',N'Cà Rốt','~/Content/images/ca_rot.jpg',
			  N'Thành phần: Vitamin A, lutein và zeaxanthin, Vitamin B6, chất xơ, kali, magie, sắt, mangan dồi dào.', 
				'thuhong','19000','4','2',N'OEM', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T14',N'Củ Cải Trắng','~/Content/images/cu_cai.jpg',
			  N'Thành phần: chất xơ, protein, glucid, chất đạm,  canxi, photpho, sắt, vitamin, acid folic, 18.2 Kcal.', 
				'thuhong','19000','3','2',N'OEM', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('T15',N'Bông Cải Trắng','~/Content/images/bong_cai_trang.jpg', 
			  N'Thành phần: chứa chất xơ, vitamin B5, vitamin K, vitamin B6, photpho, mangan, magie, 25 Kcal.',
			  'thuhong','20000','12','2',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T16',N'Súp Lơ Xanh','~/Content/images/sup_lo_xanh.jpg', 
			  N'Thành phần: chất xơ, canxi, sắt, kali, magie, đường, photpho, protein, vitamin nhóm A, B, C.', 
			  'thuhong','29000','4','2',N'Rau Cười Việt Nhật', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T17',N'Súp Lơ Trắng','~/Content/images/sup_lo_trang.jpg', 
			  N'Thành phần: canxi, vitamin K và chất xơ rất dồi dào.', 
			  'thuhong','28000','5','2',N'Rau Cười Việt Nhật', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('T18',N'Củ Dền','~/Content/images/cu_den_baby.jpg', 
			  N'Thành phần: Vitamin A, C, E có lợi cho sức khỏe miễn dịch, còn chứa chất sulforaphane.', 
			  'thuhong','23500','3','2',N'Dalatgap', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T19',N'Su Hào','~/Content/images/su_hao.jpg', 
			  N'Thành phần: chất xơ, các vitamin C, vitamin A, vitamin K, vitamin E, sắt, canxi, manga, 27 Kcal.',
			  'thuhong','15000','7','2',N'CW', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T20',N'Đậu Cove','~/Content/images/dau_cove.jpg', 
			  N'Thành phần: canxi, vitamin K, magie, vitamin B6, vitamin B12, sắt, chất xơ, 73 Kcal.', 
			  'thuhong','17700','7','2',N'CW', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T21',N'Hành Tây','~/Content/images/hanh.jpg', 
			  N'Thành phần: nước, chất xơ và lượng nhỏ chất béo, vitamin và khoáng chất, 40 Kcal.', 
			  'thuhong','15000','5','2',N'CW', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('T22',N'Tỏi','~/Content/images/toi.jpg', 
			  N'Thành phần: iod và tinh dầu cao, (giàu glucogen, allicin và fitonxit), vitamin A,B,C,D, i-ốt, canxi, magie...', 
				'thuhong','20000','5','2',N'OEM', N'500gram');
go

-- Nhập thông tin loại Nấm - mã loại 3
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B1',N'Nấm Đùi Gà Baby','~/Content/images/nam_dui_ga.jpg', 
			  N'Thành phần: Vitamin B1, B6, E, 177 Kcal.',
			  'thuhong','30000','','3',N'OEM', N'200gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B2',N'Nấm Hương','~/Content/images/nam_huong.jpg', 
			  N'Thành phần: sắt, kali, canxi, chất xơ, vitamin B, vitamin A, vitamin D, 33.7 Kcal.',
			  'thuhong','28500','','3',N'OEM', N'150gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B3',N'Nấm Đông Trùng Hạ Thảo','~/Content/images/nam_dong_trung.jpg', 
			  N'Thành phần: axit amin, các vitamin B1, vitamin A, vitamin C,vitamin K, vitamin PP.',
			  'thuhong','59000','','3',N'OEM', N'150gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B4',N'Nấm Mỡ Nâu','~/Content/images/nam_mo_nau.jpg', 
			  N'Thành phần: Giàu vitamin và các khoáng chất quan trọng, 23 Kcal.',
			  'thuhong','28000','','3',N'OEM', N'200gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B5',N'Nấm Bào Ngư Trắng','~/Content/images/nam_bao_ngu1.jpg', 
			  N'Thành phần: vitamin B1, chất xơ, vitamin B3, vitamin B5, vitamin B6, kali, đồng, sắt, 33 Kcal.',
			  'thuhong','14100','','3',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B6',N'Nấm Kim Châm','~/Content/images/nam_kim_cham.jpg', 
			  N'Thành phần: chất xơ, protein, lipid, canxi, axit amin, 37 Kcal.',
			  'thuhong','13900','','3',N'OEM', N'150gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B7',N'Nấm Mỡ Trắng','~/Content/images/nam_mo_trang.jpg', 
			  N'Thành phần: β-glucan và protein, khoáng chất và vitamin.',
			  'thuhong','45000','','3',N'OEM', N'150gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B8',N'Nấm Rơm','~/Content/images/nam_rom.jpg', 
			  N'Thành phần: vitamin A, vitamin PP, vitamin B, vitamin C, vitamin D, canxi, sắt, photpho, 22 Kcal.',
			  'thuhong','28500','','3',N'OEM', N'220gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B9',N'Nấm Linh Chi Trắng','~/Content/images/nam_linh_chi1.jpg', 
			  N'Thành phần: protein, lipid, các vitamin nhóm B và các axit amin, 40 Kcal.',
			  'thuhong','27500','','3',N'OEM', N'150gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B10',N'Nấm Linh Chi Nâu','~/Content/images/nam_linh_chi2.jpg', 
			  N'Thành phần: protein, lipid và những loại khoáng chất, vitamin nhóm B, 19 Kcal.',
			  'thuhong','29000','','3',N'OEM', N'150gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B11',N'Nấm Bào Ngư Xám','~/Content/images/nam_bao_ngu_xam.jpg', 
			  N'Thành phần: vitamin B1, chất xơ, vitamin B3, vitamin B5, vitamin B6, kali, đồng, sắt, 33 Kcal.',
			  'thuhong','28000','','3',N'OEM', N'300gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT) 
              values('B12',N'Nấm Notaly','~/Content/images/nam_notaly.jpg', 
			  N'Thành phần: protein, chất xơ, chất β-glucan, axit gallic, axit chlorogenic,...',
			  'thuhong','18000','','3',N'OEM', N'200gram');
go

-- Nhập thông tin loại Trái Cây - mã loại 4
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H1',N'Đu Đủ','~/Content/images/du_du.jpg',
			  N'Thành phần: vitamin C, vitamin B, kali, folate.', 
				'thuhong','30500','5','4',N'Bốn Mùa', N'1000gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H2',N'Cam Sành','~/Content/images/cam_sanh.jpg',
			  N'Thành phần: vitamin C, các vitamin chống oxy hóa, canxi, natri, 47 kcal.', 
				'thuhong','29000','','4',N'Bốn Mùa', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H3',N'Kiwi','~/Content/images/kiwi.jpg', 
			  N'Thành phần: kali, folate và các vitamin C, vitamin K, Vitamin C.', 
				'thuhong','169000','','4',N'OEM', N'1000gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H4',N'Dưa Hấu Không Hạt','~/Content/images/hau_khong_hat.jpg',
			  N'Thành phần: nước, vitamin C, B5, A, 30.4 kcal', 
			  'thuhong','54000','3','4',N'Aeon Topvalu', N'2.3kg trở lên');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H5',N'Dưa Hấu Đỏ','~/Content/images/hau_do.jpg',
			  N'Thành phần: axit amin như citrulline và lycopene, citrulline.', 
			  'thuhong','25900','3','4',N'Aeon Topvalu', N'1.7kg trở lên');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H6',N'Lê Đường','~/Content/images/le_duong.jpg',
			  N'Thành phần: 50 kcal, đường, chất xơ, chất đạm, vitamin C, vitamin K, kali và một lượng nhỏ canxi, sắt, magie, riboflavin, vitamin B-6.', 
			  'thuhong','31000','4','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H7',N'Bưởi Da Xanh','~/Content/images/buoi_da_xanh.jpg',
			  N'Thành phần: chất xơ, vitamin C cùng những vitamin và khoáng chất khá, 38 kcal.', 
			  'thuhong','89000','','4',N'Aeon Topvalu', N'1.3kg - 1.5kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H8',N'Bưởi Năm Roi','~/Content/images/buoi_nam_roi.jpg',
			  N'Thành phần: chất xơ, chứa nhiều vitamin C cùng những vitamin và khoáng chất, 38 kcal', 
			  'thuhong','31000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H9',N'Quýt giống Úc','~/Content/images/quyt.jpg',
			  N'Thành phần: vitamin B1, vitamin B2 và lượng vitamin C, protein và canxi, 53 Kcal.', 
			  'thuhong','58000','3','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H10',N'Táo Ninh Thuận','~/Content/images/tao.jpg',
			  N'Thành phần: vitamin C rất cao, chứa chất chống oxy hóa cùng những khoáng chất khác, 85 - 90Kcal.', 
			  'thuhong','25000','','4',N'Aeon Topvalu', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H11',N'Thanh Long','~/Content/images/thanh_long.jpg',
			  N'Thành phần: protein, các nhóm vitamin B2, B3, C và chứa nhiều sắt, kali, phốt pho, 264 Kcal.', 
			  'thuhong','22000','','4',N'Aeon Topvalu', N'800gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H12',N'Sầu Riêng','~/Content/images/sau_rieng.jpg',
			  N'Thành phần: vitamin C, vitamin B, chất xơ và nhiều khoáng chất, 135 - 180 calo.', 
			  'thuhong','299000','','4',N'Aeon Topvalu', N'2.3kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H13',N'Nhãn Thái','~/Content/images/nhan.jpg',
			  N'Thành phần: Sắt, Magie, Kẽm, Kali, Photpho, Protein, chất béo, đường Sacaroza, Glucoza, vitamin A, vitamin C, axit hữu cơ và chất xơ, 60 Kcal.', 
			  'thuhong','28000','','4',N'Aeon Topvalu', N'500gram');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H14',N'Sapoche','~/Content/images/sapoche.jpg',
			  N'Thành phần: vitamin A, vitamin C, vitamin E, sắt, đồng, kẽm, axit amin, 83 Kcal.', 
			  'thuhong','35000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H15',N'Bơ','~/Content/images/bo.jpg',
			  N'Thành phần: vitamin, khoáng chất và chất chống oxy hóa, 160 calo.', 
			  'thuhong','34000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H16',N'Mít Thái','~/Content/images/mit.jpg',
			  N'Thành phần: chất xơ, chất béo, protein, vitamin C, canxi, kali, kẽm, magie, sắt, 96 Kcal.', 
			  'thuhong','34000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H17',N'Ổi Nữ Hoàng','~/Content/images/oi_nu_hoang.jpg',
			  N'Thành phần: giàu chất chống oxy hóa, Vitamin C, Kali và chất xơ, 36 - 50Kcal.', 
			  'thuhong','17000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H18',N'Dưa Lưới','~/Content/images/dua_luoi.jpg',
			  N'Thành phần: vitamin A, vitamin B, vitamin E, chất chống oxy hóa và nhiều khoáng chất, 34 - 40 kcal.', 
			  'thuhong','77000','','4',N'Aeon Topvalu', N'1.2kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H19',N'Chuối Già','~/Content/images/chuoi.jpg',
			  N'Thành phần: kali, chất xơ, vitamin, 88 Kcal.', 
			  'thuhong','33000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H20',N'Xoài Keo','~/Content/images/xoai_keo.jpg',
			  N'Thành phần: vitamin B, vitamin C, các khoáng chất như magie, natri, canxi, chất đạm, chất xơ, chất béo, đường, 82 Kcal.', 
			  'thuhong','23000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H21',N'Mận An Phước','~/Content/images/man.jpg',
			  N'Thành phần: vitamin c, vitamin A, các khoáng chất như sắt, canxi, natri, 24 Kcal.', 
			  'thuhong','24000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H22',N'Nho Đỏ','~/Content/images/man.jpg',
			  N'Thành phần: đường trái cây, chất xơ, vitamin C, vitamin  và vitamin B, 71 Kcal.', 
			  'thuhong','24000','','4',N'Aeon Topvalu', N'1kg');
go
insert into SanPham (MaSP, TenSP, HinhDD, NdTomTat, TaiKhoan, GiaBan, GiamGia, MaLoai, ThuongHieu, DVT)  
              values('H23',N'Nho Xanh Không Hạt Úc','~/Content/images/nho_xanh.jpg',
			  N'Thành phần: cung cấp vitamin và chất xơ, vitamin K, vitamin C, 67 Kcal.', 
			  'thuhong','85000','','4',N'Aeon Topvalu', N'500gram');
go

-- Nhập thông tin loại Đơn hàng
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ01','A1','thuhong', '12/04/2023', 1, '20/04/2023', N'Mỹ Luông - Huyện Chợ Mới - Tỉnh An Giang', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ02','A2','lethithuhong', '17/03/2023', 1, '27/03/2023', N'43/46 Vườn Lài - P.An Phú Đông - Q.12 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ03','A3','thuhong', '17/03/2023', 1, '20/03/2023', N'Q.12 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ04','A4','ltth', '19/02/2023', 1, '15/02/2023', N'Nguyễn Thái Sơn - Gò Vấp - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ05','A5','thuhong', '07/03/2023', 1, '15/03/2023', N'Q.10 - Tp.HCM', '');
go
insert into DonHang(SoDH, MaKH, TaiKhoan, NgayDat, DaKichHoat, NgayGH, DiachiGH, GhiChu)
			values('KZ06','B2','lethithuhong', '05/01/2023', 1, '13/01/2023', N'Huyện Tri Tôn - An Giang', '');
go

-- Nhập thông tin loại Chi tiết đơn hàng
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ01','B1','10','79900','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ02','B2','10','39800','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ03','B3','10','54000','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ04','B4','10','35600','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ05','B7','10','759000','20');
go
insert into CtDonHang(SoDH, MaSP, SoLuong, GiaBan, GiamGia)
			values('KZ06','K1','10','16200','20');
go
--Xuất dữ liệu--
select * from TaiKhoan
select * from KhachHang
select * from BaiViet
select * from LoaiSP
select * from SanPham
select * from DonHang
select * from CtDonHang