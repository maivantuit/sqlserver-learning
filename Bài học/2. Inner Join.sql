use Cop1_PhieuNopTien
go
---Inner join
--mọi join đều cần điều kiện "on".
--Viết tắt inner join = join
select * from  GiaoDich
 --kiểu cũ -> có thể sau này không được hổ trợ
select * from KhachHang, GiaoDich
where KhachHang.MaTK=GiaoDich.MaTK
--kiểu mới->
select * from KhachHang inner join GiaoDich
on KhachHang.MaTK=GiaoDich.MaTK
--kq 2 câu trên: 5 record- hàng
select * from KhachHang inner join NhanVien
on KhachHang.MaTK=NhanVien.MaNV
--kq: không ra, bởi vì bảng nhân viên và bảng Khách Hàng chưa kết nối, cần có 1 bảng trung gian là GiaoDich
select * from KhachHang,NhanVien,GiaoDich
where KhachHang.MaTK=GiaoDich.MaTK
and	NhanVien.MaNV=GiaoDich.MaNV
and NhanVien.MaNV='NV001'
--Inner Join: tác dụng kết hợp 2 bảng lại, lấy thuộc tính và trường giống nhau như hình vẽ:
