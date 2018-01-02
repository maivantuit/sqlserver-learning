use CopDemo1_Database1
go
create table HoaDon
(
	MaHD char(10) constraint PK_HoaDon primary key,
	NgayGioGiaoHang datetime,
	DiaChiNhanHang nvarchar(100),
	ThanhTien decimal(18,1),
	HinhThucThanhToan nvarchar(50)
)
--
insert into HoaDon(MaHD,ThanhTien) values ('HD1',28000000)
insert into HoaDon(MaHD,ThanhTien) values ('HD2',38000000)
insert into HoaDon(MaHD,ThanhTien) values ('HD3',48000000)
insert into HoaDon(MaHD,ThanhTien) values ('HD4',88000000)
create table SanPham(
	MaSP char(10) constraint PK_SanPham primary key,
	TenSP nvarchar(50),
	DonGia decimal(18,1)
)
--
insert into SanPham values ('SP1',N'Iphone 6 plus',18600000)
insert into SanPham values ('SP2',N'LG',1200000)
insert into SanPham values ('SP3',N'Sam Sung S7',20600000)
insert into SanPham values ('SP4',N'Opp',10600000)
create table ChiTietHoaDon(
	MaHD char(10) constraint FK1_ChiTietHoaDon foreign key references HoaDon(MaHD),
	MaSP char(10) constraint FK2_ChiTietHoaDon foreign key references SanPham(MaSP),
	CONSTRAINT PK1_ChiTietHoaDon PRIMARY KEY (MaHD,MaSP),
	SoLuong int,
	ThanhTien decimal(18,1)	
)
insert into ChiTietHoaDon values ('HD1','SP1',29,29000000)
insert into ChiTietHoaDon values ('HD2','SP2',30,29000000)
insert into ChiTietHoaDon values ('HD1','SP1',2,19000000)--bị lỗi: bởi vì khi chèn dữ liệu:Không thể chèn khóa trùng lặp vào đối tượng 'dbo.ChiTietHoaDon'. Giá trị khóa trùng lặp là (HD1, SP1).
insert into ChiTietHoaDon values ('HD3','SP2',2,19000000)

select * from ChiTietHoaDon
drop table HoaDon