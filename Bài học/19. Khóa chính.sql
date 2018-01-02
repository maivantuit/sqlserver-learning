use Cop1_PhieuNopTien
go
---Cách 1:
create table SinhVien
(
	MaSV int identity primary key,
	TenSV nvarchar(50)
)
---Cách 2:
create table SinhVien2
(
	MaSV int identity ,
	TenSV nvarchar(50)
	primary key (MaSV)
)
---Cách 3:
create table SinhVien3
(
	MaSV int identity ,
	TenSV nvarchar(50)
	constraint PK_SinhVien3 primary key (MaSV)
)
---Cách 4. Tạo khóa chính cho table đã tạo.
create table SinhVien4
(
	MaSV int identity ,
	TenSV nvarchar(50)	
)
go
alter table SinhVien4 add primary key (MaSV)
--or
alter table SinhVien4 add constraint PK_SinhVien4 primary key (MaSV)

go
---Xóa khóa chính:
alter table SinhVien4 drop primary key--lệnh này k đc
--or:
alter table SinhVien4 drop constraint PK_SinhVien4
---Cách 5:
create table SinhVien5
(
	MaSV char(10) CONSTRAINT PK_SinhVien5 PRIMARY KEY not null,
	TenSV nvarchar(50)	
)
--Xóa khóa chính:
alter table SinhVien5 drop constraint PK_SinhVien5

select * from SinhVien4
drop table SinhVien5