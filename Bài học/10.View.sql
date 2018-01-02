use Cop1_PhieuNopTien
go
---View:Bảng ảo, dữ liệu bảng gốc thay đổi thì thay đổi theo.Sau sử dụng lại
--Tạo ra một bảng lưu thông tin KhachHang đã giao dịch 
select MaKH,GiaoDich.MaTK,HoTen,Email,NgayGio,LoaiGD,SoTien into BangThongKe from KhachHang ,GiaoDich
where KhachHang.MaTK=GiaoDich.MaTK
select * from BangThongKe
--Khi ta update vào bảng KhachHang:
update KhachHang set Email='nguyenvana@gmail.com'
where MaKH='KH002'
select * from BangThongKe-- Kq: Không thay đổi kết quả update trong bảng
select * from KhachHang--kq: Thay đổi kết qua update trong bảng
--=>Bảng vừa tạo ra là Bảng cứng, chỉ lấy sao chép dữ liệu từ bảng KhachHang. Khi bảng KhachHang thay đổi
--thì bảng BangThongKe không được thay đổi
--cách khắc phục là sử dụng View.
--Tạo ra 1 bảng BangThongKeView, nằm trong thư mục Views.
--Xóa bảng thống kê view trên
drop table BangThongKe
--tạo bảng view (2 dòng):
create view BangThongKeView as-- nó báo lỗi đỏ, kệ nó.
select * from KhachHang

--kiểm tra đã tạo chưa.
select * from BangThongKeView
--update vào bảng KhachHang.
update KhachHang set Email='nguyenvana@gmail.com'
where MaKH='KH002'
update KhachHang set Email='nguyenvand@gmail.com'
where MaKH='KH005'
--kiểm tra sự cùng thay đổi ở bảng KhachHang và BangThongKeView, thay đổi ở bảng BangThongKeView.
select * from KhachHang
select * from BangThongKeView

--Sửa bảng view như bảng bình thường: 
alter view BangThongKeView as
select HoTen from KhachHang
--Tạo view có dấu bỏ vào ngoặc vuông[]:
create view [Bảng Thông Kê View 2] as
select * from KhachHang
--Sử dụng:
select * from [Bảng Thông Kê View 2]
--Hủy view:
drop view BangThongKeView
drop view [Bảng Thông Kê View 2]