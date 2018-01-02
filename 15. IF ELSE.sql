use Cop1_PhieuNopTien
go
---IF Else
--tính số tiền trung bình trong giao dịch
--kiểm tra:
select * from GiaoDich
---Bài tập 1: Tính số tiền trung bình đã giao dịch.(sotientrungbinh=(sum(sotien)/soluonggiaodich))
--và xuất ra màn hình 2 giá trị: @sotientrungbinh(A) và @sotiencuakhachhangcuthe(B).
--so sánh nếu A>B A in ra lớn hơn B, A<B in ra A nhỏ hơn B.
declare @sotientrungbinh int
declare @soluonggiaodich int

select @soluonggiaodich =count(*) from GiaoDich
select	@sotientrungbinh= sum(SoTien)/@soluonggiaodich from GiaoDich
--kq:9400000
--Nếu số tiền của khách hàng có MaTK='TK001' giao dịch  > @sotientrungbinh
--thì xuất ra lớn và ngược lại
declare @matk char(5)='TK003'
declare @sotiencuakhachhangcuthe int =0
select @sotiencuakhachhangcuthe = SoTien from GiaoDich where MaTK = @matk

if @sotientrungbinh > @sotiencuakhachhangcuthe
	begin	
		print @sotientrungbinh
		print @sotiencuakhachhangcuthe
		print N'Số tiền trung bình lớn hơn số tiền của khách hàng cụ thể'
	end
	--nếu nhiều dòng lệnh thì bỏ begin end.
else
	begin	
		print @sotientrungbinh
		print @sotiencuakhachhangcuthe
		print N'Số tiền trung bình nhỏ hơn số tiền của khách hàng cụ thể'
	end
---Bài tập 2:
--Thêm thuộc tính Luong cho NhanVien
alter table NhanVien
	add  Luong int 
alter table NhanVien
	add  GioiTinh nvarchar(10) 
--kiểm tra:
select * from NhanVien
--Cập nhật thêm Lương cho mỗi nhân viên
update NhanVien set Luong=3000000 where MaNV='NV001'
update NhanVien set Luong=7000000 where MaNV='NV002'
--Cập nhật giới tính cho mỗi nhân viên:
update NhanVien set GioiTinh=N'Nữ' where MaNV='NV001'
update NhanVien set GioiTinh=N'Nam' where MaNV='NV002'
update NhanVien set GioiTinh=N'Nữ' where MaNV='NV003'
--Chèn thêm 1 Nhân Viên nữa:
insert into NhanVien(MaNV, HoTen, NgaySinh)
values ('NV003',N'Lan Hương','04/17/1996')
--update cho nhân viên Lan Hương:
update NhanVien set Luong=4000000 where MaNV='NV003'
---Nội dụng bài tập 2: Tính trung bình lương của các nhân viên. Tìm ra lương nhân viên lương thấp nhất và cao nhất.
declare @tongluong int
declare @tongnhanvien int
declare @luongtrungbinh int
--tính tổng lương các nhân viên
select @tongluong= sum(Luong) from NhanVien
--tính số nhân viên
select @tongnhanvien=count(*) from NhanVien
--
set @luongtrungbinh = @tongluong/@tongnhanvien
print 'Lương trung bình là: ' + cast(@luongtrungbinh as char(10))
-- tìm lương cao nhất, in ra màn hình.
declare @luongmax int
select max(Luong) from NhanVien
select @luongmax= max(Luong) from NhanVien
print @luongmax
-- tìm lương thấp nhất, in ra màn hình.
declare @luongmin int
select min(Luong) from NhanVien
select @luongmin= min(Luong) from NhanVien
print @luongmin

---Bài tập 3:Tính tổng lương trung bình của nhân viên.
--nếu lương trung bình > lương được gán là 9 triệu thì update 9tr cho nhân viên Nam
--còn lại update 9tr cho Nữ
declare @tongluong int
declare @tongnhanvien int
declare @luongtrungbinh int
--tính tổng lương các nhân viên
select @tongluong= sum(Luong) from NhanVien
--tính số nhân viên
select @tongnhanvien=count(*) from NhanVien
set @luongtrungbinh = @tongluong/@tongnhanvien
print 'Lương trung bình là: ' + cast(@luongtrungbinh as char(10))
declare @Luong int ='9000000'
if(@luongtrungbinh > @Luong)
	begin
		update NhanVien set Luong=@Luong
		where GioiTinh=N'Nam'
	end
else
	begin
		update NhanVien set Luong=@Luong
		where GioiTinh=N'Nữ'
	end
select * from NhanVien
---cập nhật dữ liệu làm sao rolback.