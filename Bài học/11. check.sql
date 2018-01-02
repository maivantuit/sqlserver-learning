use Cop1_PhieuNopTien
go
create table CheckDemo(
	id int primary key identity,
	Luong int check(Luong>=3000 and Luong<=9000)
)
go
insert into CheckDemo(Luong) values (10000)
insert into CheckDemo(Luong) values (7000)
insert into CheckDemo(Luong) values (4000)
insert into CheckDemo(Luong) values (8000)
--chèn 10000 không được.
--Kiểm tra:
select * from CheckDemo
---Check:
--Tạo ra khi tạo bảng ngay trong table: như trên
--Tạo ra với constraint
create table CheckDemo(
	id int primary key identity,
	Luong int,
	Constraint CK_Luong check(Luong>=3000 and Luong<=9000)
)
--Tạo khi thay đổi
alter table CheckDemo add constraint Luong
check(Luong>=3000 and Luong<=11000)

