use Cop1_PhieuNopTien
go
---Procedure Store: 
/*
- Là chương trình hay thủ tục, thủ tục lưu trữ, tái sử dụng thông qua tên thủ tục
- Thực hiện 1 nhiều thao tác, trả về 1 nhiều giá trị qua đối số(trả về bảng truy vấn kết quả)
- Ta có thể dùng Transaction-SQL EXCUTE (EXEC) để thực thi các stored procedure
- Stored procedure khác với các hàm xữ lý là giá trị trả về của chúng, hàm thì có giá trị trả về còn pro thì trả về bảng có truy vấn kết quả
- Không chứa trong tên và chung không được sử dụng trực tiếp trong biểu thức.
*/

/*
- Động: Có thể chỉnh sửa khối lệnh, tái sử dụng nhiều lần.
- Nhanh hơn: tự phân tích cú pháp cho tối ưu. Và tạo bản sao để lần chạy sau không cần thực thi lại từ dầu
- Bảo mật: Giới hạn quyền cho user nào sử dụng user nào không.
- Giảm bandvidth: Với các gói transaction lớn. Vài ngàn dòng lệnh một lúc thì store sẽ đảm bảo
*/ 

/*
--Cú Pháp:
create Produce <TênPro> 
	--khai báo đối số:[Paramter nếu có]
		IN [đầu vào] (biến)
		OUT [đầu ra] -- ghi output 
as
begin
	<code xữ lý>
end
Nếu chỉ là câu truy vấn thì có thể không cần begin end.
--thực thi:
execute TenThuTuc <các dữ liệu truyền vào xữ lý>
--Chỉnh sửa procedure store bằng alter.
*/
---Ví dụ 1:
--tạo thủ tục USP_Test
create procedure USP_Test
	@manv nvarchar(30), @luong int
as
begin	
	select * from NhanVien where MaNV=@manv and Luong=@luong
	--insert,update,delete
end
--Sử dụng, thực thi:
execute USP_Test @manv ='NV003', @luong=3000000	
--or:
execute USP_Test 'NV003', 3000000	
---Ví dụ 2:
go -- cho pro sau khỏi báo lỗi đỏ.
create procedure USP_Test2
as select *from NhanVien
go
--Sử dụng, thực thi:
execute USP_Test2
---Ví dụ 3: Tính tổng 2 số
alter proc TinhTong
	@a int,
	@b int

as
begin	
	declare @kq int
	set @kq=@a+@b
	print @kq
end
execute TinhTong 6,9--kq:15
---Ví dụ 4: Viết thủ tục tạo mới một nhân viên
go
alter proc TaoMoiNhanVien
	@manv char(5), @hoten nvarchar(30),@ngaysinh date, @luong int, @gioitinh nvarchar(10)
as
begin
	insert into NhanVien(MaNV,HoTen,NgaySinh,Luong,GioiTinh)
	values (@manv,@hoten,@ngaysinh,@luong,@gioitinh)
	if @@ROWCOUNT=1
	set @manv =@@IDENTITY
	else
		raiserror ('Tạo mới nhân viên bị lỗi',16,1)
end
go
--thực thi:
execute TaoMoiNhanVien @manv ='NV008',@hoten=N'Đạt Thành',@ngaysinh='12/24/1996', @luong=5000000,@gioitinh=	N'Nam'
execute TaoMoiNhanVien @manv ='NV009',@hoten=N'Trần Long',@ngaysinh='4/24/1997', @luong=7000000,@gioitinh=	N'Nữ'

--có thể thêm nhiều nhân viên khác, chỉ cần gọi lại thủ tục này và truyền dữ liệu
select * from NhanVien--đã được thêm vào.
---Ví dụ khác: tương ứng các truy vấn, để thực hiện thục tục=> kết quả được thay đổi trong table.
---Ví dụ 5: Viết thủ tục cập nhật tăng lương cho nhân viên có mã số là MaNV=NV001
go
alter procedure CapNhatNhanVien
	@manv char(5), @luong int
as
begin
	update NhanVien set Luong=@luong where MaNV=@manv
end 
execute CapNhatNhanVien @luong='21000000' ,@manv='NV001'
go
select * from NhanVien
---Ví dụ 6: viết thủ tục cập nhật toàn bộ thông tin của Nhân Viên có mã là NV002
go
create proc CapNhatNhanVien2
	@manv char(5), @hoten nvarchar(30), @ngaysinh date,@luong int, @gioitinh nvarchar(10)
as
begin
	update NhanVien set MaNV=@manv,HoTen=@hoten,NgaySinh=@ngaysinh,Luong=@luong,GioiTinh=@gioitinh where MaNV=@manv
	if @manv<>'NV002'
		begin
			raiserror ('Cập nhật nhân viên bị lỗi',16,1)
		end
end
exec CapNhatNhanVien2 @manv='NV003',@hoten=N'Trần Hải Minh Quân',@ngaysinh='03/30/1996',@luong='10000000',@gioitinh=N'Nam'
---Ví dụ 7: Viết thủ tục cập nhật 5 nhân viên có giới tính là nữ được cộng lương thêm 5trieu
---tạo biến trong thủ tục không được, chưa suy nghĩ kĩ