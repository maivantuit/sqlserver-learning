use Cop1_PhieuNopTien
go
---Declare và sử dụng biến: @tenbien: sử dụng truy vấn lồng quá dài dòng và khó hiểu, ta tạo biến và gọi lại dễ nhìn, ít rắc rối
select max(SoTien) from  GiaoDich where SoTien>10000
--Tạo ra một biến lưu @stien và sử dụng lại.
Declare @stien int 
select @stien= max(SoTien) from  GiaoDich where SoTien>10000
select @stien
print @stien
--khởi tạo với kiểu dữ liệu
declare @x int
--khởi tại với giá trị mặc định
declare @y int =10
--gán dữ liệu cho biến
set @x =@x+3
set @x+=2
--gán thông qua select
declare @stien2 int
select @stien2=max(SoTien) from GiaoDich where SoTien<6000
---VD1:Đếm số lượng khách hàng, in ra màn hình.(chưa có truy vấn lồng)

select count(*) from KhachHang

declare @sluong int
select @sluong=count(*) from KhachHang
--select @sluong
print @sluong-- in ra màn hình: kq=6
---VD2: Xuất ra mã và tên của khách hàng có chuyển tiền lớn nhất
--Kiểm tra:
select * from GiaoDich
select * from KhachHang

declare @makh char(5)
declare @tenkh nvarchar(30)
declare @sotienmax decimal(18, 0)

select @makh = MaKH from KhachHang 
select @tenkh = HoTen from KhachHang
select @sotienmax = max(SoTien) from GiaoDich where LoaiGD='C'

print  @makh
print  @tenkh
print  @sotienmax
--
--kq:/* KH006  Nguyễn Văn E 15000000*/
--Kiếm thêm ví dụ có truy vấn lòng. để dùng biến có hiệu quả hơn.
--VD3:
select  max(SoTien) from GiaoDich where LoaiGD='C'
--
declare @sotienmax2 decimal(18, 0)
select  @sotienmax2=max(SoTien) from GiaoDich where LoaiGD='C'
select (@sotienmax2) as SoTienMax from KhachHang, GiaoDich
where KhachHang.MaTK=GiaoDich.MaTK
print  @sotienmax2




