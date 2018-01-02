use Cop1_PhieuNopTien	
go
---Function:
--Cú pháp:
/*
	create function tenham(doiso<dauvao>)
	returns <kieudulieu>
	as
	begin
		return giatri<daura>
	end
*/
---Sử dụng alter để chạy lại function
---Khi thực thi function phải có dbo.Tenfuntion trước.
--Ví dụ 1: Trả về bảng nhân viên
create function TraDanhSachNhanVien()
returns table
as return select * from NhanVien
go
--thực thi:
select * from TraDanhSachNhanVien()
--Ví dụ 2: Truyền vào mã nhân viên trả ra lương
go
alter function Func2(@manv char(5))
returns int
as
begin
	declare @luong int
	select @luong =Luong from NhanVien where MaNV=@manv
	return @luong
end
--thực thi 1:
select dbo.Func2('NV001') from NhanVien
select * from NhanVien
--Thực thi 2:
print dbo.Func2('NV005')
--thực thi 3:
declare @kq int
set @kq=dbo.Func2('NV005')
print @kq
---Ví dụ 3: Tạo function tính một số truyền vào phải là số chẳn hay không
create function Func3(@number int)
returns nvarchar(20)
as
begin
	if(@number% 2=0)
	begin
		return N'Số chẵn'
	end
	else
	begin
		return N'Số lẻ'
	end
	return N'Không xác định'--return phải có xác định trong func
end

--thực thi:
print dbo.Func3('30')--số chẳn
---Ví dụ 4: Truyền vào ngày sinh cho biết tuổi
create function Func4(@ngaysinh date)
returns int
as
begin
	return year(getdate())-year(@ngaysinh)
end
--thực thi:
select dbo.Func4('19950330') as Tuoi-- 22 tuổi-- nhớ là yyyy/mm/dd
---Kiểm tra tuổi đó chẳn hay lẽ, sử dụng lại hàm Func3
select dbo.Func4(NgaySinh), dbo.Func3(dbo.Func4(NgaySinh)) from NhanVien