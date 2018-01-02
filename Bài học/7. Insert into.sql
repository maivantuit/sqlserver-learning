use Cop1_PhieuNopTien
go
---Insert into: copy dữ liệu ra bảng đã tồn tại.
--Tạo ra 1 bảng giống bảng bảng KhachHang mà không có dữ liệu trong đó,(dùng insert into + điều kiện 1=0)
select * into CloneKhachHang
from KhachHang
where 1=0
--Lấy dữ liệu từ bảng KhachHang sang bảng CloneKhachHang vừa tạo rỗng trên.
insert into CloneKhachHang select * from KhachHang
--kiểm tra:
select * from CloneKhachHang