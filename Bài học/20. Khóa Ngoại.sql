create database BaoGia
go 
use BaoGia
go
create table MatHang(
	MaMH char(10) primary key,
	TenMH nvarchar(50),
	ThuongHieu varchar(30),
	DonGia decimal,
	DonViTinh nvarchar(20)	
)
create table ThongSo(
	MaTS char(10) primary key,
	TenThongSo nvarchar(30)
)
create table ChiTietMatHang(
	MaMH char(10) NOT NULL CONSTRAINT FK_MatHang FOREIGN KEY references MatHang(MaMH),
	MaTS char(10) NOT NULL CONSTRAINT FK_ThongSo FOREIGN KEY references ThongSo(MaTS),
	GiaTriTT varchar(30)
)
select * from ChiTietMatHang
drop table MatHang -- xóa không được, do có ràng buộc với FOREIGN KEY constraint.
---Cách 1:
create table ChiTietMatHang2(
	---...
	foreign key (MaMH) references MatHang(MaMH)
)
---Cách 2:
create table ChiTietMatHang2(
	---...
	constraint FK_ChiTietMatHang2 foreign key (MaMH) 
	references MatHang(MaMH)
)
---Cách 3: Tạo khóa ngoại cho table đã tạo:
alter table ChiTietMatHang2 add foreign key(MaMH)
references references MatHang(MaMH)
--or:
alter table ChiTietMatHang2 add constraint FK_ChiTietMatHang2
foreign key (MaMH) references MatHang(MaMH)
---Xóa khóa ngoại:
alter table ChiTietMatHang2 drop foreign key FK_ChiTietMatHang2