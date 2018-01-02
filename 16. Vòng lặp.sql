use Cop1_PhieuNopTien
go
create table Sach(
	id int,
	Name nvarchar(30),
	Gia int
)
drop table Sach
---Cú pháp:
--while dieukien
--begin
---cac lệnh lắp
--end
--chú ý: điều kiện bắt đầu, điều kiện dừng, bước nhảy. 
--ví dụ 1: in ra màn hình từ 1 đến 100
declare @i int =0
declare @n int =100
while (@i<=@n)
begin
	print @i
	set @i=@i+1
end
--ví dụ 2: chèn 100 quyển sách Java vào bảng Sach, với giá 45000 , id tăng dần từ 1 -> 100 
declare @i2 int =0
declare @n2 int =100
while (@i2<=@n2)
begin
	insert Sach(id,Name,Gia) values (@i2,N'Java',45000) set @i2=@i2+1
end
select *from Sach
--Ví dụ: update lại sách Java thay đổi giá thành 95000
declare @i3 int =0
declare @n3 int =100
while (@i3<=@n3)
begin
	update Sach set Name=N'Java' where Gia='95000' 
	set @i3=@i3+1
end
--tại sao update lại chạy không được
--update biên dịch  chạy hơi lâu xí.